## -ANALISADOR SINTÁTICO-

## Execução:

```
1 - $ make

2 - $ ./analise <arquivo_do_programa> <nome_do_arquivo_de_saida>
```

## Especificações:

Atualmente no nosso programa, assim como solicitado, na sequência de comandos presente na definições de funções e em condicionais IF e loops WHILE, os comandos devem ser separados pelo token terminador "ponto e vírgula". Assim, dentro de qualquer sequência de comandos, tendo em vista que um condicional IF que possua um condicional ELSE é considerado apenas um único comando, em condicionais IF com presença do token ELSE, o token terminador ponto e vírgula deve ser aplicado apenas após a sequência entre chaves da condição ELSE:

```c
fn demonstracao () : bool {
    if (true) {         // IF com presenca de else
        bruna = 1;
    }                   // ";" nao aplicado
    else{
        gustavo = 2;
    };                  // ";" aplicado apos descricao do IF

    if (true) {         // IF sem presenca de ELSE
        pedro = 3;
    };                  // ";" aplicado apos descricao do IF
};
```

Ademais, uma condição, presente em condicionais IF e loops WHILE, são detectados apenas as condições "true" ou expressões comparadas utilizando "==" ou "!=":

```c
fn compra (valor float) : bool {
    while (true) {       // true
        if (x != y) {};  // exp diferenca exp
        if (x == y) {};  // exp igualdade exp
    };
};
```

Por fim, operações devem ser feitas utilizando espaçamento adequado, tendo em vista que valores podem conter um sinal de menos ("-"), indicando que o valor é negativo. Assim, seguem as instruções:

```c
var correto     : int = 2 + 39 - 2; 
// funciona!!
var incorreto   : int = 2+39-2; 
// nao funciona!!
```