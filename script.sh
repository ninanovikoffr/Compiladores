#!/bin/bash

# Gerar o parser com Bison
bison -d -o build/parser.c src/Trab.y

# Gerar o analisador léxico com Flex
flex -o build/lexer.c src/Trab.l

# Compilar tudo junto
gcc build/parser.c build/lexer.c -lfl -o output/saida

# Executar com arquivo de teste
./output/saida tests/teste_parser.txt
