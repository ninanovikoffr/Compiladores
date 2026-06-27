%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdarg.h>

int yylex(void);
void yyerror(const char *s);

int sintatic_error_count = 0;
char g_analysis_trace[10000] = "[Lin:Col]\tACAO\tDETALHE\n";

int semantic_error_count = 0;
char g_semantic_trace[20000] = "[Lin:Col]\tERRO SEMANTICO\n";

extern int yylineno;
extern int column_number;
%}

%code requires {

    enum CategoriaId{
        variavel,
        funcao,
        parametro
    };

    typedef struct Ttype {
        char type;
        int width;
        char addr[100];
    } Ttype;

    typedef struct ParametroFuncao {
        Ttype ttype;
        struct ParametroFuncao *prox;

    } ParametroFuncao;


    typedef struct Simbolo {
        int id;
        char lexema[100];
        int ocorrencias;
        Ttype tipo;
        enum CategoriaId categoria;
        ParametroFuncao *parametrosFuncao;

        struct Simbolo *prox;
        int nivelEnv;
    } Simbolo;

    typedef struct Env {
        Simbolo *tabela;
        int nivel;
        struct Env *prev;
    } Env;

    typedef struct Funcao {
        Simbolo* simbolo;
        ParametroFuncao* parametroAtual;
        struct Funcao* funcaoAnterior;
        int valida;
    } Funcao;

}

%union {
    int inteiro;
    float pontoFlutante;
    char *texto;
    Simbolo *simbolo;
    Ttype tipoDado;
}

%code{
    Env* envAtual = NULL;
    Ttype tipoAtual;
    Ttype *tipoRetornoAtual = NULL;
    Funcao* funcaoDeclaracaoAtual = NULL;
    Funcao* funcaoChamadaAtual = NULL;

    void criarEnv();
    void fecharEnv();
    void addSimbolo(char *lexema, Ttype tipo, enum CategoriaId categoria);
    Funcao* empilharFuncao(Funcao *pilhaAtual, Simbolo *simbolo, int valida);
    void addParametro(Funcao *funcao, Ttype paramTtype);
    Funcao* desalocarFuncao(Funcao *pilhaAtual);
    int funcaoValida(Funcao *funcao);
    Simbolo* usoDoIDEnv(char *lexema);
    Simbolo* buscarSimboloEnv(char *lexema, Env *env);
    Simbolo* buscarSimboloGeral(char *lexema);

    char* newTemp(void);
    char* newLabel(void);
    void espacoCodigo(size_t caracteres);
    void gen(const char *formato, ...);
    void print_codigo_intermediario(void);

    void semanticError(const char *formato, ...);
    void print_analise_semantica();

    int eNumerico(Ttype tipo);
    Ttype tipoResultante(Ttype tipo1, Ttype tipo2, const char *operador);
}


/* Habilita mensagens de erro detalhadas (mostrando o que era esperado) */
%define parse.error verbose

/* Associação dos tokens a versões em português */
%token <simbolo> ID "identificador"
%token <inteiro> NUMERO_INT "numero inteiro"
%token <pontoFlutante> NUMERO_FLOAT "numero float"
%token <texto> LITERAL "literal"

%token TD_INTEGER "int"
%token TD_FLOAT "float"

%token PR_IF "if"
%right OPEN_IF /* Correção etapa2: uso de precedência para dangling else */
%right PR_ELSE
%token PR_WHILE "while"
%token PR_PRINT "print"
%token PR_READ "read"
%token PR_RETURN "return"

%token OA_PLUS "+"
%token OA_MINUS "-"
%token OA_MULT "*"
%token OA_DIV "/"
%token OA_MOD "%"
%token OR_LT "<"
%token OR_GT ">"
%token OR_EQ "=="
%token OR_LE "<="
%token OR_GE ">="
%token OR_NE "!="
%token OL_AND "&&"
%token OL_OR "||"
%token OL_NOT "!"
%token OP_ATRIBUICAO "="

%start S

