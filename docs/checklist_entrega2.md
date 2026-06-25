# Checklist — Entrega 2: Analisador Sintático com Bison

## 1. Integração Flex + Bison

- [x] Criar arquivo `Trab.y` com gramática em Bison.
- [x] Criar script para rodar Bison + Flex + GCC.
- [ ] Resolver definitivamente onde ficará a `main`:
- [ ] Garantir que o programa rode com:

```bash
./saida teste.txt
```

---

## 2. Declarações de variáveis e tipos

- [x] Existe regra para tipos:

```bison
tipo_dado:
    TD_INTEGER
    | TD_FLOAT
    | TD_BOOL
;
```

- [x] Existe regra para declaração de variáveis:

```bison
declaracao_variavel:
    tipo_dado lista_declaracao_variavel ';'
;
```

- [x] Aceita múltiplas variáveis em uma declaração:

```c
int $a, $b, $c;
```

- [x] Aceita declaração com atribuição:

```c
int $x = 10;
```

- [~] Ajustar `tipo_dado` para retornar valor com `$$`, caso você queira salvar o tipo na tabela.
- [x] Adicionar campo `tipo` na `struct Simbolo`.
- [~] Salvar o tipo declarado no símbolo correspondente.
- [ ] Decidir se a tabela de símbolos será apenas léxica ou se já vai armazenar informações básicas da etapa semântica.

---

## 3. Declaração e chamada de funções

- [x] Existe regra para declaração de função:

```bison
declaracao_funcao:
    tipo_dado ID '(' parametros ')' bloco
;
```

- [x] Existe regra para parâmetros.
- [x] Existe regra para chamada de função:

```bison
chamada_funcao:
    ID '(' argumentos ')'
;
```

- [x] Existe regra para argumentos.
- [ ] Falta testar chamadas com:

```c
$soma(1, 2);
```

- [ ] Falta testar função sem parâmetros.
- [ ] Falta testar função com vários parâmetros.
- [ ] Falta decidir se a função poderá retornar `bool`, `int` e `float`.
- [ ] Falta verificar se será necessário permitir função sem retorno, tipo `void`. O enunciado não exige diretamente.

---

## 4. Atribuição

- [x] Existe regra de atribuição:

```bison
atribuicao:
    ID OP_ATRIBUICAO expressao
;
```

- [x] Aceita atribuição como comando:

```bison
atribuicao ';'
```

- [ ] Falta testar atribuições com expressões aritméticas.
- [ ] Falta testar atribuições com expressões relacionais/lógicas.
- [ ] Erros de tipo ficam para etapa semântica, não para essa entrega.

---

## 5. Condicionais `if/else`

- [x] Existe tentativa de gramática para `if/else`.
- [~] Atualmente ainda há conflito relacionado ao `if/else`.
- [ ] Simplificar a gramática de `if/else`, já que seus blocos usam `{ }`.
- [ ] Substituir `matched_if` / `open_if` por uma forma mais simples:

```bison
comando_condicional:
    PR_IF '(' expressao ')' bloco
    | PR_IF '(' expressao ')' bloco PR_ELSE bloco
;
```

- [ ] Testar:

```c
if ($x > 0) {
    print($x);
}
```

- [ ] Testar:

```c
if ($x > 0) {
    print($x);
} else {
    print(0);
}
```

- [ ] No relatório, explicar a decisão tomada para resolver o `dangling else`.

---

## 6. Laços `while`

- [x] Existe regra para `while`.
- [ ] Preferir usar `bloco` em vez de repetir `{ comandos }`:

```bison
comando_repeticao:
    PR_WHILE '(' expressao ')' bloco
;
```

- [ ] Testar:

```c
while ($x < 10) {
    $x = $x + 1;
}
```

---

## 7. Blocos e comandos compostos `{ }`

- [x] Existe regra de bloco:

```bison
bloco:
    '{' comandos '}'
;
```

- [x] Existe regra para lista de comandos.
- [~] A regra atual de `comandos` está redundante:

```bison
comandos:
    lista_comandos comando
    | /* vazio */
;
```

- [ ] Testar bloco vazio:

```c
if ($x > 0) {
}
```

- [ ] Testar bloco com vários comandos.

---

## 8. Entrada e saída `print` e `read`

- [x] Existe regra para `print`.
- [x] Existe regra para `read`.
- [x] `read` aceita somente `ID`, o que faz sentido:

```bison
PR_READ '(' ID ')' ';'
```

- [x] `print` aceita `expressao`, mas falta garantir que `LITERAL` esteja dentro de `expressao_fator`.
- [ ] Testar:

```c
print($x);
print(10);
print("texto");
read($x);
```

---

## 9. Expressões aritméticas, relacionais e lógicas

- [x] Existe separação por níveis:
  - expressão lógica OR;
  - expressão lógica AND;
  - negação;
  - expressão relacional;
  - expressão aritmética;
  - termo;
  - fator.
- [x] A estrutura já indica precedência.
- [x] Aritmética tem `+`, `-`, `*`, `/`.
- [x] Relacionais têm `<`, `>`, `==`, `<=`, `>=`, `!=`.
- [x] Lógicos têm `&&`, `||`, `!`.
- [x] Já existe tratamento para menos unário:

```bison
OA_MINUS expressao_fator
```

- [ ] Verificar se o menos unário ainda gera conflito.
- [ ] No relatório, comentar a ambiguidade do `-`, explicando diferença entre:

```c
$x - 1
```

e:

```c
-$x
```

---

## 10. Literais

