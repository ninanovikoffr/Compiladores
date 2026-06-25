/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "Trab.y"

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

#line 87 "parser.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "parser.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_ID = 3,                         /* "identificador"  */
  YYSYMBOL_NUMERO_INT = 4,                 /* "numero inteiro"  */
  YYSYMBOL_NUMERO_FLOAT = 5,               /* "numero float"  */
  YYSYMBOL_LITERAL = 6,                    /* "literal"  */
  YYSYMBOL_TD_INTEGER = 7,                 /* "int"  */
  YYSYMBOL_TD_FLOAT = 8,                   /* "float"  */
  YYSYMBOL_TD_BOOL = 9,                    /* "bool"  */
  YYSYMBOL_PR_IF = 10,                     /* "if"  */
  YYSYMBOL_OPEN_IF = 11,                   /* OPEN_IF  */
  YYSYMBOL_PR_ELSE = 12,                   /* PR_ELSE  */
  YYSYMBOL_PR_WHILE = 13,                  /* "while"  */
  YYSYMBOL_PR_PRINT = 14,                  /* "print"  */
  YYSYMBOL_PR_READ = 15,                   /* "read"  */
  YYSYMBOL_PR_RETURN = 16,                 /* "return"  */
  YYSYMBOL_PR_TRUE = 17,                   /* "true"  */
  YYSYMBOL_PR_FALSE = 18,                  /* "false"  */
  YYSYMBOL_OA_PLUS = 19,                   /* "+"  */
  YYSYMBOL_OA_MINUS = 20,                  /* "-"  */
  YYSYMBOL_OA_MULT = 21,                   /* "*"  */
  YYSYMBOL_OA_DIV = 22,                    /* "/"  */
  YYSYMBOL_OR_LT = 23,                     /* "<"  */
  YYSYMBOL_OR_GT = 24,                     /* ">"  */
  YYSYMBOL_OR_EQ = 25,                     /* "=="  */
  YYSYMBOL_OR_LE = 26,                     /* "<="  */
  YYSYMBOL_OR_GE = 27,                     /* ">="  */
  YYSYMBOL_OR_NE = 28,                     /* "!="  */
  YYSYMBOL_OL_AND = 29,                    /* "&&"  */
  YYSYMBOL_OL_OR = 30,                     /* "||"  */
  YYSYMBOL_OL_NOT = 31,                    /* "!"  */
  YYSYMBOL_OP_ATRIBUICAO = 32,             /* "="  */
  YYSYMBOL_33_ = 33,                       /* ';'  */
  YYSYMBOL_34_ = 34,                       /* ','  */
  YYSYMBOL_35_ = 35,                       /* '('  */
  YYSYMBOL_36_ = 36,                       /* ')'  */
  YYSYMBOL_37_ = 37,                       /* '{'  */
  YYSYMBOL_38_ = 38,                       /* '}'  */
  YYSYMBOL_YYACCEPT = 39,                  /* $accept  */
  YYSYMBOL_S = 40,                         /* S  */
  YYSYMBOL_41_1 = 41,                      /* $@1  */
  YYSYMBOL_elementos = 42,                 /* elementos  */
  YYSYMBOL_elemento = 43,                  /* elemento  */
  YYSYMBOL_tipo_dado = 44,                 /* tipo_dado  */
  YYSYMBOL_declaracao_variavel = 45,       /* declaracao_variavel  */
  YYSYMBOL_lista_declaracao_variavel = 46, /* lista_declaracao_variavel  */
  YYSYMBOL_item_declaracao_variavel = 47,  /* item_declaracao_variavel  */
  YYSYMBOL_atribuicao = 48,                /* atribuicao  */
  YYSYMBOL_declaracao_funcao = 49,         /* declaracao_funcao  */
  YYSYMBOL_parametros = 50,                /* parametros  */
  YYSYMBOL_lista_parametros = 51,          /* lista_parametros  */
  YYSYMBOL_parametro = 52,                 /* parametro  */
  YYSYMBOL_chamada_funcao = 53,            /* chamada_funcao  */
  YYSYMBOL_argumentos = 54,                /* argumentos  */
  YYSYMBOL_lista_argumentos = 55,          /* lista_argumentos  */
  YYSYMBOL_bloco = 56,                     /* bloco  */
  YYSYMBOL_57_2 = 57,                      /* $@2  */
  YYSYMBOL_comandos = 58,                  /* comandos  */
  YYSYMBOL_comando = 59,                   /* comando  */
  YYSYMBOL_comando_condicional = 60,       /* comando_condicional  */
  YYSYMBOL_comando_repeticao = 61,         /* comando_repeticao  */
  YYSYMBOL_comando_saida = 62,             /* comando_saida  */
  YYSYMBOL_comando_entrada = 63,           /* comando_entrada  */
  YYSYMBOL_comando_retorno = 64,           /* comando_retorno  */
  YYSYMBOL_expressao = 65,                 /* expressao  */
  YYSYMBOL_expressao_ou = 66,              /* expressao_ou  */
  YYSYMBOL_expressao_e = 67,               /* expressao_e  */
  YYSYMBOL_expressao_not = 68,             /* expressao_not  */
  YYSYMBOL_expressao_relacional = 69,      /* expressao_relacional  */
  YYSYMBOL_operador_relacional = 70,       /* operador_relacional  */
  YYSYMBOL_expressao_aritmetica = 71,      /* expressao_aritmetica  */
  YYSYMBOL_expressao_termo = 72,           /* expressao_termo  */
  YYSYMBOL_expressao_fator = 73            /* expressao_fator  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;



/* Unqualified %code blocks.  */
#line 55 "Trab.y"

    Env* envAtual = NULL;
    Ttype tipoAtual;
    void criarEnv();
    void fecharEnv(void);
    void addSimbolo(char *lexema, Ttype tipo, enum CategoriaId categoria);
    Simbolo* usoDoIDEnv(char *lexema);
    Simbolo* buscarSimboloEnv(char *lexema, Env *env);
    Simbolo* buscarSimboloGeral(char *lexema);


