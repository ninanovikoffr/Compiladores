#!/bin/bash

set -e

bison -d -o parser.c Trab.y
flex -o lexer.c Trab.l
mkdir -p output
gcc parser.c lexer.c -lfl -o output/saida

./output/saida "$@"
