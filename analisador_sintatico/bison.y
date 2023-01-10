%{
#include <stdio.h>
#include <stdlib.h>
%}

/* declare tokens */
%token eof
%token li
%token lf
%token soma
%token subtracao
%token igualdade
%token diferenca
%token loop_while
%token condicao_if
%token condicao_else
%token var
%token chamada_return
%token chamada_fn
%token tipo_bool
%token tipo_int
%token tipo_float
%token bool_true
%token bool_false
%token id
%token igual
%token abre_parenteses
%token fecha_parenteses
%token abre_chave
%token fecha_chave
%token ponto_virgula
%token virgula
%token ponto_ponto
%token espaco
%token newline
%token invalido

%%

iput: /* vazio */
 | declaracao ponto_virgula input{ /* faz algo */ }
 ;

declaracao: funcao { /* faz algo */ }
 | variavel { /* faz algo */ }
 ;

variavel: var id ponto_ponto tipo_int igual valor_int ponto_virgula { /* faz algo */ }
 | var id ponto_ponto tipo_float igual valor_float ponto_virgula { /* faz algo */ }
 | var id ponto_ponto tipo_bool igual valor_boolean ponto_virgula { /* faz algo */ }
 ;

valor_int: /* vazio */
 | li { /* faz algo */ }
 ; 

 valor_float: /* vazio */
 | lf { /* faz algo */ }
 ; 

 valor_boolean: /* vazio */
 | bool_true { /* faz algo */ }
 | bool_false { /* faz algo */ }
 ; 

funcao: chamada_fn id  { /* faz algo */ }
 |  { /* faz algo */ }
 ;

term: NUMBER 
 | ABS term   { $$ = $2 >= 0? $2 : - $2; }
;
%%
main(int argc, char **argv)
{
  yyparse();
}

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