%type <tipoDado> tipo_dado
%type <tipoDado> expressao
%type <tipoDado> expressao_e
%type <tipoDado> expressao_ou
%type <tipoDado> expressao_not
%type <tipoDado> expressao_fator
%type <tipoDado> expressao_termo
%type <tipoDado> expressao_aritmetica
%type <tipoDado> expressao_relacional
%type <tipoDado> chamada_funcao
%type <texto> operador_relacional
%type <texto> marca_if
%type <texto> marca_while

%%

S:
    { criarEnv(); } 
    elementos
    { /*fecharEnv(); */} //fechar so no final, deixar aberto enquanto fazemos o codigo
    
; 

elementos:
    elementos elemento
    | elemento
    | elementos error ';' { yyerrok; } //Desse jeito continua 11 erros sintaticos, com os outros vira 14
    //| elementos error '}' { yyerrok; } 
    //| error ';' { yyerrok; }
    //| error '}' { yyerrok; }
; 

elemento:
    declaracao_funcao
    | comando
;

tipo_dado:
    TD_INTEGER      {$$.type = 'i';$$.width = 4; $$.addr[0] = '\0'; tipoAtual = $$;} 
    | TD_FLOAT      {$$.type = 'f'; $$.width = 8; $$.addr[0] = '\0'; tipoAtual = $$;}
;

declaracao_variavel:
    tipo_dado lista_declaracao_variavel ';' // tipoAtual vai ser como o atributo herdado
;

lista_declaracao_variavel:
    lista_declaracao_variavel ',' item_declaracao_variavel
    | item_declaracao_variavel
;

item_declaracao_variavel:
    ID {
        addSimbolo($1->lexema, tipoAtual, variavel);
    }
    | ID OP_ATRIBUICAO expressao {
        if (tipoAtual.type == $3.type || (tipoAtual.type == 'f' && $3.type == 'i')) {
            addSimbolo($1->lexema, tipoAtual, variavel);
            gen("%s = %s", $1->lexema, $3.addr);
        } else {
            semanticError("Inicializacao incompativel. Variavel '%s' e tipo %c, mas recebeu tipo %c.",
                   $1->lexema, tipoAtual.type, $3.type);

            addSimbolo($1->lexema, tipoAtual, variavel); // Pra continuar a análise
        }
    }
;

atribuicao:
    ID OP_ATRIBUICAO expressao {

            Simbolo *existeS = usoDoIDEnv($1->lexema);

            if (existeS != NULL) {
                if (existeS->categoria == funcao) {
                    semanticError("identificador '%s' e uma funcao, nao pode ser usado em atribuicao.", $1->lexema);
                } else {
                    if (existeS->tipo.type == $3.type || (existeS->tipo.type == 'f' && $3.type == 'i')) {
                        gen("%s = %s", $1->lexema, $3.addr);
                    } else {
                        semanticError("atribuicao incompativel. Variavel '%s' e tipo %c, mas recebeu tipo %c.", $1->lexema, existeS->tipo.type, $3.type);
                    }
                }
            }
        }     
;

declaracao_funcao:
    tipo_dado ID            { Simbolo *jaDeclarada = buscarSimboloEnv($2->lexema, envAtual);
                            if (jaDeclarada != NULL) {
                                semanticError("identificador '%s' ja declarado neste escopo.", $2->lexema);
                                funcaoDeclaracaoAtual = empilharFuncao(funcaoDeclaracaoAtual, NULL, 0);
                                tipoRetornoAtual = NULL;
                            } else {
                                addSimbolo($2->lexema, tipoAtual, funcao);
                                funcaoDeclaracaoAtual = empilharFuncao(funcaoDeclaracaoAtual, buscarSimboloEnv($2->lexema, envAtual), 1);
                                tipoRetornoAtual = &funcaoDeclaracaoAtual->simbolo->tipo;
                            } }
    '('                                     { criarEnv(); } 
    parametros ')' '{' comandos '}'         { fecharEnv(); tipoRetornoAtual = NULL; funcaoDeclaracaoAtual = desalocarFuncao(funcaoDeclaracaoAtual); }
;  

parametros:
    lista_parametros
    | /* vazio */
;

lista_parametros:
    lista_parametros ',' parametro
    | parametro
