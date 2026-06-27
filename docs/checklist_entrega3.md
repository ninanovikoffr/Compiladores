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
* [x] Criar função para emitir instruções de IR
* [x] Criar função para imprimir o código intermediário gerado
* [x] Chamar a impressão da IR no `main`
* [x] Definir conjunto mínimo de instruções da IR

### Expressões

* [x] Gerar IR para expressões aritméticas
* [x] Gerar IR para expressões relacionais
* [x] Gerar IR para expressões lógicas
* [x] Gerar IR para operadores unários
* [x] Armazenar o temporário resultante de cada expressão
* [x] Propagar, junto com o tipo da expressão, o endereço/temporário usado na IR

### Atribuições e entrada/saída

* [x] Gerar IR para atribuição
* [x] Gerar IR para inicialização de variável com atribuição
* [x] Gerar IR para `print`
* [x] Gerar IR para `read`

### Controle de fluxo

* [x] Gerar IR para `if`
* [x] Gerar IR para `if/else`
* [x] Gerar IR para `while`
* [x] Usar rótulos corretamente em desvios condicionais
* [x] Usar `goto` quando necessário
* [x] Separar rótulos de início, falso e saída nos comandos de controle

### Funções

* [x] Gerar IR para início/fim de declaração de função
* [x] Gerar IR para parâmetros
* [x] Gerar IR para chamada de função
* [x] Gerar IR para passagem de argumentos
* [x] Gerar IR para receber valor retornado por chamada de função
* [x] Gerar IR para `return`

---
