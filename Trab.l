%option noyywrap yylineno

%{
/*------Definitions--------*/
#include <stdio.h>
int column_number = 1;

//Tokens
#define DELIMITADOR				11
#define OPERADOR_RELACIONAL 	12
#define OPERADOR_ARITMETICO		13
#define OPERADOR_LOGICO			14
#define PALAVRA_RESERVADA		15
#define TIPO_DADO				16
#define NUMERO					17
#define IDENTIFICADOR			18
#define COMENTARIO				19

//Tipos de dados
#define TD_INTEGER  	21
#define TD_FLOAT		22

//Palavras reservadas
#define PR_IF			31
#define PR_ELSE			32
#define PR_WHILE		33
#define PR_PRINT		34
#define PR_READ			35

//Operadores lógicos
#define OL_AND			41
#define OL_OR			42
#define OL_NOT			43

//Operadores aritméticos
#define OA_SQR			51
#define OA_SQRT			52
#define OA_SIN			53
#define OA_COS			54
#define OA_TAN			55

//Operadores relacionais
#define OR_LT			61
#define OR_GT			62
#define OR_EQ			63
#define OR_LE			64
#define OR_GE			65
#define OR_NE			66

int yylval;

%}

delim				[;,(){}]
identificador		"$"[a-zA-Z0-9]+
numero				(-?[0-9]+)|([0-9]*("."[0-9]+)?)
ws					[ \t]
quebraLinha			\n
comentario			"//".*
comentarioPlus		"/*"([^*]*|"*"+[^/*]+)*"*"+"/"
literal				\"[^"\n]*\"
erroLiteralAberto	\"[^"\n]*
erroNumero			-?[0-9]+,[0-9]+
erroIdentificador	[a-zA-Z][a-zA-Z0-9]*
invalido			.

%%
%{
/*------Rules--------*/
%}

"<"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; return OPERADOR_RELACIONAL; }
">"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; return OPERADOR_RELACIONAL; }
"=="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; return OPERADOR_RELACIONAL; }
"<="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; return OPERADOR_RELACIONAL; }
">="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; return OPERADOR_RELACIONAL; }
"!="					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_RELACIONAL"); column_number += yyleng; return OPERADOR_RELACIONAL; }

"+"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; return OPERADOR_ARITMETICO; }
"-"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; return OPERADOR_ARITMETICO; }
"*"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; return OPERADOR_ARITMETICO; }
"/"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_ARITMETICO"); column_number += yyleng; return OPERADOR_ARITMETICO; }

"&&"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_LOGICO"); column_number += yyleng; return OPERADOR_LOGICO; }
"||"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_LOGICO"); column_number += yyleng; return OPERADOR_LOGICO; }
"!"						{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "OPERADOR_LOGICO"); column_number += yyleng; return OPERADOR_LOGICO; }

"if"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PALAVRA_RESERVADA; }
"else"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PALAVRA_RESERVADA; }
"while"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PALAVRA_RESERVADA; }
"print"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PALAVRA_RESERVADA; }
"read"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "PALAVRA_RESERVADA"); column_number += yyleng; return PALAVRA_RESERVADA; }

"int"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TIPO_DADO"); column_number += yyleng; return TIPO_DADO; }
"float"					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "TIPO_DADO"); column_number += yyleng; return TIPO_DADO; }

{numero}				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "NUMERO"); column_number += yyleng; return NUMERO; }
{identificador}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "IDENTIFICADOR"); column_number += yyleng; return IDENTIFICADOR; }
{comentario}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "COMENTARIO"); column_number += yyleng; return COMENTARIO; }
{comentarioPlus}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "COMENTARIO"); column_number += yyleng; return COMENTARIO; }
{delim}					{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "DELIMITADOR"); column_number += yyleng; return DELIMITADOR; }
{literal}				{ column_number += yyleng; }
{quebraLinha}			{ column_number = 1; }
{ws}					{ column_number += yyleng; }
{erroLiteralAberto}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: literais devem ser fechados com aspas"); column_number += yyleng; }
{erroNumero}			{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: números em ponto flutuante devem usar \".\" e não \",\""); column_number += yyleng; }
{erroIdentificador}		{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: identificadores devem começar com \"$\""); column_number += yyleng; }
{invalido}				{ fprintf(yyout, "%-4d %-4d %-20s %-25s\n", yylineno, column_number, yytext, "Erro léxico: caractere inválido"); column_number += yyleng; }
%%
/*------User subrotines--------*/

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yyout= stdout;

	fprintf(yyout, "%-4s %-4s %-20s %-25s\n", "LIN", "COL", "LEXEMA", "TOKEN");
	fprintf(yyout, "-------------------------------------------------------------\n");

	while (yylex() !=0){}
	fclose(yyin);
	return 0;
}
