%option noyywrap yylineno

%{
/*------Definitions--------*/
#include<stdio.h>

//Tokens
#define DELIMITADOR		11
#define OPERADOR_RELACIONAL 	12
#define OPERADOR_ARITMETICO	13
#define OPERADOR_LOGICO		14
#define PALAVRA_RESERVADA	15
#define TIPO_DADO		16
#define NUMERO			17
#define IDENTIFICADOR		18
#define COMENTARIO		19
#define INVALIDO		99

//Tipos de dados
#define TD_INTEGER  		21
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

delim			[;,(){}]
identificador		"$"[a-zA-Z0-9]+
numero			(-?[0-9]+)|([0-9]*("."[0-9]+)?)
ws			[ \n\t]
comentario		"//".*
comentarioPlus		"/*"([^*]*|"*"+[^/*]+)*"*"+"/"
invalido		.

%%
%{
/*------Rules--------*/
%}

"<"		{ yylval = OR_LT; return OPERADOR_RELACIONAL; }
">"		{ yylval = OR_GT; return OPERADOR_RELACIONAL; }
"=="		{ yylval = OR_EQ; return OPERADOR_RELACIONAL; }
"<="		{ yylval = OR_LE; return OPERADOR_RELACIONAL; }
">="		{ yylval = OR_GE; return OPERADOR_RELACIONAL; }
"!="		{ yylval = OR_NE; return OPERADOR_RELACIONAL; }

"+"		{ yylval = '+'; return OPERADOR_ARITMETICO; }
"-"		{ yylval = '-'; return OPERADOR_ARITMETICO; }
"*"		{ yylval = '*'; return OPERADOR_ARITMETICO; }
"/"		{ yylval = '/'; return OPERADOR_ARITMETICO; }

"&&"		{ yylval = OL_AND; return OPERADOR_LOGICO; }
"||"		{ yylval = OL_OR; return OPERADOR_LOGICO; }
"!"		{ yylval = OL_NOT; return OPERADOR_LOGICO; }

"if"		{ yylval = PR_IF; return PALAVRA_RESERVADA; }
"else"		{ yylval = PR_ELSE; return PALAVRA_RESERVADA; }
"while"		{ yylval = PR_WHILE; return PALAVRA_RESERVADA; }
"print"		{ yylval = PR_PRINT; return PALAVRA_RESERVADA; }
"read"		{ yylval = PR_READ; return PALAVRA_RESERVADA; }

"integer"	{ yylval = TD_INTEGER; return TIPO_DADO; }
"float"		{ yylval = TD_FLOAT; return TIPO_DADO; }

{numero}		{ return NUMERO; } 
{identificador}		{ return IDENTIFICADOR; }
{comentario}		{ return COMENTARIO; }
{comentarioPlus}	{ printf("TOKEN COMENTARIO | lexema: %s\n\n", yytext); return COMENTARIO; }
{invalido}		{ return INVALIDO; }
{delim}			{ return (DELIMITADOR); }
{ws}			{ }


%%
/*------User subrotines--------*/

int main(int argc, char *argv[]){
	yyin = stdin;//fopen(argv[1], "r");
	yyout= stdout;
	while (yylex() !=0){}
	fclose(yyin);
	return 0;
}
