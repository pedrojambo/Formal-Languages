%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof, invalido, valido, id, li, lf, ob, comentario, 
    loop_while, condicao_if, condicao_else, tipo_var, chamada_return, 
    chamada_fn, tipo_bool, tipo_int, tipo_float, bool_true, bool_false, outros
} TOKEN;

%}

IDENTIFICADOR       [a-zA-Z][a-zA-Z0-9_]*
LITERAL_INTEIRO     [1-9][0-9]*
LITERAL_FLOAT       [+-]?([0-9]*[.])?[0-9]+      
OPERADOR_BINARIO    [+]|[-]|[\=][\=]|[\!][\=]
COMENTARIO          [+-]?([0-9]*[.])?[0-9]+
WHILE               while  
IF                  if
ELSE                else
VAR                 var
RETURN              return
FN                  fn
BOOL                boolean
INT                 int
FLOAT               float
TRUE                true
FALSE               false
OUTROS              [\=\(\)\{\}\;\,\:]
INVALIDO            (.)*

%%

<<EOF>>                 { return eof; }
{LITERAL_INTEIRO}       { return li; }
{LITERAL_FLOAT}         { return lf; }
{OPERADOR_BINARIO}      { return ob; }
{WHILE}                 { return loop_while; }
{IF}                    { return condicao_if; }
{ELSE}                  { return condicao_else; }
{VAR}                   { return tipo_var; }
{RETURN}                { return chamada_return; }
{FN}                    { return chamada_fn; }
{BOOL}                  { return tipo_bool; }
{INT}                   { return tipo_int; }
{FLOAT}                 { return tipo_float; }
{TRUE}                  { return bool_true; }
{FALSE}                 { return bool_false; }
{IDENTIFICADOR}         { return id; }
{OUTROS}                { return outros; }
{COMENTARIO}            { return comentario; }
{INVALIDO}              { return invalido; }


%%

int main(argc, argv) 
int argc;
char **argv;
{
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return (1); 
        }
    }
    TOKEN tk;
    while ( (tk = (TOKEN) yylex()) > invalido ) {
        printf("\n A palavra %s pertence a linguagem.\n", yytext);
    } else {
        printf("\n A string %s nao pertence linguagem.\n", yytext);
    }
    return 0;
}


