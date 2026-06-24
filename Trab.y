%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

int sintatic_error_count = 0;
char g_analysis_trace[10000] = "[Lin:Col]\tACAO\tDETALHE\n";

extern int yylineno;
extern int column_number;
%}

%code requires {
    typedef struct Simbolo {
        int id;
        char lexema[100];
        int ocorrencias;
        char tipo;
        struct Simbolo *prox;
        int nivelEnv;
    } Simbolo;

    typedef struct Env {
        Simbolo *tabela;
        int nivel;
        struct Env *prev;
    } Env;

    typedef struct Ttype{
        char type;
        int width;
    } Ttype;
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
    void criarEnv();
    void fecharEnv(void);
    void addSimbolo(char *lexema, Ttype tipo);
    Simbolo* buscarSimboloEnv(char *lexema, Env *env);
    Simbolo* buscarSimboloGeral(char *lexema);
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
%token TD_BOOL "bool"

%token PR_IF "if"
%right OPEN_IF /* Correção etapa2: uso de precedência para dangling else */
%right PR_ELSE
%token PR_WHILE "while"
%token PR_PRINT "print"
%token PR_READ "read"
%token PR_RETURN "return"
%token PR_TRUE "true"
%token PR_FALSE "false"

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

%%

S:
    { criarEnv(); } //fechar so no final, deixar aberto enquanto fazemos o codigo
    elementos
    
; 

elementos:
    elementos elemento
    | elemento
    | elementos error ';' { yyerrok; }
    | elementos error '}' { yyerrok; }
    | error ';' { yyerrok; }
    | error '}' { yyerrok; }
; 

elemento:
    declaracao_funcao
    | comando
;

tipo_dado:
    TD_INTEGER      {$$.type = 'i'; $$.width = 4; tipoAtual = $$;}
    | TD_FLOAT      {$$.type = 'f'; $$.width = 8; tipoAtual = $$;}
    | TD_BOOL       {$$.type = 'b'; $$.width = 1; tipoAtual = $$;}
;

declaracao_variavel:
    tipo_dado lista_declaracao_variavel ';'
;

lista_declaracao_variavel:
    lista_declaracao_variavel ',' item_declaracao_variavel
    | item_declaracao_variavel
;

item_declaracao_variavel:
    ID                              {addSimbolo( $1->lexema, tipoAtual);}
    | ID OP_ATRIBUICAO expressao    {addSimbolo( $1->lexema, tipoAtual);}
;

atribuicao:
    ID OP_ATRIBUICAO expressao { verificarUsoID($1->lexema); }     
;

declaracao_funcao:
    tipo_dado ID '(' parametros ')' bloco
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
    tipo_dado ID
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
    '{'         { criarEnv(); printf ("\n{\n");}
    comandos
    '}'         { fecharEnv();  printf ("\n}\n");}
;

comandos:
    /* vazio */
    | comandos comando
    | comandos error ';' { yyerrok; /* Recuperação de erro em instruções com ponto e vírgula */ }
    | comandos error '}' { yyerrok; /* Recuperação de erro em fechamentos de blocos estruturados */ }
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
;

comando_entrada:
    PR_READ '(' ID ')' ';'
; 

comando_retorno:
    PR_RETURN expressao ';'
    | PR_RETURN ';'
;

expressao:
    expressao_ou
;

expressao_ou:
    expressao_ou OL_OR expressao_e
    | expressao_e
;

expressao_e:
    expressao_e OL_AND expressao_not
    | expressao_not
;

expressao_not:
    OL_NOT expressao_relacional
    | expressao_relacional
;

expressao_relacional:
    expressao_aritmetica operador_relacional expressao_aritmetica
    | expressao_aritmetica
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
    expressao_aritmetica OA_PLUS expressao_termo
    | expressao_aritmetica OA_MINUS expressao_termo
    | expressao_termo
;

expressao_termo:
    expressao_termo OA_MULT expressao_fator
    | expressao_termo OA_DIV expressao_fator
    | expressao_fator
;

expressao_fator:
    '(' expressao ')'
    | chamada_funcao
    | ID                { verificarUsoID($1->lexema); }
    | NUMERO_INT
    | NUMERO_FLOAT
    | LITERAL
    | PR_TRUE
    | PR_FALSE
    | OA_MINUS expressao_fator
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

    yyout = stdout;

    // --- Cabeçalho da análise léxica ---
    printf("===================================================================\n");
    printf("                        ANALISE LÉXICA\n");
    printf("===================================================================\n");
    fprintf(yyout, "%-4s %-4s %-20s %-25s\n", "LIN", "COL", "LEXEMA", "TOKEN");
    fprintf(yyout, "-------------------------------------------------------------\n");

    // Executa o lexer
    yyparse();

    // --- Imprime a tabela de símbolos após a análise léxica ---
    fprintf(yyout, "\nTABELA DE SÍMBOLOS\n");
    fprintf(yyout, "================================================================");
    imprimirTabela();  // função que percorre a lista de símbolos

    print_analise_sintatica(); // Imprime a tabela de análise sintática

    fclose(yyin);
    return (sintatic_error_count > 0) ? 1 : 0;
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
int proxIdSimbolo = 0; //Id global independente do escopo --------- VERIFICAR SE SERA O MESMO DO LEXICO


void criarEnv(){
    Env *novoEnv = (Env*) malloc(sizeof(Env));

    if (novoEnv == NULL){
        //Lança erro
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

Simbolo* usoDoIDEnv(char* lexema, Env* env){
    Simbolo *existe = buscarSimboloGeral(lexema);

    if(existe == NULL){
        printf("Erro: identificador '%existe' nao declarado.\n", lexema);
        return NULL;
    }

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

void addSimbolo(char* lexema, Ttype tipo){

    if (buscarSimboloEnv(lexema, envAtual) != NULL){
        //Erro de redeclaracao de variavel -------------- A CRIAR FUNCAO
    }
    Simbolo *novoSimbolo = (Simbolo*) malloc(sizeof(Simbolo));

    novoSimbolo->id = proxIdSimbolo++;
    strcpy(novoSimbolo->lexema, lexema);    
    novoSimbolo->tipo = tipo.type;
    novoSimbolo->ocorrencias = 0;
    novoSimbolo->prox = envAtual->tabela;

    envAtual->tabela = novoSimbolo;
}



