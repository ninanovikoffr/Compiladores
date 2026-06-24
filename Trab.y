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
        int token;
        int ocorrencias;
        struct Simbolo *prox;
    } Simbolo;
}

%union {
    int inteiro;
    float pontoFlutante;
    char *texto;
    Simbolo *simbolo;
}

/* Habilita mensagens de erro detalhadas (mostrando o que era esperado) */
%define parse.error verbose

/* Associação dos tokens a versões em português */
%token ID "identificador"
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

%%

S:
    elementos
; 

elementos:
    elementos elemento
    | elemento
    | error ';' { yyerrok; /* Ignora erro na raiz até encontrar um ponto e vírgula */ }
; 

elemento:
    declaracao_funcao
    | comando
;

tipo_dado:
    TD_INTEGER
    | TD_FLOAT
    | TD_BOOL
;

declaracao_variavel:
    tipo_dado lista_declaracao_variavel ';'
;

lista_declaracao_variavel:
    lista_declaracao_variavel ',' item_declaracao_variavel 
    | item_declaracao_variavel
;

item_declaracao_variavel:
    ID
    | ID OP_ATRIBUICAO expressao
;

atribuicao:
    ID OP_ATRIBUICAO expressao
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
    '{' comandos '}'
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
    | ID
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

Env* envAtual;

typedef struct Env {
    Simbolo *tabela;
    int nivel;
    struct Env *prev;
} Env;

void criarEnv(){
    Env *novoEnv = (Env*) malloc(sizeof(Env));
    novoEnv->prev = envAtual;
    if (envAtual != NULL) {
        novoEnv->nivel = envAtual->nivel + 1;
    }
    envAtual = novoEnv;
}

void addSimmbolo(){
    
}


