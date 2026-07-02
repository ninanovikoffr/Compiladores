CC := gcc
FLEX := flex
BISON := bison

SRC_DIR := src
BUILD_DIR := build
OUTPUT_DIR := output
TARGET := $(OUTPUT_DIR)/saida
TEST_INPUT := tests/fonte_sucesso_ir.txt

PARSER_C := $(BUILD_DIR)/parser.c
PARSER_H := $(BUILD_DIR)/parser.h
LEXER_C := $(BUILD_DIR)/lexer.c

.PHONY: all run clean

all: $(TARGET)

$(BUILD_DIR) $(OUTPUT_DIR):
	mkdir -p $@

$(PARSER_C) $(PARSER_H): $(SRC_DIR)/Trab.y | $(BUILD_DIR)
	$(BISON) -d -o $(PARSER_C) $<

$(LEXER_C): $(SRC_DIR)/Trab.l $(PARSER_H) | $(BUILD_DIR)
	$(FLEX) -o $@ $<

$(TARGET): $(PARSER_C) $(LEXER_C) | $(OUTPUT_DIR)
	$(CC) $(PARSER_C) $(LEXER_C) -lfl -o $@

run: $(TARGET)
	./$(TARGET) $(TEST_INPUT)

clean:
	rm -f $(PARSER_C) $(PARSER_H) $(LEXER_C) $(TARGET)