#line 207 "parser.c"

#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if 1

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* 1 */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   148

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  39
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  35
/* YYNRULES -- Number of rules.  */
#define YYNRULES  80
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  131

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   287


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      35,    36,     2,     2,    34,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    33,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    37,     2,    38,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   122,   122,   122,   128,   129,   130,   137,   138,   142,
     143,   144,   148,   152,   153,   157,   158,   162,   166,   170,
     171,   175,   176,   180,   184,   188,   189,   193,   194,   198,
     198,   203,   205,   206,   207,   211,   212,   213,   214,   215,
     216,   217,   218,   219,   223,   224,   228,   232,   236,   240,
     241,   245,   249,   250,   254,   255,   259,   260,   264,   265,
     269,   270,   271,   272,   273,   274,   278,   294,   310,   314,
     330,   346,   350,   351,   352,   353,   354,   355,   356,   357,
     358
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if 1
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "\"identificador\"",
  "\"numero inteiro\"", "\"numero float\"", "\"literal\"", "\"int\"",
  "\"float\"", "\"bool\"", "\"if\"", "OPEN_IF", "PR_ELSE", "\"while\"",
  "\"print\"", "\"read\"", "\"return\"", "\"true\"", "\"false\"", "\"+\"",
  "\"-\"", "\"*\"", "\"/\"", "\"<\"", "\">\"", "\"==\"", "\"<=\"",
  "\">=\"", "\"!=\"", "\"&&\"", "\"||\"", "\"!\"", "\"=\"", "';'", "','",
  "'('", "')'", "'{'", "'}'", "$accept", "S", "$@1", "elementos",
  "elemento", "tipo_dado", "declaracao_variavel",
  "lista_declaracao_variavel", "item_declaracao_variavel", "atribuicao",
  "declaracao_funcao", "parametros", "lista_parametros", "parametro",
  "chamada_funcao", "argumentos", "lista_argumentos", "bloco", "$@2",
  "comandos", "comando", "comando_condicional", "comando_repeticao",
  "comando_saida", "comando_entrada", "comando_retorno", "expressao",
  "expressao_ou", "expressao_e", "expressao_not", "expressao_relacional",
  "operador_relacional", "expressao_aritmetica", "expressao_termo",
  "expressao_fator", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-79)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-4)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -79,    11,    72,   -79,   -11,   -79,   -79,   -79,   -26,   -22,
     -12,   -10,    96,   -79,    19,   -79,    33,   -79,    17,   -79,
      20,   -79,   -79,   -79,   -79,   -79,   -79,   -79,   101,   101,
     101,   101,   101,    52,    22,   -79,   -79,   -79,   -79,   -79,
      34,    34,   -79,   101,   -79,    26,    44,    54,   -79,   -79,
     114,    21,   -79,   -79,    58,   -79,     9,    -3,   -79,   -79,
     -79,   -79,    60,    56,   -79,    61,    62,    67,    74,   -79,
     -79,    75,   -79,   101,   101,    34,    34,   -79,   -79,   -79,
     -79,   -79,   -79,    34,    34,    34,    57,   -79,   101,    69,
     -79,   105,   -79,   101,    72,    72,    79,    82,   -79,    54,
     -79,    21,    21,    28,   -79,   -79,   -23,   -79,   105,   -79,
     -79,   117,    81,    88,   -79,    91,   -79,   -79,   112,   -79,
     -79,   -79,   -79,   -79,   -79,    93,    69,    72,   -79,   -79,
     -79
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     1,     0,     9,    10,    11,     0,     0,
       0,     0,     0,    29,     0,     5,     0,    36,     0,     7,
       0,    38,     8,    43,    42,    39,    40,    41,     0,    26,
       0,     0,     0,     0,    74,    75,    76,    77,    78,    79,
       0,     0,    50,     0,    73,     0,    51,    53,    55,    57,
      59,    68,    71,    31,     0,     4,    15,     0,    14,    35,
      37,    17,     0,    25,    28,     0,     0,     0,     0,    80,
      56,     0,    49,     0,     0,     0,     0,    60,    61,    62,
      63,    64,    65,     0,     0,     0,     0,     6,     0,    20,
      12,     0,    24,     0,     0,     0,     0,     0,    72,    52,
      54,    66,    67,    58,    69,    70,     0,    30,     0,    32,
      16,     0,     0,    19,    22,    15,    13,    27,    44,    46,
      47,    48,    33,    34,    23,     0,     0,     0,    18,    21,
      45
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -79,   -79,   -79,   -79,   121,     0,   -79,   -79,    37,   -79,
     -79,   -79,   -79,    18,    -2,   -79,   -79,    23,   -79,   -79,
     -78,   -79,   -79,   -79,   -79,   -79,   -25,   -79,    70,    71,
     106,   -79,    63,   -14,   -39
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     1,     2,    14,    15,   108,    17,    57,    58,    18,
      19,   112,   113,   114,    44,    62,    63,    21,    53,    86,
      22,    23,    24,    25,    26,    27,    45,    46,    47,    48,
      49,    83,    50,    51,    52
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      20,    69,    16,    61,    64,    65,    66,    67,   109,    30,
     122,     3,    20,    31,    16,   123,   118,   119,    71,    -3,
      54,    28,     4,    32,    29,    33,     5,     6,     7,     8,
      90,    91,     9,    10,    11,    12,    56,    34,    35,    36,
      37,    88,    84,    85,    89,   104,   105,    75,    76,   130,
      59,    38,    39,    60,    40,    68,    13,    29,   106,    72,
       4,   101,   102,   110,     5,     6,     7,     8,   117,    43,
       9,    10,    11,    12,    73,     4,     5,     6,     7,     5,
       6,     7,     8,    74,    20,     9,    10,    11,    12,   111,
      93,    87,    20,    20,    13,   107,    92,    94,    95,    34,
      35,    36,    37,    96,    34,    35,    36,    37,   115,    13,
      97,    98,   120,    38,    39,   121,    40,   125,    38,    39,
     124,    40,   126,    88,   127,    20,   111,    41,   116,    42,
      13,    43,    41,    75,    76,    55,    43,    77,    78,    79,
      80,    81,    82,    99,   129,   100,   103,    70,   128
};

