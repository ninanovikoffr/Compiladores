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
    } Ttype;

    typedef struct Simbolo {
        int id;
        char lexema[100];
        int ocorrencias;
        Ttype tipo;
        enum CategoriaId categoria;
        struct Simbolo *prox;
        int nivelEnv;
    } Simbolo;

    typedef struct Env {
        Simbolo *tabela;
        int nivel;
        struct Env *prev;
    } Env;

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
    Ttype tipoRetornoAtual;
    Simbolo* funcaoAtual;

    void criarEnv();
    void fecharEnv(void);
    void addSimbolo(char *lexema, Ttype tipo, enum CategoriaId categoria);
    Simbolo* usoDoIDEnv(char *lexema);
    Simbolo* buscarSimboloEnv(char *lexema, Env *env);
    Simbolo* buscarSimboloGeral(char *lexema);

    void semanticError(const char *formato, ...);
    void print_analise_semantica(void);

    int isNumeric(Ttype tipo);
    Ttype tipoAritmeticoResultante(Ttype tipo1, Ttype tipo2, const char *operador);
}


/* Habilita mensagens de erro detalhadas (mostrando o que era esperado) */
%define parse.error verbose

/* Associação dos tokens a versões em português */
%token <simbolo> ID "identificador"
%token NUMERO_INT "numero inteiro"
%token NUMERO_FLOAT "numero float"
%token LITERAL "literal"

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
    TD_INTEGER      {$$.type = 'i'; $$.width = 4; tipoAtual = $$;} 
    | TD_FLOAT      {$$.type = 'f'; $$.width = 8; tipoAtual = $$;}
;

declaracao_variavel:
    tipo_dado lista_declaracao_variavel ';' // tipoAtual vai ser como o atributo herdado
;

lista_declaracao_variavel:
    lista_declaracao_variavel ',' item_declaracao_variavel
    | item_declaracao_variavel
;

item_declaracao_variavel:
    ID                           {addSimbolo( $1->lexema, tipoAtual, variavel);}
    | ID OP_ATRIBUICAO expressao {
            if (tipoAtual.type == $3.type || (tipoAtual.type == 'f' && $3.type == 'i'))
            {
                addSimbolo($1->lexema, tipoAtual, variavel);
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
                if (existeS->tipo.type == $3.type || (existeS->tipo.type == 'f' && $3.type == 'i')) {
                    //ainda nao precisa fazer nada
                } else {
                    semanticError("atribuicao incompativel. Variavel '%s' e tipo %c, mas recebeu tipo %c.", $1->lexema, existeS->tipo.type, $3.type);
                }
            }
        }     
;

declaracao_funcao:
    tipo_dado ID                            { addSimbolo($2->lexema, tipoAtual, funcao); tipoRetornoAtual = tipoAtual; funcaoAtual = buscarSimboloGeral($2->lexema); }
    '('                                     { criarEnv(); } 
    parametros ')' '{' comandos '}'         { fecharEnv(); }
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
    tipo_dado ID            { addSimbolo($2->lexema, tipoAtual, parametro); }
;

chamada_funcao:
    ID '(' argumentos ')'
;

argumentos:
    lista_argumentos
    | /* vazio */
;

lista_argumentos:
    lista_argumentos ',' expressao
    | expressao
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
    PR_IF '(' expressao ')' comando %prec OPEN_IF // Correção etapa2: uso de precedência para dangling else
    | PR_IF '(' expressao ')' comando PR_ELSE comando
;

comando_repeticao:
    PR_WHILE '(' expressao ')' comando
;

comando_saida:
    PR_PRINT '(' expressao ')' ';'
    | PR_PRINT '(' LITERAL ')' ';'
;

comando_entrada:
    PR_READ '(' ID ')' ';'
; 

comando_retorno:
    PR_RETURN expressao {
        if (tipoRetornoAtual.type != $2.type)
            semanticError("Retorno da funcao incompativel. A funcao '%s' e tipo %c, mas o retorno e do tipo %c.",
                funcaoAtual->lexema, tipoRetornoAtual.type, $2.type);
        }
    ';'
    | PR_RETURN ';' {
        semanticError("Retorno sem valor na funcao , que e do tipo %c.",
            funcaoAtual->lexema,  tipoRetornoAtual.type);
    }
