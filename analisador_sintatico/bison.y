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

declaracao: funcao { printf("declaracao de funcao") }
 | variavel { printf("declaracao de variavel") }
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

funcao: chamada_fn id abre_parenteses parametros fecha_parenteses ponto_ponto tipo ponto_ponto tipo abre_chave definicao fecha_chave ponto_virgula { /* faz algo */ }
 ;

 tipo: tipo_bool
 | tipo_float { /* faz algo */ }
 | tipo_int { /* faz algo */ }
 ;

parametros: /* vazia */
 | parametros virgula id tipo { /* faz algo */ }
 | virgula id tipo { /* faz algo */ }
 ;

definicao: sequencia_variavel sequencia_comandos { /* faz algo */ }
 ;

sequencia_variavel: /* vazia */
 | sequencia_variavel variavel { /* faz algo */ }
 | variavel { /* faz algo */ }
 ;

comandos: atribuicao ponto_virgula { /* faz algo */ }
 | condicional { /* faz algo */ }
 | laco { /* faz algo */ }
 | retorno ponto_virgula{ /* faz algo */ }
 ;

atribuicao: id igual exp
 ;

exp: fator
 | exp soma fator { /* faz algo */ }
 | exp subtracao fator { /* faz algo */ }
 ;

fator: li { /* faz algo */ }
 | lf { /* faz algo */ }
 | id { /* faz algo */ } 
 ;

condicional: if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave else abre_chave sequencia_comandos fecha_chave { /* faz algo */ }
 | if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave { /* faz algo */ }
 ;

condicao: id comparador id { /* faz algo */ }
 | id comparador li { /* faz algo */ }
 | id comparador lf { /* faz algo */ }
 | li comparador id { /* faz algo */ }
 | lf comparador id { /* faz algo */ }
 | li comparador li { /* faz algo */ }
 | lf comparador lf { /* faz algo */ }
 ;

comparador: igualdade { /* faz algo */ }
 | diferenca { /* faz algo */ }
 ;

laco: while abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave
 ;

retorno: return exp
 ;

sequencia_comandos:  /* vazia */
 | sequencia_comandos comandos { /* faz algo */ }
 | comandos
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
