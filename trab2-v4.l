%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof, espaco, id, li, lf, ob, comentario, 
    loop_while, condicao_if, condicao_else, tipo_var, chamada_return, 
    chamada_fn, tipo_bool, tipo_int, tipo_float, bool_true, bool_false,
    outros, newline
} TOKEN;
int line = 1;
int col  = 1;

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
ESPACO              " *"
NEWLINE             "\n"

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
{ESPACO}                { return espaco; }
{NEWLINE}               { return newline; }


%%

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    TOKEN tk;
    while ( 1 ) {
        tk = (TOKEN) yylex();
        switch (tk){
            case eof:
            return 0;
            case espaco:
            col+=yyleng;
            break;        
            case id:
            printf("\nToken: %s | Tipo: identificador | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case li:
            printf("\nToken: %s | Tipo: inteiro literal | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case lf:
            printf("\nToken: %s | Tipo: float literal | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case ob:
            printf("\nToken: %s | Tipo: operador binario | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case comentario:
            printf("\nToken: %s | Tipo: comentario | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case loop_while:
            printf("\nToken: %s | Tipo: loop while | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case condicao_if:
            printf("\nToken: %s | Tipo: condicao if | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case condicao_else:
            printf("\nToken: %s | Tipo: condicao else | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case tipo_var:
            printf("\nToken: %s | Tipo: tipo var | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case tipo_bool:
            printf("\nToken: %s | Tipo: tipo boleano | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case tipo_float:
            printf("\nToken: %s | Tipo: tipo floar | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case tipo_int:
            printf("\nToken: %s | Tipo: tipo int | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case chamada_return:
            printf("\nToken: %s | Tipo: chamada return | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case chamada_fn:
            printf("\nToken: %s | Tipo: chamada fn | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case bool_true:
            printf("\nToken: %s | Tipo: boleano true | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;        
            case bool_false:
            printf("\nToken: %s | Tipo: boleano false | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break;     
            case outros:
            printf("\nToken: %s | Tipo: outros | Linha: %d | Coluna: %d\n", yytext, line, col);
            col+=yyleng;
            break; 
            case newline:
            line++;
            col=1;
            break;     
        }
    }
    return 0;
}