;

parametro:
    tipo_dado ID            { if (buscarSimboloEnv($2->lexema, envAtual) != NULL) {
                                semanticError("identificador '%s' ja declarado neste escopo.", $2->lexema);
                            } else {
                                addSimbolo($2->lexema, tipoAtual, parametro);
                                addParametro(funcaoDeclaracaoAtual, tipoAtual);
                            } }
;

chamada_funcao:
    ID                  { Simbolo *jaExiste = usoDoIDEnv($1->lexema); 
                             if (jaExiste != NULL && jaExiste->categoria == funcao) {
                                funcaoChamadaAtual = empilharFuncao(funcaoChamadaAtual, jaExiste, 1);
                            } else {
                                if (jaExiste != NULL) {
                                    semanticError("Identificador '%s' nao e uma funcao.", $1->lexema);
                                }
                                funcaoChamadaAtual = empilharFuncao(funcaoChamadaAtual, jaExiste, 0);
                            }
                        }
    '('                 {
                        if (funcaoValida(funcaoChamadaAtual))
                            funcaoChamadaAtual->parametroAtual = funcaoChamadaAtual->simbolo->parametrosFuncao;
                        }
    argumentos ')'      {
        if (funcaoValida(funcaoChamadaAtual)) {
            if (funcaoChamadaAtual->parametroAtual != NULL) {
                semanticError("quantidade insuficiente de argumentos na chamada da funcao '%s'.", funcaoChamadaAtual->simbolo->lexema);
            }

            $$ = funcaoChamadaAtual->simbolo->tipo;
            $$.addr[0] = '\0'; // Inicializa o endereço como uma string vazia
        } else {
            $$.type = 'i';
            $$.width = 4; // setando um tipo só pra anlise continuar
            strcpy($$.addr, "0"); //valor seguro pro parser continuar
        }

        funcaoChamadaAtual = desalocarFuncao(funcaoChamadaAtual);
    }
;

argumentos:
    lista_argumentos
    | /* vazio */
;

/*Lógica da verificação de argumentos:
    parametroAtual == NULL e apareceu argumento -> argumento extra
    parametroAtual != NULL no fim da chamada -> argumento faltando
    parametroAtual == NULL no fim da chamada -> quantidade correta
 */

lista_argumentos:
    lista_argumentos ',' expressao      { if (funcaoValida(funcaoChamadaAtual)) {
                                                if (funcaoChamadaAtual->parametroAtual == NULL) {
                                                    semanticError("argumento extra na chamada da funcao '%s'", funcaoChamadaAtual->simbolo->lexema);
                                                } else {
                                                    if (!(funcaoChamadaAtual->parametroAtual->ttype.type == $3.type ||
                                                            (funcaoChamadaAtual->parametroAtual->ttype.type == 'f' && $3.type == 'i')))
                                                        semanticError("parametros imcompativeis para a funcao '%s'", funcaoChamadaAtual->simbolo->lexema);
                                                    funcaoChamadaAtual->parametroAtual = funcaoChamadaAtual->parametroAtual->prox;
                                                }
                                            }
                                        }
    | expressao                         { if (funcaoValida(funcaoChamadaAtual)) {
                                                if (funcaoChamadaAtual->parametroAtual == NULL) {
                                                    if (funcaoChamadaAtual->simbolo->parametrosFuncao == NULL) {
                                                        semanticError("a funcao '%s' nao recebe parametros.",funcaoChamadaAtual->simbolo->lexema);
                                                    } else {
                                                        semanticError("argumento extra na chamada da funcao '%s'.", funcaoChamadaAtual->simbolo->lexema);
                                                    }
                                                } else {
                                                    if (!(funcaoChamadaAtual->parametroAtual->ttype.type == $1.type ||
                                                            (funcaoChamadaAtual->parametroAtual->ttype.type == 'f' && $1.type == 'i')))
                                                        semanticError("parametros imcompativeis para a funcao '%s'", funcaoChamadaAtual->simbolo->lexema);
                                                    funcaoChamadaAtual->parametroAtual = funcaoChamadaAtual->parametroAtual->prox;
                                                }
                                            }
                                        }
