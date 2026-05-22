%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int yylex(void);
void yyerror(const char *s);
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

%token <simbolo> IDENTIFICADOR
%token <inteiro> NUMERO_INT
%token <pontoFlutante> NUMERO_FLOAT
%token <texto> LITERAL

%%

S:
    elementos  
; 

elementos:
    elementos elemento
    | elemento
;

elemento:
    declaracao_variavel
    | declaracao_funcao
    | comando
;

tipo_dado:
    INT
    | FLOAT
    | BOOL
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
    | ID '=' expressao
;

atribuicao:
    ID '=' expressao
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
    | chamada_funcao ';'
;

comando_sem_if:
    atribuicao ';'
    | declaracao_variavel
    | chamada_funcao ';'
    | comando_repeticao
    | comando_saida
    | comando_entrada
    | comando_retorno
    | chamada_funcao ';'

comando_condicional:
    matched_if
    | open_if
;  

matched_if:
    IF '(' expressao ')' '{'matched_if '}' ELSE '{' matched_if '}'
    | '{' comando_sem_if '}'
;

open_if:
    IF '(' expressao ')' '{' comando_condicional '}'
    | IF '(' expressao ')' '{' matched_if '}' ELSE '{' open_if '}'
;

comando_repeticao:
    WHILE '(' expressao ')' '{' comandos '}'
;

comando_saida:
    PRINT '(' expressao ')' ';'
;

comando_entrada:
    READ '(' ID ')' ';' //verificar se so id
; 

comando_retorno:
    RETURN expressao ';'
    | RETURN ';'
;

expressao:
    expressao_ou
;

expressao_ou:
    expressao_ou OR expressao_e
    | expressao_e
;

expressao_e:
    expressao_e AND expressao_not
    | expressao_not
;

expressao_not:
    NOT expressao_relacional
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
    | NUM_INT
    | NUM_FLOAT
    | PR_TRUE
    | PR_FALSE
    | OA_MINUS expressao_fator
;



%%

int main() {
    yyparse();
    // entrada e saida padrões (terminal)
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}