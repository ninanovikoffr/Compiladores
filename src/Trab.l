%option noyywrap yylineno

%{
/*------Definitions--------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.h"

int column_number = 1;

#define TAM_TABELA 101

Simbolo *tabela[TAM_TABELA];
unsigned int hash(const char *str);
Simbolo* buscarOuInserirSimbolo(const char *lexema);
void imprimirTabela();

%}

identificador		    "$"[a-zA-Z0-9]+
erroZeroInteiro         "-0"
erroZeroEsquerda        -?0[0-9]+
numeroInteiro		    (-?[0-9]+)
erroFloatNegativo       -[0-9]+("."[0-9]+)
numeroFloat             [0-9]+("."[0-9]+)?
ws					    [ \t\r]+
quebraLinha			    \n
comentario			    "//".*
comentarioPlus		    "/*"([^*]*|"*"+[^/*]+)*"*"+"/"
erroComentarioPlus      "/*"([^*]*|"*"+[^/*]+)*
literal				    \"[^"\n]*\"
erroLiteralAberto	    \"[^"\n]*
erroNumero			    -?[0-9]+,[0-9]+
erroIdentificador	    [a-zA-Z][a-zA-Z0-9]*
invalido			    .

%%
%{
/*------Rules--------*/
%}

"<"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OR_LT"); column_number += yyleng; return OR_LT; }
">"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OR_GT"); column_number += yyleng; return OR_GT; }
"=="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OR_EQ"); column_number += yyleng; return OR_EQ; }
"<="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OR_LE"); column_number += yyleng; return OR_LE; }
">="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OR_GE"); column_number += yyleng; return OR_GE; }
"!="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OR_NE"); column_number += yyleng; return OR_NE; }

{comentarioPlus}		{ column_number += yyleng; }
{comentario}			{ column_number += yyleng; }
{erroComentarioPlus}	{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: comentários de múltiplas linhas devem ser fechados com \"*/\""); column_number += yyleng; }

"+"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OA_PLUS"); column_number += yyleng; return OA_PLUS; }
"-"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OA_MINUS"); column_number += yyleng; return OA_MINUS; }
"*"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OA_MULT"); column_number += yyleng; return OA_MULT; }
"/"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OA_DIV"); column_number += yyleng; return OA_DIV; }

"&&"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OL_AND"); column_number += yyleng; return OL_AND; }
"||"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OL_OR"); column_number += yyleng; return OL_OR; }
"!"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OL_NOT"); column_number += yyleng; return OL_NOT; }

"if"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_IF"); column_number += yyleng; return PR_IF; }
"else"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_ELSE"); column_number += yyleng; return PR_ELSE; }
"while"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_WHILE"); column_number += yyleng; return PR_WHILE; }
"print"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_PRINT"); column_number += yyleng; return PR_PRINT; }
"read"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_READ"); column_number += yyleng; return PR_READ; }
"return"				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_RETURN"); column_number += yyleng; return PR_RETURN; }
"true"		    		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_TRUE"); column_number += yyleng; return PR_TRUE; }
"false"	    			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PR_FALSE"); column_number += yyleng; return PR_FALSE; }

"int"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TD_INTEGER"); column_number += yyleng; return TD_INTEGER; }
"float"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TD_FLOAT"); column_number += yyleng; return TD_FLOAT; }
"bool"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TD_BOOL"); column_number += yyleng; return TD_BOOL; }

"="                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OP_ATRIBUICAO"); column_number += yyleng; return OP_ATRIBUICAO; }

{erroZeroInteiro}       { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: o valor zero não pode ser negativo"); column_number += yyleng; }
{erroZeroEsquerda}      { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: 0 a esquerda"); column_number += yyleng; }
{erroFloatNegativo}     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: pontos flutuantes não podem assumir valores negativos"); column_number += yyleng; }
{numeroInteiro}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "NUMERO_INTEIRO"); column_number += yyleng; yylval.inteiro = atoi(yytext); return NUMERO_INT; }
{numeroFloat}           { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "NUMERO_FLOAT"); column_number += yyleng; yylval.pontoFlutante = atof(yytext); return NUMERO_FLOAT; }
{identificador}         { yylval.simbolo = buscarOuInserirSimbolo(yytext); char token_id[25]; sprintf(token_id, "ID_%d", yylval.simbolo->id); fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, token_id); column_number += yyleng; return ID; }

";"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return ';'; }
","                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return ','; }
"("                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return '('; }
")"                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return ')'; }
"{"                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return '{'; }
"}"                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return '}'; }

{literal}				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "LITERAL"); yylval.texto = strdup(yytext); column_number += yyleng; return LITERAL; }
{quebraLinha}			{ column_number = 1; }
{ws}					{ column_number += yyleng; }
{erroLiteralAberto}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: literais devem ser fechados com aspas"); column_number += yyleng; }
{erroNumero}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: pontos flutuantes devem usar \".\" e não \",\""); column_number += yyleng; }
{erroIdentificador}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: identificadores devem começar com \"$\""); column_number += yyleng; }
{invalido}				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: caractere inválido"); column_number += yyleng; }
%%
/*------User subrotines--------*/

static int proximo_id = 1;

unsigned int hash(const char *str) {
    unsigned int h = 0;

    while (*str) {
        h = h * 31 + (unsigned char)(*str);
        str++;
    }

    return h % TAM_TABELA;
}

Simbolo* buscarOuInserirSimbolo(const char *lexema) {
    unsigned int indice = hash(lexema);
    Simbolo *atual = tabela[indice];

    while (atual != NULL) {
        if (strcmp(atual->lexema, lexema) == 0) {
            atual->ocorrencias++;
            return atual;
        }
        atual = atual->prox;
    }

    Simbolo *novo = malloc(sizeof(Simbolo));
    novo->id = proximo_id++;
    strcpy(novo->lexema, lexema);
    //novo->token = ID;
    novo->ocorrencias = 1;
    novo->prox = tabela[indice];
    tabela[indice] = novo;
	return novo;
}

void imprimirTabela() {
    printf("\n%-4s %-6s %-20s %-10s %-12s\n", "ID", "HASH", "LEXEMA", "TOKEN", "QUANT. OCORRENCIAS");
    printf("-----------------------------------------------------------------\n");

    for (int i = 0; i < TAM_TABELA; i++) {
        Simbolo *atual = tabela[i];

        while (atual != NULL) {
            printf("%-4d %-6d %-20s %-10s %-12d\n",
                   atual->id,
                   i,
                   atual->lexema,
                   "ID",
                   atual->ocorrencias);
            atual = atual->prox;
        }
    }
}