;

bloco:
    '{'         { criarEnv();}
    comandos
    '}'         { fecharEnv();}
;

comandos:
    /* vazio */
    | comandos comando
    | comandos error ';' { yyerrok; } // Recuperação de erro em instruções com ponto e vírgula 
    | comandos error '}' { yyerrok; } // Recuperação de erro em fechamentos de blocos estruturados 
;

comando:
    atribuicao ';'
    | declaracao_variavel
    | chamada_funcao ';'
    | bloco
    | comando_saida
    | comando_entrada
    | comando_retorno
    | comando_repeticao
    | comando_condicional
;

comando_condicional:
    marca_if comando %prec OPEN_IF {
        gen("%s:", $1);
        free($1);
    }
    | marca_if comando PR_ELSE {
        char *labelFim = newLabel();

        gen("goto %s", labelFim);
        gen("%s:", $1);

        free($1);

        $<texto>$ = labelFim;
    } comando {
        gen("%s:", $<texto>4);
        free($<texto>4);
    }
;

marca_if:
    PR_IF '(' expressao ')' {
        if (!eNumerico($3)) {
            semanticError("condicao do if deve ser numerica.");
        }

        char *labelFalso = newLabel();

        gen("ifFalse %s goto %s", $3.addr, labelFalso);

        $$ = labelFalso;
    }
;

comando_repeticao:
    marca_while expressao ')' {
        if (!eNumerico($2)) {
            semanticError("condicao do while deve ser numerica.");
        }

        char *labelFim = newLabel();

        gen("ifFalse %s goto %s", $2.addr, labelFim);

        $<texto>$ = labelFim;
    }
    comando {
        gen("goto %s", $1);
        gen("%s:", $<texto>4);

        free($1);
        free($<texto>4);
    }
;

marca_while:
    PR_WHILE '(' {
        char *labelInicio = newLabel();

        gen("%s:", labelInicio);

        $$ = labelInicio;
    }
;

comando_saida:
    PR_PRINT '(' expressao ')' ';' {
        gen("print %s", $3.addr);
    }
    | PR_PRINT '(' LITERAL ')' ';' {
        gen("print %s", $3);
        free($3);
    }
;

comando_entrada:
    PR_READ '(' ID ')' ';' {
        Simbolo *s = usoDoIDEnv($3->lexema);

        if (s != NULL) {
            if (s->categoria == funcao) {
                semanticError("identificador '%s' e uma funcao, nao pode ser usado em read.", $3->lexema);
            } else {
                gen("read %s", $3->lexema);
            }
        }
    }
;

comando_retorno:
    PR_RETURN expressao {
        if (tipoRetornoAtual == NULL || !funcaoValida(funcaoDeclaracaoAtual)) {
        semanticError("Return fora de uma funcao.");
        }
        else if (!(tipoRetornoAtual->type == $2.type || (tipoRetornoAtual->type == 'f' && $2.type == 'i'))) {
            semanticError("Retorno da funcao incompativel. A funcao '%s' e tipo %c, mas o retorno e do tipo %c.",
                funcaoDeclaracaoAtual->simbolo->lexema, tipoRetornoAtual->type, $2.type);
        }
    }
    ';'
    | PR_RETURN ';' {
        if (tipoRetornoAtual == NULL || !funcaoValida(funcaoDeclaracaoAtual)) {
            semanticError("Return fora de uma funcao.");
        } else {
            semanticError("Retorno sem valor na funcao '%s', que e do tipo %c.", funcaoDeclaracaoAtual->simbolo->lexema, tipoRetornoAtual->type);
        }
    }
;

expressao:
    expressao_ou { $$ = $1; }
;

