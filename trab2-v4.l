%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof, x, invalido, espaco, id, li, lf, soma, subtracao,
    igualdade, diferenca, comentario_1, comentario_2, 
    loop_while, condicao_if, condicao_else, tipo_var, chamada_return, 
    chamada_fn, tipo_bool, tipo_int, tipo_float, bool_true, bool_false,
    newline, igual, abre_parenteses, fecha_parenteses, abre_chave,
    fecha_chave, ponto_virgula, virgula, ponto_ponto
} TOKEN;
int linha = 1;
int coluna  = 1;
int count = 0;
char comentario_multilinha[1000000];
%}

%x  MultipleLinesComment 

IDENTIFICADOR       [a-zA-Z][a-zA-Z0-9_]*
LITERAL_INTEIRO     [1-9][0-9]*
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
BOOL                boolean
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
{VAR}                   { return tipo_var; }
{RETURN}                { return chamada_return; }
{FN}                    { return chamada_fn; }
{BOOL}                  { return tipo_bool; }
{INT}                   { return tipo_int; }
{FLOAT}                 { return tipo_float; }
{TRUE}                  { return bool_true; }
{FALSE}                 { return bool_false; }
{IDENTIFICADOR}         { return id; }

"/*"                        { for(int i = 0;i<strlen(comentario_multilinha);i++){
                                comentario_multilinha[i]='\0';
                            }   count=linha; BEGIN(MultipleLinesComment); strcat(comentario_multilinha, yytext); }
<MultipleLinesComment>.      strcat(comentario_multilinha, yytext);
<MultipleLinesComment>"\n"   linha++; strcat(comentario_multilinha, yytext);
<MultipleLinesComment>"*/"   strcat(comentario_multilinha, yytext);{
                            BEGIN(INITIAL);
                            return comentario_2;
                            for(int i = 0;i<strlen(comentario_multilinha);i++){
                                comentario_multilinha[i]='\0';
                            }
                            count=0;
                        }

{COMENTARIO_1}          { return comentario_1; }
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
            coluna+=yyleng;
            break;        
            case id:
            printf("\nToken: %s | Tipo: identificador | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case li:
            printf("\nToken: %s | Tipo: inteiro literal | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case lf:
            printf("\nToken: %s | Tipo: float literal | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case soma:
            printf("\nToken: %s | Tipo: operador soma | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case diferenca:
            printf("\nToken: %s | Tipo: operador subtracao | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case igualdade:
            printf("\nToken: %s | Tipo: operador igualdade | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case subtracao:
            printf("\nToken: %s | Tipo: operador diferenca | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case comentario_1:
            printf("\nToken: %s | Tipo: comentario de uma linha | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            linha++;
            break;  
            case comentario_2:
            printf("\nToken: %s \n\nTipo: comentario multilinha | Linha: %d até linha %d\n", comentario_multilinha, count, linha);  
            coluna+=yyleng;
            break;         
            case loop_while:
            printf("\nToken: %s | Tipo: loop while | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case condicao_if:
            printf("\nToken: %s | Tipo: condicao if | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case condicao_else:
            printf("\nToken: %s | Tipo: condicao else | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case tipo_var:
            printf("\nToken: %s | Tipo: tipo var | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case tipo_bool:
            printf("\nToken: %s | Tipo: tipo boleano | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case tipo_float:
            printf("\nToken: %s | Tipo: tipo floar | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case tipo_int:
            printf("\nToken: %s | Tipo: tipo int | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case chamada_return:
            printf("\nToken: %s | Tipo: chamada return | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case chamada_fn:
            printf("\nToken: %s | Tipo: chamada fn | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case bool_true:
            printf("\nToken: %s | Tipo: boleano true | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;        
            case bool_false:
            printf("\nToken: %s | Tipo: boleano false | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break;     
            case igual:
            printf("\nToken: %s | Tipo: operador de atribuição | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case abre_parenteses:
            printf("\nToken: %s | Tipo: abre parenteses | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case fecha_parenteses:
            printf("\nToken: %s | Tipo: fecha parenteses | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case abre_chave:
            printf("\nToken: %s | Tipo: abre chaves | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case fecha_chave:
            printf("\nToken: %s | Tipo: fecha chaves | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case ponto_virgula:
            printf("\nToken: %s | Tipo: ponto e virgula | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case virgula:
            printf("\nToken: %s | Tipo: virgula | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case ponto_ponto:
            printf("\nToken: %s | Tipo: dois pontos | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case invalido:
            printf("\nToken: %s | Tipo: nao reconhecido | Linha: %d | Coluna: %d\n", yytext, linha, coluna);
            coluna+=yyleng;
            break; 
            case newline:
            linha++;
            coluna=1;
            break;     
        }
    }
    return 0;
}