;

expressao:
    expressao_ou { $$ = $1; }
;

expressao_ou:
    expressao_ou OL_OR expressao_e {$$.type = 'i'; $$.width = 4;}
    | expressao_e { $$ = $1; }
;

expressao_e:
    expressao_e OL_AND expressao_not {$$.type = 'i'; $$.width = 4;}
    | expressao_not { $$ = $1; }
;

expressao_not:
    OL_NOT expressao_relacional {$$.type = 'i'; $$.width = 4;}
    | expressao_relacional { $$ = $1; }
;

expressao_relacional:
    expressao_aritmetica operador_relacional expressao_aritmetica {
            if (($1.type == 'i' || $1.type == 'f') && ($3.type == 'i' || $3.type == 'f')) {
                $$.type = 'i'; $$.width = 4; 
            } else {
                semanticError("operador relacional exige int ou float.");
                $$.type = 'i'; $$.width = 4;
            }
        }
    | expressao_aritmetica  { $$ = $1; }
;

operador_relacional:
    OR_LT
    | OR_GT
    | OR_EQ
    | OR_LE
    | OR_GE
    | OR_NE
;

expressao_aritmetica:
    expressao_aritmetica OA_PLUS expressao_termo {
        $$ = tipoAritmeticoResultante($1, $3, "+");
    }
    | expressao_aritmetica OA_MINUS expressao_termo {
        $$ = tipoAritmeticoResultante($1, $3, "-");
    }
    | expressao_termo {
        $$ = $1;
    }
;

expressao_termo:
    expressao_termo OA_MULT expressao_fator {
        $$ = tipoAritmeticoResultante($1, $3, "*");
    }
    | expressao_termo OA_DIV expressao_fator {
        $$ = tipoAritmeticoResultante($1, $3, "/");
    }
    | expressao_fator { $$ = $1; }
;


expressao_fator:
    '(' expressao ')'   {$$ = $2;}
    | chamada_funcao    {$$.type = 'i'; $$.width = 4; tipoAtual = $$;}
    | ID                {Simbolo *existeDenovo = usoDoIDEnv($1->lexema); 
                            if (existeDenovo != NULL){
                                $$ = existeDenovo->tipo;
                            } 
                            else {
                                $$.type = 'i';
                                $$.width = 4; //valor seguro pro parser continuar
                            }
                        }
    | NUMERO_INT        {$$.type = 'i'; $$.width = 4;}
    | NUMERO_FLOAT      {$$.type = 'f'; $$.width = 8;}
    //| LITERAL           {$$.type = 'i'; $$.width = 4; tipoAtual = $$;} 
    | OA_MINUS expressao_fator     {
                            if ($2.type == 'i' || $2.type == 'f') {
                                $$ = $2;
                            } else {
                                semanticError("operador - unario exige int ou float.");
                                $$.type = 'i';
                                $$.width = 4;
                            }
                        }
;

%%

extern FILE *yyin;
extern FILE *yyout;

void imprimirTabela(void);

/* Funcao para imprimir tabela de analise sintatica */
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

int isNumeric(Ttype tipo) {
    return (tipo.type == 'i' || tipo.type == 'f');
}

Ttype tipoAritmeticoResultante(Ttype tipo1, Ttype tipo2, const char *operador) {
    Ttype resultado;

    if (!isNumeric(tipo1) || !isNumeric(tipo2)) {
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
    novoSimbolo->nivelEnv = envAtual->nivel;
    novoSimbolo->prox = envAtual->tabela;

    envAtual->tabela = novoSimbolo;
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

    print_analise_lexica();    // Imprime a tabela de análise léxica
    print_analise_sintatica(); // Imprime a tabela de análise sintática
    print_analise_semantica(); // Imprime a tabela de análise semântica

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