expressao_ou:
    expressao_ou OL_OR expressao_e {
        if (eNumerico($1) && eNumerico($3)) {
            $$.type = 'i';
            $$.width = 4;
        } else {
            semanticError("operador '||' exige operandos numericos.");
            $$.type = 'i';
            $$.width = 4;
        }

        char *temp = newTemp();
        gen("%s = %s || %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_e {
        $$ = $1;
    }
;

expressao_e:
    expressao_e OL_AND expressao_not {
        if (eNumerico($1) && eNumerico($3)) {
            $$.type = 'i';
            $$.width = 4;
        } else {
            semanticError("operador '&&' exige operandos numericos.");
            $$.type = 'i';
            $$.width = 4;
        }

        char *temp = newTemp();
        gen("%s = %s && %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_not {
        $$ = $1;
    }
;

expressao_not:
    OL_NOT expressao_relacional {
        if (eNumerico($2)) {
            $$.type = 'i';
            $$.width = 4;
        } else {
            semanticError("operador '!' exige operando numerico.");
            $$.type = 'i';
            $$.width = 4;
        }

        char *temp = newTemp();
        gen("%s = ! %s", temp, $2.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_relacional {
        $$ = $1;
    }
;

expressao_relacional:
    expressao_aritmetica operador_relacional expressao_aritmetica {
        if (($1.type == 'i' || $1.type == 'f') && ($3.type == 'i' || $3.type == 'f')) {
            $$.type = 'i';
            $$.width = 4;
        } else {
            semanticError("operador relacional exige int ou float.");
            $$.type = 'i';
            $$.width = 4;
        }

        char *temp = newTemp();
        gen("%s = %s %s %s", temp, $1.addr, $2, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_aritmetica {
        $$ = $1;
    }
;

operador_relacional:
    OR_LT { $$ = "<"; }
    | OR_GT { $$ = ">"; }
    | OR_EQ { $$ = "=="; }
    | OR_LE { $$ = "<="; }
    | OR_GE { $$ = ">="; }
    | OR_NE { $$ = "!="; }
;

expressao_aritmetica:
    expressao_aritmetica OA_PLUS expressao_termo {
        $$ = tipoResultante($1, $3, "+");

        char *temp = newTemp();
        gen("%s = %s + %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_aritmetica OA_MINUS expressao_termo {
        $$ = tipoResultante($1, $3, "-");

        char *temp = newTemp();
        gen("%s = %s - %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_termo {
        $$ = $1;
    }
;

expressao_termo:
    expressao_termo OA_MULT expressao_fator {
        $$ = tipoResultante($1, $3, "*");

        char *temp = newTemp();
        gen("%s = %s * %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_termo OA_DIV expressao_fator {
        $$ = tipoResultante($1, $3, "/");

        char *temp = newTemp();
        gen("%s = %s / %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_termo OA_MOD expressao_fator {
        if ($1.type == 'i' && $3.type == 'i') {
            $$.type = 'i';
            $$.width = 4;
        } else {
            semanticError("operador '%%' exige operandos int.");
            $$.type = 'i';
            $$.width = 4;
        }

        char *temp = newTemp();
        gen("%s = %s %% %s", temp, $1.addr, $3.addr);
        strcpy($$.addr, temp);
        free(temp);
    }
    | expressao_fator {
        $$ = $1;
    }
;


expressao_fator:
    '(' expressao ')'   {$$ = $2;}
    | chamada_funcao    {$$ = $1;}
    | ID                {
        Simbolo *jaExiste = usoDoIDEnv($1->lexema); 
        if (jaExiste != NULL){
            if(jaExiste->categoria == funcao){
                semanticError("identificador '%s' e uma funcao, nao pode ser usado como variavel.", $1->lexema);
            }
            $$ = jaExiste->tipo;
            strcpy($$.addr, $1->lexema);
        } 
        else {
            $$.type = 'i';
            $$.width = 4; 
            strcpy($$.addr, "0"); //valor seguro pro parser continuar
        }
    }
    | NUMERO_INT        {$$.type = 'i'; $$.width = 4; snprintf($$.addr, sizeof($$.addr), "%d", $1);}
    | NUMERO_FLOAT      {$$.type = 'f'; $$.width = 8; snprintf($$.addr, sizeof($$.addr), "%f", $1);} 
    | OA_MINUS expressao_fator {
        if ($2.type == 'i' || $2.type == 'f') {
            $$.type = $2.type;
            $$.width = $2.width;

            char *temp = newTemp();
            gen("%s = - %s", temp, $2.addr);
            strcpy($$.addr, temp);
            free(temp);
        } else {
            semanticError("operador - unario exige int ou float.");
            $$.type = 'i';
            $$.width = 4;
            strcpy($$.addr, "0");
        }
    }   
;

%%

extern FILE *yyin;
extern FILE *yyout;

int temp_cont = 1;
int label_cont = 1;

char *codInterm = NULL;
size_t capCodInterm = 0;
size_t tamCodInterm = 0;

void imprimirTabela(void);

// Funcao para imprimir tabela de analise sintatica 
void print_analise_sintatica(void) {
    printf("\n");
    printf("===================================================================\n");
    printf("                        ANALISE SINTATICA\n");
    printf("===================================================================\n");
    printf("[Lin:Col]\tACAO\tDETALHE\n");
    printf("-------------------------------------------------------------------\n");

    char* trace_copy = strdup(g_analysis_trace);
    if (!trace_copy) return;

    char* line = strtok(trace_copy, "\n");
    line = strtok(NULL, "\n");
    /* Pula cabecalho */

    while (line != NULL) {
        printf("%s\n", line);
        line = strtok(NULL, "\n");
    }

    free(trace_copy);
    printf("-------------------------------------------------------------------\n");
    if (sintatic_error_count == 0) {
        printf("Analise concluida com SUCESSO!\n");
    } else {
        printf("Analise concluida com %d erro(s).\n", sintatic_error_count);
    }
    printf("===================================================================\n");
}

void yyerror(const char *s) {
    char linha_formatada[1024];
    char mensagem_erro[1024];
    
    strncpy(mensagem_erro, s, sizeof(mensagem_erro) - 1);
    mensagem_erro[sizeof(mensagem_erro) - 1] = '\0';

    snprintf(linha_formatada, sizeof(linha_formatada), "[%03d:%03d]\tERRO\t%.800s\n", 
             yylineno, column_number, mensagem_erro);
             
    strcat(g_analysis_trace, linha_formatada);
    sintatic_error_count++;
}

// Etapa 3

void print_analise_semantica(void) {
    printf("\n");
    printf("===================================================================\n");
    printf("                        ANALISE SEMANTICA\n");
    printf("===================================================================\n");

    // Evita mensagem de erro semântico em cascata apos recuperacao de erro.
    if(sintatic_error_count > 0) {
        printf("Analise semantica nao realizada devido a erros sintaticos.\n");
        printf("===================================================================\n");
        return;
    }

    printf("[Lin:Col]\tERRO SEMANTICO\n");
    printf("-------------------------------------------------------------------\n");

    char* trace_copy = strdup(g_semantic_trace);
    if (!trace_copy) return;

    char* line = strtok(trace_copy, "\n");
    line = strtok(NULL, "\n");

    while (line != NULL) {
        printf("%s\n", line);
        line = strtok(NULL, "\n");
    }

    free(trace_copy);

    printf("-------------------------------------------------------------------\n");

    if (semantic_error_count == 0) {
        printf("Analise semantica concluida com SUCESSO!\n");
    } else {
        printf("Analise semantica concluida com %d erro(s).\n", semantic_error_count);
    }

    printf("===================================================================\n");
}

void semanticError(const char *formato, ...) {
    char mensagem[1024];
    char linha_formatada[1200];

    va_list args;
    va_start(args, formato);
    vsnprintf(mensagem, sizeof(mensagem), formato, args);
    va_end(args);

    snprintf(linha_formatada, sizeof(linha_formatada), "[%03d:%03d]\t%s\n", yylineno, column_number, mensagem);

    strncat(g_semantic_trace, linha_formatada, sizeof(g_semantic_trace) - strlen(g_semantic_trace) - 1);

    semantic_error_count++;
}

char* newTemp(void) {
    char *temp = malloc(20);

    sprintf(temp, "t%d", temp_cont);
    temp_cont++;

    return temp;
}

char* newLabel(void) {
    char *label = malloc(20);

    sprintf(label, "L%d", label_cont);
    label_cont++;

    return label;
}

void espacoCodigo(size_t caracteres){
    if (codInterm == NULL) {
        capCodInterm = 4096;
        tamCodInterm = 0;

        codInterm = malloc(capCodInterm);

        codInterm[0] = '\0'; //começa vazio
    }

    while (tamCodInterm + caracteres + 1 > capCodInterm) {
        capCodInterm += 4096;

        char *novo = realloc(codInterm, capCodInterm);
        codInterm = novo;

    }
}

void gen(const char *formato, ...) {
    char linha[1024];

    va_list args;
    va_start(args, formato);
    vsnprintf(linha, sizeof(linha), formato, args);
    va_end(args);

    espacoCodigo(strlen(linha) + 2);

    strcat(codInterm, linha);
    strcat(codInterm, "\n");

    tamCodInterm += strlen(linha) + 1;
}

void print_codigo_intermediario(void) {
    printf("\n");
    printf("===================================================================\n");
    printf("                    CODIGO INTERMEDIARIO\n");
    printf("===================================================================\n");

    if (sintatic_error_count > 0 || semantic_error_count > 0) {
        printf("Codigo intermediario nao gerado devido a erros anteriores.\n");
        printf("===================================================================\n");
        return;
    }

    if (codInterm == NULL || tamCodInterm == 0) {
        printf("Nenhuma instrucao de IR gerada.\n");
    } else {
        printf("%s", codInterm);
    }

    printf("===================================================================\n");
}

int eNumerico(Ttype tipo) {
    return (tipo.type == 'i' || tipo.type == 'f');
}

Ttype tipoResultante(Ttype tipo1, Ttype tipo2, const char *operador) {
    Ttype resultado;
    resultado.addr[0] = '\0'; // Inicializa o endereço como uma string vazia

    if (!eNumerico(tipo1) || !eNumerico(tipo2)) {
        semanticError("operador aritmetico '%s' exige operandos int ou float.", operador);

        resultado.type = 'i';
        resultado.width = 4;
        return resultado;
    }

    if (tipo1.type == 'f' || tipo2.type == 'f') {
        resultado.type = 'f';
        resultado.width = 8;
    } else {
        resultado.type = 'i';
        resultado.width = 4;
    }

    return resultado;
}

int proxIdSimbolo = 0; //Id global independente do escopo --------- VERIFICAR SE SERA O MESMO DO LEXICO


void criarEnv(){
    Env *novoEnv = (Env*) malloc(sizeof(Env));

    if (novoEnv == NULL){
        //Lança erro
        return;
    }
            
    novoEnv->prev = envAtual;
    novoEnv->tabela = NULL;

    if (envAtual != NULL) {
        novoEnv->nivel = envAtual->nivel + 1;
    } else {
        novoEnv->nivel =0;
    }

    envAtual = novoEnv;
}

void fecharEnv(){
    Env* envAFechar = envAtual;
    envAtual = envAFechar->prev;
    free(envAFechar);
}

Simbolo* usoDoIDEnv(char* lexema){
    Simbolo *existe = buscarSimboloGeral(lexema);

    if(existe == NULL){
        semanticError("identificador '%s' nao declarado.", lexema);
        return NULL;
    }
    existe->ocorrencias++;

    return existe;
}

Simbolo* buscarSimboloEnv(char* lexema, Env* env){ //Procura num env específico

    if (env != NULL){
        Simbolo *simbolo = env->tabela; //primeiro da lista
        while (simbolo != NULL){
            if (strcmp(lexema, simbolo->lexema) == 0){
                return simbolo;
            } else {
                simbolo = simbolo->prox;
            }
        }
    }
    return NULL;
}

Simbolo* buscarSimboloGeral(char* lexema){ //Procura em todos os envs
    Env *env = envAtual;
    Simbolo *encontrado;

    while(env!=NULL){
        if (env != NULL){
            encontrado = buscarSimboloEnv(lexema, env);
            if (encontrado != NULL){
                return encontrado;
                } else {
                env = env->prev;
                }
        }
    }

    return NULL;
} 

void addSimbolo(char* lexema, Ttype tipo, enum CategoriaId categoria){

    if (envAtual == NULL){
        semanticError("tentativa de adicionar simbolo '%s' sem escopo ativo.", lexema);
        return;
    }

    if (buscarSimboloEnv(lexema, envAtual) != NULL){
        semanticError("identificador '%s' ja declarado neste escopo.", lexema);
        return;
    }

    Simbolo *novoSimbolo = (Simbolo*) malloc(sizeof(Simbolo));

    if (novoSimbolo == NULL){
        semanticError("erro de alocacao de memoria para simbolo '%s'.", lexema);
        return;
    }

    novoSimbolo->id = proxIdSimbolo++;
    strcpy(novoSimbolo->lexema, lexema);    
    novoSimbolo->tipo = tipo;
    novoSimbolo->categoria = categoria;
    novoSimbolo->ocorrencias = 0;
    novoSimbolo->parametrosFuncao = NULL;
    novoSimbolo->nivelEnv = envAtual->nivel;
    novoSimbolo->prox = envAtual->tabela;

    envAtual->tabela = novoSimbolo;
}

Funcao* empilharFuncao(Funcao *pilhaAtual, Simbolo *simbolo, int valida) {
    Funcao *novaFuncaoAtual = (Funcao*) malloc(sizeof(Funcao));

    novaFuncaoAtual->simbolo = simbolo;
    novaFuncaoAtual->parametroAtual = NULL;
    novaFuncaoAtual->funcaoAnterior = pilhaAtual;
    novaFuncaoAtual->valida = valida;

    return novaFuncaoAtual;
}

void addParametro(Funcao* funcao, Ttype paramTtype){

    if (!funcaoValida(funcao)){
        return;
    }

    ParametroFuncao *novoParam = (ParametroFuncao*) malloc(sizeof(ParametroFuncao));    
    novoParam->ttype = paramTtype;
    novoParam->prox = NULL;

    if (funcao->simbolo->parametrosFuncao == NULL) {
        funcao->simbolo->parametrosFuncao = novoParam;
    } else {
        ParametroFuncao *atual = funcao->simbolo->parametrosFuncao;

        while (atual->prox != NULL) {
            atual = atual->prox;
        }
        atual->prox = novoParam;
    }

    funcao->parametroAtual = novoParam;
}

Funcao* desalocarFuncao(Funcao *pilhaAtual){
    if (pilhaAtual == NULL) {
        return NULL;
    }
    Funcao* funcaoAFechar = pilhaAtual;
    Funcao* proximaFuncao = funcaoAFechar->funcaoAnterior;
    free(funcaoAFechar);
    return proximaFuncao;
}

int funcaoValida(Funcao *funcao) {
    return funcao != NULL && funcao->valida && funcao->simbolo != NULL;
}

void print_analise_lexica(void) {
    yyout = stdout;
    printf("\n");
    printf("===================================================================\n");
    printf("                        ANALISE LÉXICA\n");
    printf("===================================================================\n");
    fprintf(yyout, "%-4s %-4s %-20s %-25s\n", "LIN", "COL", "LEXEMA", "TOKEN");
    fprintf(yyout, "-------------------------------------------------------------\n");

    // Executa o lexer
    yyparse();

    // Imprime a tabela de símbolos após a análise léxica
    fprintf(yyout, "\nTABELA DE SÍMBOLOS\n");
    fprintf(yyout, "================================================================");
    imprimirTabela();  // função que percorre a lista de símbolos
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s arquivo_entrada\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Erro ao abrir o arquivo: %s\n", argv[1]);
        return 1;
    }

    print_analise_lexica();       // Imprime a tabela de análise léxica
    print_analise_sintatica();    // Imprime a tabela de análise sintática
    print_analise_semantica();    // Imprime a tabela de análise semântica
    print_codigo_intermediario(); // Imprime o código intermediário

    fclose(yyin);

    if (sintatic_error_count > 0 || semantic_error_count > 0) {
        printf("\nCompilação com ERRO(S).\n");
        return 1;
    }
    else  {
        printf("\nCompilação concluída com SUCESSO.\n");
        return 0;
    }
}
