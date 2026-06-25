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
#line 17 "Trab.y"


    enum CategoriaId{
            variavel,
            funcao,
            parametro
        };

    typedef struct Simbolo {
        int id;
        char lexema[100];
        int ocorrencias;
        char tipo;
        enum CategoriaId categoria;
        struct Simbolo *prox;
        int nivelEnv;
    } Simbolo;

    typedef struct Env {
        Simbolo *tabela;
        int nivel;
        struct Env *prev;
    } Env;

    typedef struct Ttype {
        char type;
        int width;
    } Ttype;

#line 79 "parser.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ID = 258,                      /* "identificador"  */
    NUMERO_INT = 259,              /* "numero inteiro"  */
    NUMERO_FLOAT = 260,            /* "numero float"  */
    LITERAL = 261,                 /* "literal"  */
    TD_INTEGER = 262,              /* "int"  */
    TD_FLOAT = 263,                /* "float"  */
    TD_BOOL = 264,                 /* "bool"  */
    PR_IF = 265,                   /* "if"  */
    OPEN_IF = 266,                 /* OPEN_IF  */
    PR_ELSE = 267,                 /* PR_ELSE  */
    PR_WHILE = 268,                /* "while"  */
    PR_PRINT = 269,                /* "print"  */
    PR_READ = 270,                 /* "read"  */
    PR_RETURN = 271,               /* "return"  */
    PR_TRUE = 272,                 /* "true"  */
    PR_FALSE = 273,                /* "false"  */
    OA_PLUS = 274,                 /* "+"  */
    OA_MINUS = 275,                /* "-"  */
    OA_MULT = 276,                 /* "*"  */
    OA_DIV = 277,                  /* "/"  */
    OR_LT = 278,                   /* "<"  */
    OR_GT = 279,                   /* ">"  */
    OR_EQ = 280,                   /* "=="  */
    OR_LE = 281,                   /* "<="  */
    OR_GE = 282,                   /* ">="  */
    OR_NE = 283,                   /* "!="  */
    OL_AND = 284,                  /* "&&"  */
    OL_OR = 285,                   /* "||"  */
    OL_NOT = 286,                  /* "!"  */
    OP_ATRIBUICAO = 287            /* "="  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 47 "Trab.y"

    int inteiro;
    float pontoFlutante;
    char *texto;
    Simbolo *simbolo;
    Ttype tipoDado;

#line 136 "parser.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_H_INCLUDED  */
