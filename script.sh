#!/bin/bash

# Compilar o arquivo flex
flex Trab.l

# Compilar o lex.yy.c gerado
gcc lex.yy.c -ll -o saida

# Executar a saida com arquivo de teste
./saida < teste.txt
