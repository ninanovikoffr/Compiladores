# Checklist — Etapa 3: Análise Semântica e Geração de IR

---

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
* [x] Verificar compatibilidade em inicialização de variável
* [x] Permitir promoção implícita de `int` para `float`
* [x] Verificar operadores aritméticos `+`, `-`, `*`, `/`
* [x] Implementar/verificar operador `%` apenas para `int`
* [x] Verificar operadores relacionais `==`, `!=`, `<`, `<=`, `>`, `>=`
* [x] Fazer operadores relacionais retornarem valor inteiro `0` ou `1`
* [x] Verificar operadores lógicos `!`, `&&`, `||`
* [x] Fazer operadores lógicos aceitarem expressões numéricas
* [x] Fazer operadores lógicos retornarem valor inteiro `0` ou `1`
* [x] Verificar `-` unário para `int` e `float`
* [x] Verificar `!` unário para expressões numéricas

### Comandos e construções

* [x] Verificar condição de `if`
* [x] Verificar condição de `while`
* [x] Verificar se `read(ID)` usa identificador declarado
* [x] Verificar se `read(ID)` não está tentando ler em uma função
* [x] Verificar chamadas de função
* [x] Verificar se o identificador chamado realmente é função
* [x] Verificar quantidade de argumentos em funções
* [x] Verificar argumentos extras em funções
* [x] Verificar argumentos faltando em funções
* [x] Verificar tipos dos argumentos em funções
* [x] Verificar tipo de retorno das funções

### Erros semânticos

* [x] Exibir erro de variável não declarada com linha e coluna
* [x] Exibir erro de redeclaração com linha e coluna
* [x] Exibir erro de incompatibilidade de tipos com linha e coluna
* [x] Exibir erro de uso indevido de função como variável/read
* [x] Exibir erro de chamada de identificador que não é função
* [x] Exibir erro de quantidade de argumentos em função
* [x] Exibir erro de tipo de argumento em função
* [x] Contabilizar erros semânticos
* [x] Impedir mensagem final de sucesso caso existam erros semânticos
* [x] Não executar/exibir análise semântica normal quando existem erros sintáticos

---

## 2. Geração de Código Intermediário — IR

### Estrutura básica da IR

* [x] Criar contador de temporários
* [x] Criar função para gerar temporários `t1`, `t2`, `t3`, ...
* [x] Criar contador de rótulos
* [x] Criar função para gerar rótulos `L1`, `L2`, `L3`, ...
* [x] Criar buffer/string para armazenar código intermediário
* [x] Criar função auxiliar para aumentar espaço do buffer de IR
* [ ] Criar função para emitir instruções de IR
* [ ] Criar função para imprimir o código intermediário gerado
* [ ] Chamar a impressão da IR no `main`
* [ ] Definir conjunto mínimo de instruções da IR

### Expressões

* [ ] Gerar IR para expressões aritméticas
* [ ] Gerar IR para expressões relacionais
* [ ] Gerar IR para expressões lógicas
* [ ] Gerar IR para operadores unários
* [ ] Armazenar o temporário resultante de cada expressão
* [ ] Propagar, junto com o tipo da expressão, o endereço/temporário usado na IR

### Atribuições e entrada/saída

* [ ] Gerar IR para atribuição
* [ ] Gerar IR para inicialização de variável com atribuição
* [ ] Gerar IR para `print`
* [ ] Gerar IR para `read`

### Controle de fluxo

* [ ] Gerar IR para `if`
* [ ] Gerar IR para `if/else`
* [ ] Gerar IR para `while`
* [ ] Usar rótulos corretamente em desvios condicionais
* [ ] Usar `goto` quando necessário
* [ ] Separar rótulos de início, falso e saída nos comandos de controle

### Funções

* [ ] Gerar IR para início/fim de declaração de função
* [ ] Gerar IR para parâmetros
* [ ] Gerar IR para chamada de função
* [ ] Gerar IR para passagem de argumentos
* [ ] Gerar IR para receber valor retornado por chamada de função
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

---
