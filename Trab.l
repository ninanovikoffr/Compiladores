%option noyywrap yylineno

%{
/*------Definitions--------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int column_number = 1;

#define TAM_TABELA 101

typedef struct Simbolo {
    char lexema[100];
    int token;
    int ocorrencias;
    struct Simbolo *prox;
} Simbolo;

Simbolo *tabela[TAM_TABELA];
unsigned int hash(const char *str);
Simbolo* buscarOuInserirSimbolo(const char *lexema);
void imprimirTabela();

typedef union {
    int inteiro;
    char *texto;
    char caractere;
    Simbolo *simbolo;
} TYPE;

TYPE yylval;

//Tokens
#define LITERAL                 10
#define DELIMITADOR				11
#define OPERADOR_RELACIONAL 	12
#define OPERADOR_ARITMETICO		13
#define OPERADOR_LOGICO    		14
#define TIPO_DADO				16
#define NUMERO_INT				17
#define NUMERO_FLOAT			15
#define IDENTIFICADOR			18
#define COMENTARIO				19

//Tipos de dados
#define TD_INTEGER  	        21
#define TD_FLOAT		        22

//Palavras reservadas
#define PR_IF			        31
#define PR_ELSE			        32
#define PR_WHILE		        33
#define PR_PRINT		        34
#define PR_READ			        35
#define PR_RETURN               36

//Operadores lógicos
#define OL_AND			        41
#define OL_OR			        42
#define OL_NOT			        43

//Operadores aritméticos
#define OA_PLUS			        51
#define OA_MINUS		        52
#define OA_MULT		            53
#define OA_DIV                  54

//Operadores relacionais
#define OR_LT			        61
#define OR_GT			        62
#define OR_EQ			        63
#define OR_LE			        64
#define OR_GE			        65
#define OR_NE			        66

//Operador de atribuição
#define OPERADOR_ATRIBUICAO     71

%}

delim				[;,(){}]
identificador		"$"[a-zA-Z0-9]+
erroZeroInteiro     "-0"
erroZeroEsquerda    -?0[0-9]+
numeroInteiro		(-?[0-9]+)
erroFloatNegativo   -[0-9]+("."[0-9]+)
numeroFloat         [0-9]+("."[0-9]+)?
ws					[ \t]
quebraLinha			\n
comentario			"//".*
comentarioPlus		"/*"([^*]*|"*"+[^/*]+)*"*"+"/"
erroComentarioPlus  "/*"([^*]*|"*"+[^/*]+)*
literal				\"[^"\n]*\"
erroLiteralAberto	\"[^"\n]*
erroNumero			-?[0-9]+,[0-9]+
erroIdentificador	[a-zA-Z][a-zA-Z0-9]*
invalido			.

%%
%{
/*------Rules--------*/
%}

"<"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; yylval.inteiro = OR_LT; return OPERADOR_RELACIONAL; }
">"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; yylval.inteiro = OR_GT; return OPERADOR_RELACIONAL; }
"=="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; yylval.inteiro = OR_EQ; return OPERADOR_RELACIONAL; }
"<="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; yylval.inteiro = OR_LE; return OPERADOR_RELACIONAL; }
">="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; yylval.inteiro = OR_GE; return OPERADOR_RELACIONAL; }
"!="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; yylval.inteiro = OR_NE; return OPERADOR_RELACIONAL; }

{comentarioPlus}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "COMENTARIO"); column_number += yyleng; return COMENTARIO; }
{comentario}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "COMENTARIO"); column_number += yyleng; return COMENTARIO; }
{erroComentarioPlus}	{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: comentários de múltiplas linhas devem ser fechados com \"*/\""); column_number += yyleng; }

"+"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; yylval.inteiro = OA_PLUS; return OPERADOR_ARITMETICO; }
"-"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; yylval.inteiro = OA_MINUS; return OPERADOR_ARITMETICO; }
"*"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; yylval.inteiro = OA_MULT; return OPERADOR_ARITMETICO; }
"/"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; yylval.inteiro = OA_DIV; return OPERADOR_ARITMETICO; }

