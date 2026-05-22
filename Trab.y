%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int yylex(void);
void yyerror(const char *s);

int tipo_atual = 0;
%}

%code requires {
    typedef struct Simbolo {
        int id;
        char lexema[100];
        int token;
        int ocorrencias;
        int tipo;
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

%type <inteiro> tipo_dado

%token <simbolo> ID
%token <inteiro> NUMERO_INT
%token <pontoFlutante> NUMERO_FLOAT
%token <texto> LITERAL

%token TD_INTEGER TD_FLOAT TD_BOOL

%token PR_IF PR_ELSE PR_WHILE
%token PR_PRINT PR_READ PR_RETURN
%token PR_TRUE PR_FALSE

%token OA_PLUS OA_MINUS OA_MULT OA_DIV
%token OR_LT OR_GT OR_EQ OR_LE OR_GE OR_NE
%token OL_AND OL_OR OL_NOT
%token OP_ATRIBUICAO

%start S

%%

S:
    elementos  
; 

elementos:
    elementos elemento
    | elemento
;

elemento:
    | declaracao_funcao
    | comando
;

tipo_dado:
    TD_INTEGER { $$ = TD_INTEGER; }
    | TD_FLOAT { $$ = TD_FLOAT; }
    | TD_BOOL  { $$ = TD_BOOL; }
;

declaracao_variavel:
    tipo_dado lista_declaracao_variavel ';'         { tipo_atual = $1; }
;

lista_declaracao_variavel:
    lista_declaracao_variavel ',' item_declaracao_variavel 
    | item_declaracao_variavel
;

item_declaracao_variavel:
    ID                                              { $1->tipo = tipo_atual; }
    | ID OP_ATRIBUICAO expressao                    { $1->tipo = tipo_atual; }
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
    lista_comandos comando
    | /* vazio */
;

lista_comandos:
    lista_comandos comando
    | comando
;

comando:
    atribuicao ';'
    | declaracao_variavel
    | chamada_funcao ';'
    | comando_condicional
    | comando_repeticao
    | comando_saida
    | comando_entrada
    | comando_retorno
;

comando_sem_if:
    atribuicao ';'
    | declaracao_variavel
    | chamada_funcao ';'
    | comando_repeticao
    | comando_saida
    | comando_entrada
    | comando_retorno
;

comando_condicional:
    matched_if
    | open_if
;  

matched_if:
    PR_IF '(' expressao ')' '{'matched_if '}' PR_ELSE '{' matched_if '}'
    | '{' comando_sem_if '}'
;

open_if:
    PR_IF '(' expressao ')' '{' comando_condicional '}'
    | PR_IF '(' expressao ')' '{' matched_if '}' PR_ELSE '{' open_if '}'
;

comando_repeticao:
    PR_WHILE '(' expressao ')' '{' comandos '}'
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

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s arquivo_entrada\n", argv[0]); //verificar
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Erro ao abrir o arquivo: %s\n", argv[1]);
        return 1;
    }

    yyout = stdout;

    fprintf(yyout, "%-4s %-4s %-20s %-25s\n", "LIN", "COL", "LEXEMA", "TOKEN");
    fprintf(yyout, "-------------------------------------------------------------\n");

    yyparse();

    imprimirTabela();

    fclose(yyin);

    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}