static const yytype_int8 yycheck[] =
{
       2,    40,     2,    28,    29,    30,    31,    32,    86,    35,
      33,     0,    14,    35,    14,    38,    94,    95,    43,     0,
       1,    32,     3,    35,    35,    35,     7,     8,     9,    10,
      33,    34,    13,    14,    15,    16,     3,     3,     4,     5,
       6,    32,    21,    22,    35,    84,    85,    19,    20,   127,
      33,    17,    18,    33,    20,     3,    37,    35,     1,    33,
       3,    75,    76,    88,     7,     8,     9,    10,    93,    35,
      13,    14,    15,    16,    30,     3,     7,     8,     9,     7,
       8,     9,    10,    29,    86,    13,    14,    15,    16,    89,
      34,    33,    94,    95,    37,    38,    36,    36,    36,     3,
       4,     5,     6,    36,     3,     4,     5,     6,     3,    37,
      36,    36,    33,    17,    18,    33,    20,    36,    17,    18,
       3,    20,    34,    32,    12,   127,   126,    31,    91,    33,
      37,    35,    31,    19,    20,    14,    35,    23,    24,    25,
      26,    27,    28,    73,   126,    74,    83,    41,   125
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    40,    41,     0,     3,     7,     8,     9,    10,    13,
      14,    15,    16,    37,    42,    43,    44,    45,    48,    49,
      53,    56,    59,    60,    61,    62,    63,    64,    32,    35,
      35,    35,    35,    35,     3,     4,     5,     6,    17,    18,
      20,    31,    33,    35,    53,    65,    66,    67,    68,    69,
      71,    72,    73,    57,     1,    43,     3,    46,    47,    33,
      33,    65,    54,    55,    65,    65,    65,    65,     3,    73,
      69,    65,    33,    30,    29,    19,    20,    23,    24,    25,
      26,    27,    28,    70,    21,    22,    58,    33,    32,    35,
      33,    34,    36,    34,    36,    36,    36,    36,    36,    67,
      68,    72,    72,    71,    73,    73,     1,    38,    44,    59,
      65,    44,    50,    51,    52,     3,    47,    65,    59,    59,
      33,    33,    33,    38,     3,    36,    34,    12,    56,    52,
      59
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    39,    41,    40,    42,    42,    42,    43,    43,    44,
      44,    44,    45,    46,    46,    47,    47,    48,    49,    50,
      50,    51,    51,    52,    53,    54,    54,    55,    55,    57,
      56,    58,    58,    58,    58,    59,    59,    59,    59,    59,
      59,    59,    59,    59,    60,    60,    61,    62,    63,    64,
      64,    65,    66,    66,    67,    67,    68,    68,    69,    69,
      70,    70,    70,    70,    70,    70,    71,    71,    71,    72,
      72,    72,    73,    73,    73,    73,    73,    73,    73,    73,
      73
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     2,     2,     1,     3,     1,     1,     1,
       1,     1,     3,     3,     1,     1,     3,     3,     6,     1,
       0,     3,     1,     2,     4,     1,     0,     3,     1,     0,
       4,     0,     2,     3,     3,     2,     1,     2,     1,     1,
       1,     1,     1,     1,     5,     7,     5,     5,     5,     3,
       2,     1,     3,     1,     3,     1,     2,     1,     3,     1,
       1,     1,     1,     1,     1,     1,     3,     3,     1,     3,
       3,     1,     3,     1,     1,     1,     1,     1,     1,     1,
       2
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


/* Context of a parse error.  */
typedef struct
{
  yy_state_t *yyssp;
  yysymbol_kind_t yytoken;
} yypcontext_t;

/* Put in YYARG at most YYARGN of the expected tokens given the
   current YYCTX, and return the number of tokens stored in YYARG.  If
   YYARG is null, return the number of expected tokens (guaranteed to
   be less than YYNTOKENS).  Return YYENOMEM on memory exhaustion.
   Return 0 if there are more than YYARGN expected tokens, yet fill
   YYARG up to YYARGN. */
static int
yypcontext_expected_tokens (const yypcontext_t *yyctx,
                            yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  int yyn = yypact[+*yyctx->yyssp];
  if (!yypact_value_is_default (yyn))
    {
      /* Start YYX at -YYN if negative to avoid negative indexes in
         YYCHECK.  In other words, skip the first -YYN actions for
         this state because they are default actions.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;
      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yyx;
      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
        if (yycheck[yyx + yyn] == yyx && yyx != YYSYMBOL_YYerror
            && !yytable_value_is_error (yytable[yyx + yyn]))
          {
            if (!yyarg)
              ++yycount;
            else if (yycount == yyargn)
              return 0;
            else
              yyarg[yycount++] = YY_CAST (yysymbol_kind_t, yyx);
          }
    }
  if (yyarg && yycount == 0 && 0 < yyargn)
    yyarg[0] = YYSYMBOL_YYEMPTY;
  return yycount;
}




#ifndef yystrlen
# if defined __GLIBC__ && defined _STRING_H
#  define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
# else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
# endif
#endif

#ifndef yystpcpy
# if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#  define yystpcpy stpcpy
# else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
# endif
#endif

#ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;
      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
#endif


static int
yy_syntax_error_arguments (const yypcontext_t *yyctx,
                           yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yyctx->yytoken != YYSYMBOL_YYEMPTY)
    {
      int yyn;
      if (yyarg)
        yyarg[yycount] = yyctx->yytoken;
      ++yycount;
      yyn = yypcontext_expected_tokens (yyctx,
                                        yyarg ? yyarg + 1 : yyarg, yyargn - 1);
      if (yyn == YYENOMEM)
        return YYENOMEM;
      else
        yycount += yyn;
    }
  return yycount;
}

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return -1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return YYENOMEM if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                const yypcontext_t *yyctx)
{
  enum { YYARGS_MAX = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  yysymbol_kind_t yyarg[YYARGS_MAX];
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* Actual size of YYARG. */
  int yycount = yy_syntax_error_arguments (yyctx, yyarg, YYARGS_MAX);
  if (yycount == YYENOMEM)
    return YYENOMEM;

  switch (yycount)
    {
#define YYCASE_(N, S)                       \
      case N:                               \
        yyformat = S;                       \
        break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
#undef YYCASE_
    }

  /* Compute error message size.  Don't count the "%s"s, but reserve
     room for the terminator.  */
  yysize = yystrlen (yyformat) - 2 * yycount + 1;
  {
    int yyi;
    for (yyi = 0; yyi < yycount; ++yyi)
      {
        YYPTRDIFF_T yysize1
          = yysize + yytnamerr (YY_NULLPTR, yytname[yyarg[yyi]]);
        if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
          yysize = yysize1;
        else
          return YYENOMEM;
      }
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return -1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yytname[yyarg[yyi++]]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* $@1: %empty  */
#line 122 "Trab.y"
    { criarEnv(); }
#line 1531 "parser.c"
    break;

  case 6: /* elementos: elementos error ';'  */
#line 130 "Trab.y"
                          { yyerrok; }
#line 1537 "parser.c"
    break;

  case 9: /* tipo_dado: "int"  */
#line 142 "Trab.y"
                    {(yyval.tipoDado).type = 'i'; (yyval.tipoDado).width = 4; tipoAtual = (yyval.tipoDado);}
#line 1543 "parser.c"
    break;

  case 10: /* tipo_dado: "float"  */
#line 143 "Trab.y"
                    {(yyval.tipoDado).type = 'f'; (yyval.tipoDado).width = 8; tipoAtual = (yyval.tipoDado);}
#line 1549 "parser.c"
    break;

  case 11: /* tipo_dado: "bool"  */
#line 144 "Trab.y"
                    {(yyval.tipoDado).type = 'b'; (yyval.tipoDado).width = 1; tipoAtual = (yyval.tipoDado);}
#line 1555 "parser.c"
    break;

  case 15: /* item_declaracao_variavel: "identificador"  */
#line 157 "Trab.y"
                                    {addSimbolo( (yyvsp[0].simbolo)->lexema, tipoAtual, variavel);}
#line 1561 "parser.c"
    break;

  case 16: /* item_declaracao_variavel: "identificador" "=" expressao  */
#line 158 "Trab.y"
                                    {addSimbolo( (yyvsp[-2].simbolo)->lexema, tipoAtual, variavel);}
#line 1567 "parser.c"
    break;

  case 17: /* atribuicao: "identificador" "=" expressao  */
#line 162 "Trab.y"
                               { usoDoIDEnv((yyvsp[-2].simbolo)->lexema); }
#line 1573 "parser.c"
    break;

  case 29: /* $@2: %empty  */
#line 198 "Trab.y"
                { criarEnv(); printf ("\n{\n");}
#line 1579 "parser.c"
    break;

  case 30: /* bloco: '{' $@2 comandos '}'  */
#line 200 "Trab.y"
                { fecharEnv();  printf ("\n}\n");}
#line 1585 "parser.c"
    break;

  case 33: /* comandos: comandos error ';'  */
#line 206 "Trab.y"
                         { yyerrok; /* Recuperação de erro em instruções com ponto e vírgula */ }
#line 1591 "parser.c"
    break;

  case 34: /* comandos: comandos error '}'  */
#line 207 "Trab.y"
                         { yyerrok; /* Recuperação de erro em fechamentos de blocos estruturados */ }
#line 1597 "parser.c"
    break;

  case 51: /* expressao: expressao_ou  */
#line 245 "Trab.y"
                 { (yyval.tipoDado) = (yyvsp[0].tipoDado);}
#line 1603 "parser.c"
    break;

  case 53: /* expressao_ou: expressao_e  */
#line 250 "Trab.y"
                  { (yyval.tipoDado) = (yyvsp[0].tipoDado);}
#line 1609 "parser.c"
    break;

  case 55: /* expressao_e: expressao_not  */
#line 255 "Trab.y"
                    { (yyval.tipoDado) = (yyvsp[0].tipoDado);}
#line 1615 "parser.c"
    break;

  case 57: /* expressao_not: expressao_relacional  */
#line 260 "Trab.y"
                           { (yyval.tipoDado) = (yyvsp[0].tipoDado);}
#line 1621 "parser.c"
    break;

  case 66: /* expressao_aritmetica: expressao_aritmetica "+" expressao_termo  */
#line 279 "Trab.y"
        {
            if(((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'i') && ((yyvsp[-2].tipoDado).type == 'i' || (yyvsp[0].tipoDado).type == 'f')){
                if((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'f'){
                    (yyval.tipoDado).type = 'f';
                    (yyval.tipoDado).width = 8; 
                }
                else {
                    (yyval.tipoDado).type = 'i';
                    (yyval.tipoDado).width = 4;
                }
            }
            else {
                printf("Erro semantico na linha %d: Apenas tipos int e float podem ser somados.\n", yylineno);
            }
        }
#line 1641 "parser.c"
    break;

  case 67: /* expressao_aritmetica: expressao_aritmetica "-" expressao_termo  */
#line 295 "Trab.y"
        {
            if(((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'i') && ((yyvsp[-2].tipoDado).type == 'i' || (yyvsp[0].tipoDado).type == 'f')){
                if((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'f'){
                    (yyval.tipoDado).type = 'f';
                    (yyval.tipoDado).width = 8; 
                }
                else {
                    (yyval.tipoDado).type = 'i';
                    (yyval.tipoDado).width = 4;
                }
            }
            else {
                printf("Erro semantico na linha %d: Apenas tipos int e float podem ser subtraidos.\n", yylineno);
            }
        }
#line 1661 "parser.c"
    break;

  case 68: /* expressao_aritmetica: expressao_termo  */
#line 310 "Trab.y"
                      { (yyval.tipoDado) = (yyvsp[0].tipoDado);}
#line 1667 "parser.c"
    break;

  case 69: /* expressao_termo: expressao_termo "*" expressao_fator  */
#line 315 "Trab.y"
        {
            if(((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'i') && ((yyvsp[-2].tipoDado).type == 'i' || (yyvsp[0].tipoDado).type == 'f')){
                if((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'f'){
                    (yyval.tipoDado).type = 'f';
                    (yyval.tipoDado).width = 8; 
                }
                else {
                    (yyval.tipoDado).type = 'i';
                    (yyval.tipoDado).width = 4;
                }
            }
            else {
                printf("Erro semantico na linha %d: Apenas tipos int e float podem ser multiplicados.\n", yylineno);
            }
        }
#line 1687 "parser.c"
    break;

  case 70: /* expressao_termo: expressao_termo "/" expressao_fator  */
#line 331 "Trab.y"
        {
            if(((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'i') && ((yyvsp[-2].tipoDado).type == 'i' || (yyvsp[0].tipoDado).type == 'f')){
                if((yyvsp[-2].tipoDado).type == 'f' || (yyvsp[0].tipoDado).type == 'f'){
                    (yyval.tipoDado).type = 'f';
                    (yyval.tipoDado).width = 8; 
                }
                else {
                    (yyval.tipoDado).type = 'i';
                    (yyval.tipoDado).width = 4;
                }
            }
            else {
                printf("Erro semantico na linha %d: Apenas tipos int e float podem ser divididos.\n", yylineno);
            }
        }
#line 1707 "parser.c"
    break;

  case 71: /* expressao_termo: expressao_fator  */
#line 346 "Trab.y"
                      { (yyval.tipoDado) = (yyvsp[0].tipoDado);}
#line 1713 "parser.c"
    break;

  case 72: /* expressao_fator: '(' expressao ')'  */
#line 350 "Trab.y"
                        {(yyval.tipoDado) = (yyvsp[-1].tipoDado);}
#line 1719 "parser.c"
    break;

  case 74: /* expressao_fator: "identificador"  */
#line 352 "Trab.y"
                        { usoDoIDEnv((yyvsp[0].simbolo)->lexema); }
#line 1725 "parser.c"
    break;

  case 75: /* expressao_fator: "numero inteiro"  */
#line 353 "Trab.y"
                        {(yyval.tipoDado).type = 'i'; (yyval.tipoDado).width = 4;}
#line 1731 "parser.c"
    break;

  case 76: /* expressao_fator: "numero float"  */
#line 354 "Trab.y"
                        {(yyval.tipoDado).type = 'f'; (yyval.tipoDado).width = 8;}
#line 1737 "parser.c"
    break;

  case 78: /* expressao_fator: "true"  */
#line 356 "Trab.y"
                        {(yyval.tipoDado).type = 'b'; (yyval.tipoDado).width = 1;}
#line 1743 "parser.c"
    break;

  case 79: /* expressao_fator: "false"  */
#line 357 "Trab.y"
                        {(yyval.tipoDado).type = 'b'; (yyval.tipoDado).width = 1;}
#line 1749 "parser.c"
    break;


#line 1753 "parser.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      {
        yypcontext_t yyctx
          = {yyssp, yytoken};
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == -1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *,
                             YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (yymsg)
              {
                yysyntax_error_status
                  = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
                yymsgp = yymsg;
              }
            else
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = YYENOMEM;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == YYENOMEM)
          YYNOMEM;
      }
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
  return yyresult;
}

#line 361 "Trab.y"


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
int proxIdSimbolo = 0; //Id global independente do escopo --------- VERIFICAR SE SERA O MESMO DO LEXICO


void criarEnv(){
    Env *novoEnv = (Env*) malloc(sizeof(Env));

    if (novoEnv == NULL){
        //Lança erro
    }
            
    novoEnv->prev = envAtual;
    novoEnv->tabela = NULL;

    if (envAtual != NULL) {
        novoEnv->nivel = envAtual->nivel + 1;
    } else {
        novoEnv->nivel =0;
    }

    envAtual = novoEnv;
}

void fecharEnv(){
    Env* envAFechar = envAtual;
    envAtual = envAFechar->prev;
    free(envAFechar);
}

Simbolo* usoDoIDEnv(char* lexema){
    Simbolo *existe = buscarSimboloGeral(lexema);

    if(existe == NULL){
        printf("Erro: identificador '%s' nao declarado.\n", lexema);
        return NULL;
    }
    existe->ocorrencias++;

    return existe;
}

Simbolo* buscarSimboloEnv(char* lexema, Env* env){ //Procura num env específico

    if (env != NULL){
        Simbolo *simbolo = env->tabela; //primeiro da lista
        while (simbolo != NULL){
            if (strcmp(lexema, simbolo->lexema) == 0){
                return simbolo;
            } else {
                simbolo = simbolo->prox;
            }
        }
    }
    return NULL;
}

Simbolo* buscarSimboloGeral(char* lexema){ //Procura em todos os envs
    Env *env = envAtual;
    Simbolo *encontrado;

    while(env!=NULL){
        if (env != NULL){
            encontrado = buscarSimboloEnv(lexema, env);
            if (encontrado != NULL){
                return encontrado;
                } else {
                env = env->prev;
                }
        }
    }

    return NULL;
} 

void addSimbolo(char* lexema, Ttype tipo, enum CategoriaId categoria){

    if (buscarSimboloEnv(lexema, envAtual) != NULL){
        //Erro de redeclaracao de variavel -------------- A CRIAR FUNCAO
    }
    Simbolo *novoSimbolo = (Simbolo*) malloc(sizeof(Simbolo));

    novoSimbolo->id = proxIdSimbolo++;
    strcpy(novoSimbolo->lexema, lexema);    
    novoSimbolo->tipo = tipo.type;
    novoSimbolo->categoria = categoria;
    novoSimbolo->ocorrencias = 0;
    novoSimbolo->prox = envAtual->tabela;

    envAtual->tabela = novoSimbolo;
}



