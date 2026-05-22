/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 12 "Trab.y"

    typedef struct Simbolo {
        int id;
        char lexema[100];
        int token;
        int ocorrencias;
        int tipo;
        struct Simbolo *prox;
    } Simbolo;

#line 60 "parser.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ID = 258,                      /* ID  */
    NUMERO_INT = 259,              /* NUMERO_INT  */
    NUMERO_FLOAT = 260,            /* NUMERO_FLOAT  */
    LITERAL = 261,                 /* LITERAL  */
    TD_INTEGER = 262,              /* TD_INTEGER  */
    TD_FLOAT = 263,                /* TD_FLOAT  */
    TD_BOOL = 264,                 /* TD_BOOL  */
    PR_IF = 265,                   /* PR_IF  */
    PR_ELSE = 266,                 /* PR_ELSE  */
    PR_WHILE = 267,                /* PR_WHILE  */
    PR_PRINT = 268,                /* PR_PRINT  */
    PR_READ = 269,                 /* PR_READ  */
    PR_RETURN = 270,               /* PR_RETURN  */
    PR_TRUE = 271,                 /* PR_TRUE  */
    PR_FALSE = 272,                /* PR_FALSE  */
    OA_PLUS = 273,                 /* OA_PLUS  */
    OA_MINUS = 274,                /* OA_MINUS  */
    OA_MULT = 275,                 /* OA_MULT  */
    OA_DIV = 276,                  /* OA_DIV  */
    OR_LT = 277,                   /* OR_LT  */
    OR_GT = 278,                   /* OR_GT  */
    OR_EQ = 279,                   /* OR_EQ  */
    OR_LE = 280,                   /* OR_LE  */
    OR_GE = 281,                   /* OR_GE  */
    OR_NE = 282,                   /* OR_NE  */
    OL_AND = 283,                  /* OL_AND  */
    OL_OR = 284,                   /* OL_OR  */
    OL_NOT = 285,                  /* OL_NOT  */
    OP_ATRIBUICAO = 286            /* OP_ATRIBUICAO  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 23 "Trab.y"

    int inteiro;
    float pontoFlutante;
    char *texto;
    char caractere;
    Simbolo *simbolo;

#line 116 "parser.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_H_INCLUDED  */
