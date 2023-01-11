%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern FILE *yyin;
extern FILE *yyout;

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}

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
%token newline
%token invalido

%%

input: /* vazio */ { printf("input vazio --> input\n"); }
 | declaracao { printf("declaracao --> input\n"); }
 | input declaracao { printf("input declaracao --> input\n"); }
 ;

declaracao: funcao { printf("funcao --> declaracao\n"); }
 | variavel { printf("variavel --> declaracao\n"); }
 ;

variavel: var id ponto_ponto tipo igual exp ponto_virgula { printf("com init --> variavel\n"); }
 | var id ponto_ponto tipo ponto_virgula { printf("sem initi --> variavel\n"); }
 ; 

funcao: chamada_fn id abre_parenteses parametros fecha_parenteses ponto_ponto tipo abre_chave definicao fecha_chave ponto_virgula {printf("chamada_fn id abre_parenteses parametros fecha_parenteses ponto_ponto tipo abre_chave definicao fecha_chave ponto_virgula --> funcao\n");}
 ;

 tipo: tipo_bool { printf("tipo_bool --> tipo\n"); }
  | tipo_float { printf("tipo_float --> tipo\n");}
  | tipo_int { printf("tipo int --> tipo\n"); }
  ;

parametros: /* vazia */
 | id tipo virgula parametros { printf("parametros id tipo virgula --> parametros\n"); }
 | id tipo { printf("id tipo virgula --> parametros\n"); }
 ;

definicao:  /* vazia */
 | sequencia_variavel sequencia_comandos { printf("sequencia_variavel sequecia_comandos --> definicao\n"); }
 ;

sequencia_variavel: /* vazia */
 | sequencia_variavel variavel          { printf("sequecia_variavel variavel --> sequencia_variavel\n"); }
 | variavel                             { printf("variavel --> sequencia_variavel\n"); }
 ;

sequencia_comandos:  /* vazia */
 | sequencia_comandos comandos          { printf("sequecia_comandos comandos --> sequencia_comandos\n"); }
 | comandos                             { printf("comandos --> sequencia_comandos\n"); }
 ;

comandos: atribuicao                    { printf("atribuicao ponto_virgula --> comandos\n"); }
 | condicional                          { printf("condicional --> comandos\n"); }
 | laco                                 { printf("laco --> comandos\n"); }
 | chamada_return exp ponto_virgula     { printf("chamada_return exp --> retorno\n"); }
 ;

atribuicao: id igual exp ponto_virgula  { printf("idigual exp ponto_virgula --> atribuicao\n"); }
 ;

exp: id                                 { printf("id --> exp\n"); } 
 | li                                   { printf("valor int --> exp\n"); }
 | lf                                   { printf("valor float --> exp\n"); }
 | bool_false                           { printf("valor false --> exp\n"); }
 | bool_true                            { printf("valor true --> exp\n"); }
 | exp soma exp                         { printf("exp soma exp --> exp\n"); }
 | exp subtracao exp                    { printf("exp subtracao exp- --> exp\n"); }
 | abre_parenteses exp fecha_parenteses { printf("abre_parenteses exp fecha_parenteses --> exp\n"); }
 ;

condicional: condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave condicao_else abre_chave sequencia_comandos fecha_chave { { printf("condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave condicao_else abre_chave sequencia_comandos fecha_chave --> condicional\n"); } }
 | condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave { printf("condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave --> condicional\n"); }
 ;

condicao: exp comparador exp            { printf("exp comparador exp --> condicao while\n"); }
 | bool_true                            { printf("true --> condicao while\n"); }
 ;

comparador: igualdade                   { printf("igualdade --> comparador\n"); }
 | diferenca                            { printf("diferenca --> comparador\n"); }
 ;

laco: loop_while abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave { printf("loop_while abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave --> laco\n"); }
 ;

%%
int main(int argc, char *argv[])
{
  if (argc == 1)
    yyparse();

  if (argc == 2) {
    yyin = fopen(argv[1], "r");
    yyparse();
  }
}

