#!/bin/bash

# Gerar o parser com Bison
bison -d -o parser.c Trab.y

# Gerar o analisador léxico com Flex
flex -o lexer.c Trab.l

# Compilar tudo junto
gcc parser.c lexer.c -lfl -o saida

# Executar com arquivo de teste
./saida teste_parser.txt