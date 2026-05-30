#!/bin/bash

# Gerar o parser com Bison
bison -d -o parser.c Trab.y || { echo "Erro ao gerar parser"; exit 1; }

# Gerar o analisador léxico com Flex
flex -o lexer.c Trab.l || { echo "Erro ao gerar lexer"; exit 1; }

# Compilar tudo junto
gcc parser.c lexer.c -lfl -o saida || { echo "Erro ao compilar"; exit 1; }

# Executar com arquivo de teste
if [ -f ./saida ]; then
    ./saida teste_parser.txt
else
    echo "Erro: executável 'saida' não foi gerado"
    exit 1
fi