"&&"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_LOGICO"); column_number += yyleng; yylval.inteiro = OL_AND; return OPERADOR_LOGICO; }
"||"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_LOGICO"); column_number += yyleng; yylval.inteiro = OL_OR; return OPERADOR_LOGICO; }
"!"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_LOGICO"); column_number += yyleng; yylval.inteiro = OL_NOT; return OPERADOR_LOGICO; }

"if"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PR_IF; }
"else"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PR_ELSE; }
"while"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PR_WHILE; }
"print"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PR_PRINT; }
"read"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PR_READ; }
"return"				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PR_RETURN; }

"int"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TIPO_DADO"); column_number += yyleng; yylval.inteiro = TD_INTEGER; return TIPO_DADO; }
"float"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TIPO_DADO"); column_number += yyleng; yylval.inteiro = TD_FLOAT; return TIPO_DADO; }

"="                     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ATRIBUICAO"); column_number += yyleng; return OPERADOR_ATRIBUICAO; }

{erroZeroInteiro}       { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: o valor zero não pode ser negativo"); column_number += yyleng; }
{erroZeroEsquerda}      { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: 0 a esquerda"); column_number += yyleng; }
{erroFloatNegativo}     { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: pontos flutuantes não podem assumir valores negativos"); column_number += yyleng; }
{numeroInteiro}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "NUMERO INTEIRO"); column_number += yyleng; yylval.inteiro = atoi(yytext); return NUMERO_INT; }
{numeroFloat}           { fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "NUMERO FLOAT"); column_number += yyleng; yylval.inteiro = atof(yytext); return NUMERO_FLOAT; }
{identificador}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "IDENTIFICADOR"); column_number += yyleng; yylval.simbolo = buscarOuInserirSimbolo(yytext); return IDENTIFICADOR; }
{delim}					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; yylval.caractere = yytext[0]; return DELIMITADOR; }
{literal}				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "LITERAL"); column_number += yyleng; return LITERAL; }
{quebraLinha}			{ column_number = 1; }
{ws}					{ column_number += yyleng; }
{erroLiteralAberto}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: literais devem ser fechados com aspas"); column_number += yyleng; }
{erroNumero}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: pontos flutuantes devem usar \".\" e não \",\""); column_number += yyleng; }
{erroIdentificador}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: identificadores devem começar com \"$\""); column_number += yyleng; }
{invalido}				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: caractere inválido"); column_number += yyleng; }
%%
/*------User subrotines--------*/

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
    strcpy(novo->lexema, lexema);
    novo->token = IDENTIFICADOR;
    novo->ocorrencias = 1;
    novo->prox = tabela[indice];
    tabela[indice] = novo;
	return novo;
}

void imprimirTabela() {
    printf("\n\nTabela de Símbolos");
    printf("\n%-6s %-20s %-10s %-12s\n", "HASH", "LEXEMA", "TOKEN", "QUANT. OCORRENCIAS");
    printf("-------------------------------------------------------------\n");

    for (int i = 0; i < TAM_TABELA; i++) {
        Simbolo *atual = tabela[i];

        while (atual != NULL) {
            printf("%-6d %-20s %-10d %-12d\n",
                   i,
                   atual->lexema,
                   atual->token,
                   atual->ocorrencias);
            atual = atual->prox;
        }
    }

    printf("-------------------------------------------------------------\n");
}


int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yyout= stdout;

	fprintf(yyout, "%-4s %-4s %-20s %-25s\n", "LIN", "COL", "LEXEMA", "TOKEN");
	fprintf(yyout, "-------------------------------------------------------------\n");

	while (yylex() !=0){}

	imprimirTabela();

	fclose(yyin);
	return 0;
}
