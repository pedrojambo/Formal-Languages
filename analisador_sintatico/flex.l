%option noyywrap

%{

#include "bison.tab.h"

int linha = 1;                                                                    /* contador de linhas */
int coluna = 1;                                                                   /* contador de colunas */
int contador_aninhado = 0;                                                        /* contador auxiliar para comentarios aninhados */
int inicio_comentario = 0;                                                        /* armazena a linha inicial de comentarios multilinha */

%}


%x  ComentarioMultilinha                         
                                                 /* "ComentarioMultilinha" é um estado especial "contexto" do flex que serve para         */
                                                 /* aplicação de condição de começo para as expressoes regulares do comentario multilinha */
                                                 
IDENTIFICADOR       [_]*[a-zA-Z][a-zA-Z0-9_]*
LITERAL_INTEIRO     0|[1-9][0-9]*
LITERAL_FLOAT       [+-]?([0-9]*[.])?[0-9]+      
OPERADOR_SOMA        \+
OPERADOR_SUBTRACAO   \-
OPERADOR_IGUALDADE  \=\=
OPERADOR_DIFERENCA  \!\=
COMENTARIO_1        \/\/[^\n\r]+?(?:\*\)|[\n\r])
WHILE               while  
IF                  if
ELSE                else
VAR                 var
RETURN              return
FN                  fn
BOOL                bool
INT                 int
FLOAT               float
TRUE                true
FALSE               false
IGUAL               \=
ABRE_PARENTESES     \(
FECHA_PARENTESES    \)
ABRE_CHAVE          \{
FECHA_CHAVE         \}
PONTO_VIRGULA       \;
VIRGULA             \,
PONTO_PONTO         \:
ESPACO              " "
NEWLINE             "\n"
INVALIDO            (.)

%%

<<EOF>>                 { return eof; }
{LITERAL_INTEIRO}       { return li; }
{LITERAL_FLOAT}         { return lf; }
{OPERADOR_SOMA}         { return soma; }
{OPERADOR_SUBTRACAO}    { return subtracao; }
{OPERADOR_IGUALDADE}    { return igualdade; }
{OPERADOR_DIFERENCA}    { return diferenca; }
{WHILE}                 { return loop_while; }
{IF}                    { return condicao_if; }
{ELSE}                  { return condicao_else; }
{VAR}                   { return var; }
{RETURN}                { return chamada_return; }
{FN}                    { return chamada_fn; }
{BOOL}                  { return tipo_bool; }
{INT}                   { return tipo_int; }
{FLOAT}                 { return tipo_float; }
{TRUE}                  { return bool_true; }
{FALSE}                 { return bool_false; }
{IDENTIFICADOR}         { return id; }

"/*"                  {inicio_comentario=linha;BEGIN(ComentarioMultilinha);}

<ComentarioMultilinha>{
  "/*"                { ++contador_aninhado;}
  "*"+"/"             { if (contador_aninhado) --contador_aninhado;
                        else {BEGIN(INITIAL); /* FAZER NADA */}}
  "*"+                 ; 
  [^/*\n]+             ;
  [/]                  ;
  \n                   ; linha++;
}

{COMENTARIO_1}          { /* FAZER NADA */ }
{IGUAL}                 { return igual; }
{ABRE_PARENTESES}       { return abre_parenteses; }
{FECHA_PARENTESES}      { return fecha_parenteses; }
{ABRE_CHAVE}            { return abre_chave; }
{FECHA_CHAVE}           { return fecha_chave; }
{PONTO_VIRGULA}         { return ponto_virgula; }
{VIRGULA}               { return virgula; }
{PONTO_PONTO}           { return ponto_ponto; }
{ESPACO}                { return espaco; }
{NEWLINE}               { return newline; }
{INVALIDO}              { return invalido; }

%%

