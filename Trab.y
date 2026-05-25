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
    char caractere;
    Simbolo *simbolo;
}

/* Habilita mensagens de erro detalhadas (mostrando o que era esperado) */
%define parse.error verbose

/* Associação dos tokens a versões legíveis em português (aliases) */
%token ID "identificador"
%token NUMERO_INT "numero inteiro"
%token NUMERO_FLOAT "numero float"
%token LITERAL "literal"

%token TD_INTEGER "int"
%token TD_FLOAT "float"
%token TD_BOOL "bool"

%token PR_IF "if"
%token PR_ELSE "else"
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
    comando_fechado
    | comando_aberto
;

comando_fechado:
    atribuicao ';'
    | declaracao_variavel
    | chamada_funcao ';'
    | bloco
    | comando_saida
    | comando_entrada
    | comando_retorno
    | matched_if
    | comando_repeticao_fechado
;

matched_if:
    PR_IF '(' expressao ')' comando_fechado PR_ELSE comando_fechado
;

comando_aberto:
    open_if
    | comando_repeticao_aberto
;

open_if:
    PR_IF '(' expressao ')' comando
    | PR_IF '(' expressao ')' comando_fechado PR_ELSE comando_aberto
;

comando_repeticao_fechado:
    PR_WHILE '(' expressao ')' comando_fechado
;

comando_repeticao_aberto:
    PR_WHILE '(' expressao ')' comando_aberto
;

comando_saida:
    PR_PRINT '(' expressao ')' ';'
;

comando_entrada:
    PR_READ '(' ID ')' ';' //verificar se so id
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
    char temp_str[1024];
    char error_msg[1024];
    
    strncpy(error_msg, s, sizeof(error_msg) - 1);
    error_msg[sizeof(error_msg) - 1] = '\0';

    char buffer_pt[1024] = {0};
    char *p;

    /* Traduz o prefixo padrao do bison verbose limitando o tamanho para o GCC não reclamar */
    if (strncmp(error_msg, "syntax error, unexpected ", 25) == 0) {
        snprintf(buffer_pt, sizeof(buffer_pt), "Erro sintatico: inesperado %.400s", error_msg + 25);
    } else if (strncmp(error_msg, "syntax error", 12) == 0) {
        snprintf(buffer_pt, sizeof(buffer_pt), "Erro sintatico%.400s", error_msg + 12);
    } else {
        strncpy(buffer_pt, error_msg, sizeof(buffer_pt));
    }

    /* Traduz a cláusula de tokens esperados */
    if ((p = strstr(buffer_pt, ", expecting "))) {
        char prefix[1024] = {0};
        strncpy(prefix, buffer_pt, p - buffer_pt);
        /* %.400s garante que nao ultrapasse o limite do buffer */
        snprintf(error_msg, sizeof(error_msg), "%.400s, esperado %.400s", prefix, p + 12);
    } else {
        strncpy(error_msg, buffer_pt, sizeof(error_msg));
    }

    /* Traduz todas as conjunções de alternância 'or' para 'ou' */
    while ((p = strstr(error_msg, " or "))) {
        char prefix[1024] = {0};
        strncpy(prefix, error_msg, p - error_msg);
        snprintf(buffer_pt, sizeof(buffer_pt), "%.400s ou %.400s", prefix, p + 4);
        strncpy(error_msg, buffer_pt, sizeof(error_msg));
    }

    /* %.800s garante pro compilador que a string de erro nunca estourará o limite global da linha */
    snprintf(temp_str, sizeof(temp_str), "[%03d:%03d]\tERRO\t%.800s\n", 
             yylineno, column_number, error_msg);
             
    strcat(g_analysis_trace, temp_str);
    sintatic_error_count++;
}