- [x] O Flex reconhece literal:

```lex
\"[^"\n]*\"
```

- [x] O token `LITERAL` está declarado no Bison com tipo:

```bison
%token <texto> LITERAL
```

- [~] Falta guardar o texto no `yylval`:

```c
yylval.texto = strdup(yytext);
```

- [ ] Testar:

```c
print("Olá");
```

- [ ] Decidir se atribuição de literal será aceita sintaticamente:

```c
$nome = "Ana";
```

A compatibilidade de tipo pode ficar para a etapa semântica.

---

## 11. Comentários

- [x] Comentário de uma linha já é tratado no Flex:

```lex
"//".*
```

- [x] Comentário de múltiplas linhas já é tratado no Flex:

```lex
"/*" ... "*/"
```

- [x] Comentários são ignorados e não chegam ao Bison.
- [x] Existe erro léxico para comentário multilinha não fechado.
- [ ] No relatório, explicar que comentários são removidos no analisador léxico e, por isso, não aparecem na gramática BNF do Bison.

---

## 12. Erros sintáticos com linha e coluna

- [~] Existe `yyerror`, mas ainda genérico:

```c
void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}
```

- [ ] Melhorar `yyerror` para mostrar linha e coluna.
- [ ] Expor `column_number` do Flex para o Bison com:

```c
extern int column_number;
extern int yylineno;
```

- [ ] Alterar `yyerror` para algo como:

```c
void yyerror(const char *s) {
    fprintf(stderr, "Erro sintático na linha %d, coluna %d: %s\n",
            yylineno, column_number, s);
}
```

- [ ] Testar erro sintático proposital:

```c
int $x
```

sem `;`.

- [ ] Testar erro com parêntese faltando.
- [ ] Testar erro com chave faltando.

---

## 13. Ambiguidades e conflitos

- [ ] Corrigir conflito redução/redução causado por:

```bison
elemento -> declaracao_variavel
elemento -> comando -> declaracao_variavel
```

- [x] Remover `declaracao_variavel` de um dos caminhos.
- [ ] Corrigir conflito do `if/else`.
- [ ] Rodar:

```bash
bison -d -Wcounterexamples -o parser.c Trab.y
```

- [ ] Confirmar se os conflitos desapareceram ou justificar no relatório.
- [ ] No relatório, apresentar os estados LR(0) com conflitos que apareceram durante o desenvolvimento.
- [ ] Comentar o conflito de `declaracao_variavel`.
- [ ] Comentar o conflito de `dangling else`.
- [ ] Comentar possível conflito do `-`, caso apareça.

---

## 14. Organização e comentários no código

- [~] O Flex está bem separado por comentários.
- [~] O Bison ainda precisa de comentários explicativos.
- [ ] Adicionar comentários no `Trab.y` separando:
  - símbolo inicial;
  - declarações;
  - funções;
  - comandos;
  - condicionais;
  - laços;
  - entrada/saída;
  - expressões.
- [ ] Revisar nomes dos não-terminais para ficarem consistentes.

---

## 15. Correções pendentes no Flex

- [~] Em literal, adicionar:

```c
yylval.texto = strdup(yytext);
```

- [ ] Decidir se a tabela de símbolos será impressa após `yyparse()`.

---

## 16. Arquivo de teste

- [ ] Criar um `teste.txt` pequeno, mas completo.
- [ ] O teste deve conter:
  - declaração de variável;
  - declaração de função;
  - chamada de função;
  - atribuição;
  - `if`;
  - `if/else`;
  - `while`;
  - bloco `{ }`;
  - `print`;
  - `read`;
  - expressão aritmética;
  - expressão relacional;
  - expressão lógica;
  - comentário de linha;
  - comentário de múltiplas linhas;
  - literal string.
- [ ] Guardar a saída gerada para colocar no relatório.

---

## 17. Relatório

- [ ] Apresentar a gramática completa em BNF.
- [ ] Explicar decisões de projeto:
  - tokens específicos em vez de tokens genéricos;
  - uso de `yylval` apenas para tokens com valor semântico;
  - comentários tratados no léxico;
  - blocos obrigatórios em `if/else`;
  - precedência de expressões pela estrutura da gramática.
- [ ] Discutir dificuldades encontradas:
  - integração Flex + Bison;
  - `main` duplicada;
  - uso de `yywrap`;
  - conflito de `declaracao_variavel`;
  - conflito de `if/else`;
  - uso de `yylval`, `%union`, `%token` e `%type`.
- [ ] Calcular FIRST e FOLLOW apenas dos não-terminais de expressão:
  - `expressao`
  - `expressao_ou`
  - `expressao_e`
  - `expressao_not`
  - `expressao_relacional`
  - `expressao_aritmetica`
  - `expressao_termo`
  - `expressao_fator`
  - `operador_relacional`
- [ ] Apresentar estados LR(0) com conflitos.
- [ ] Comentar os conflitos e como foram resolvidos.
- [ ] Incluir arquivo de teste.
- [ ] Incluir saída do teste.

---

## 19. Granularidade e verbosidade da Etapa 1

- [x] Correções principais da Etapa 1 já foram tratadas.
- [ ] Revisar se as mensagens léxicas estão com granularidade adequada.
- [ ] Revisar se os nomes dos tokens impressos estão padronizados.
- [ ] Verificar se a saída léxica não está verbosa demais para o relatório.
- [ ] Verificar se os erros léxicos estão claros, mas sem excesso.
- [ ] Confirmar com o padrão esperado pelo professor.

---
