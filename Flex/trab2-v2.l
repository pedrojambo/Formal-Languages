%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

IDENTIFICADOR       [a-zA-Z][a-zA-Z0-9_]*
LITERAL_INTEIRO     [1-9][0-9]*
LITERAL_FLOAT       [+-]?([0-9]*[.])?[0-9]+      
OPERADOR_BINARIO    [+]|[-]|[\=][\=]|[\!][\=]
COMENTARIO          [+-]?([0-9]*[.])?[0-9]+
WHILE               [wW][hH][iI][lL][eE]  
IF                  [iI][fF]
ELSE                [eE][lL][sS][eE]
VAR                 [vV][aA][rR]
RETURN              [rR][eE][tT][uU][rR][nN]
FN                  [fF][nN]
BOOL                [bB][oO][oO][lL][eE][aA][nN]
INT                 [iI][nN][tT]
FLOAT               [fF][lL][oO][aA][tT]
TRUE                [tT][rR][uU][eE]
FALSE               [fF][aA][lL][sS][eE]
OUTROS              [\=\(\)\{\}\;\,\:]
INVALIDO            (.)*

%%

<<EOF>>                 { return eof; }
{LITERAL_INTEIRO}       { printf("\n A palavra %s é um inteiro literal.\n", yytext); return valido; }
{LITERAL_FLOAT}         { printf("\n A palavra %s é um float literal.\n", yytext); return valido; }
{OPERADOR_BINARIO}      { printf("\n A palavra %s é um operador binário.\n", yytext); return valido; }
{WHILE}                 { printf("\n A palavra %s é um loop while.\n", yytext); return valido; }
{IF}                    { printf("\n A palavra %s é uma operação if.\n", yytext); return valido; }
{ELSE}                  { printf("\n A palavra %s é uma operação else.\n", yytext); return valido; }
{VAR}                   { printf("\n A palavra %s é um tipo var.\n", yytext); return valido; }
{RETURN}                { printf("\n A palavra %s é uma chamada return.\n", yytext); return valido; }
{FN}                    { printf("\n A palavra %s é uma chamada fn.\n", yytext); return valido; }
{BOOL}                  { printf("\n A palavra %s é um tipo bool.\n", yytext); return valido; }
{INT}                   { printf("\n A palavra %s é uma chamada para inteiro.\n", yytext); return valido; }
{FLOAT}                 { printf("\n A palavra %s é uma chamada para float.\n", yytext); return valido; }
{TRUE}                  { printf("\n A palavra %s é um bool verdadeiro.\n", yytext); return valido; }
{FALSE}                 { printf("\n A palavra %s é um bool falso.\n", yytext); return valido; }
{IDENTIFICADOR}         { printf("\n A palavra %s é um identificador.\n", yytext); return valido; }
{OUTROS}                { printf("\n A palavra %s é um caracter misc.\n", yytext); return valido; }
{COMENTARIO}            { printf("\n A palavra %s é um comentário.\n", yytext); return valido; }
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
    
    if ( (TOKEN) yylex() == valido ) {
        printf("\n A palavra %s pertence a linguagem.\n", yytext);
    } else {
        printf("\n A string %s nao pertence linguagem.\n", yytext);
    }
    return 0;
}


