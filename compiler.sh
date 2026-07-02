#!/bin/bash

set -e

mkdir -p build
bison -d -o build/parser.c src/Trab.y
flex -o build/lexer.c src/Trab.l
mkdir -p output
gcc build/parser.c build/lexer.c -lfl -o output/saida

./output/saida "$@"
