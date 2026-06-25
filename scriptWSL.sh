#!/bin/bash

# Gerar o parser com Bison
bison -d -o build/parser.c src/Trab.y || { echo "Erro ao gerar parser"; exit 1; }

# Gerar o analisador léxico com Flex
flex -o build/lexer.c src/Trab.l || { echo "Erro ao gerar lexer"; exit 1; }

# Compilar tudo junto
gcc build/parser.c build/lexer.c -lfl -o output/saida || { echo "Erro ao compilar"; exit 1; }

# Executar com arquivo de teste
if [ -f ./output/saida ]; then
    ./output/saida tests/teste_parser.txt
else
    echo "Erro: executável output/saida não foi gerado"
    exit 1
fi
