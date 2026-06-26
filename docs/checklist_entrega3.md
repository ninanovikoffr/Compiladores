# Checklist — Etapa 3: Análise Semântica e Geração de IR

## 1. Análise Semântica

### Tabela de símbolos e escopos

* [x] Manter tabela de símbolos com identificador, tipo e nível de escopo
* [x] Abrir novo escopo ao entrar em `{`
* [x] Fechar escopo ao sair de `}`
* [x] Buscar identificadores respeitando escopos aninhados
* [x] Detectar variável não declarada
* [x] Detectar redeclaração no mesmo escopo

### Verificação de tipos

* [x] Verificar compatibilidade em atribuições
* [x] Permitir promoção implícita de `int` para `float`
* [ ] Verificar operadores aritméticos `+`, `-`, `*`, `/`
* [ ] Implementar/verificar operador `%` apenas para `int`
* [ ] Verificar operadores relacionais `==`, `!=`, `<`, `<=`, `>`, `>=`
* [x] Fazer operadores relacionais retornarem valor inteiro `0` ou `1`
* [ ] Verificar operadores lógicos `!`, `&&`, `||`
* [ ] Fazer operadores lógicos aceitarem expressões numéricas
* [ ] Fazer operadores lógicos retornarem valor inteiro `0` ou `1`
* [ ] Verificar `-` unário para `int` e `float`
* [ ] Verificar `!` unário para expressões numéricas

### Comandos e construções

* [ ] Verificar condição de `if`
* [ ] Verificar condição de `while`
* [ ] Verificar se `read(ID)` usa identificador declarado
* [-] Verificar chamadas de função
* [-] Verificar quantidade de argumentos em funções
* [-] Verificar tipos dos argumentos em funções
* [-] Verificar tipo de retorno das funções

### Erros semânticos

* [x] Exibir erro de variável não declarada com linha e coluna
* [ ] Exibir erro de redeclaração com linha e coluna
* [x] Exibir erro de incompatibilidade de tipos com linha e coluna
* [x] Contabilizar erros semânticos
* [ ] Impedir mensagem de sucesso caso existam erros semânticos

---

## 2. Geração de Código Intermediário — IR

### Estrutura básica da IR

* [ ] Criar função para gerar temporários `t1`, `t2`, `t3`, ...
* [ ] Criar função para gerar rótulos `L1`, `L2`, `L3`, ...
* [ ] Criar função para emitir instruções de IR
* [ ] Definir conjunto mínimo de instruções da IR

### Expressões

* [ ] Gerar IR para expressões aritméticas
* [ ] Gerar IR para expressões relacionais
* [ ] Gerar IR para expressões lógicas
* [ ] Gerar IR para operadores unários
* [ ] Armazenar o temporário resultante de cada expressão

### Atribuições e entrada/saída

* [ ] Gerar IR para atribuição
* [ ] Gerar IR para `print`
* [ ] Gerar IR para `read`

### Controle de fluxo

* [ ] Gerar IR para `if`
* [ ] Gerar IR para `if/else`
* [ ] Gerar IR para `while`
* [ ] Usar rótulos corretamente em desvios condicionais
* [ ] Usar `goto` quando necessário

### Funções

* [ ] Gerar IR para declaração de função
* [ ] Gerar IR para parâmetros
* [ ] Gerar IR para chamada de função
* [ ] Gerar IR para `return`

---

## 3. Relatório da Etapa 3

* [ ] Descrever a estrutura da tabela de símbolos
* [ ] Explicar o gerenciamento de escopos
* [ ] Apresentar tabela de regras de tipagem
* [ ] Explicar geração de IR para `if/else`
* [ ] Explicar geração de IR para `while`
* [ ] Incluir programa de teste
* [ ] Incluir IR gerado pelo compilador
* [ ] Apresentar pelo menos uma Tradução Dirigida por Sintaxe
* [ ] Discutir decisões de projeto
* [ ] Discutir dificuldades encontradas
