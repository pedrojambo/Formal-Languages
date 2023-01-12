%{
/* importacao de bibliotecas */
#include <stdio.h>
#include <stdlib.h>

/* importacao de variaveis do flex */
extern int yylex();
extern FILE *yyin;
extern FILE *yyout;
FILE * fOut;                    /* declaracao do arquivo a ser criado */

/* declaracao da funcao obrigatoria de erro do bison */
void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}

%}

/* declaracao de tokens reconhecidos pelo flex */

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

/* gramaticas reconhecidas pelo analisador sintatico bison */

programa: /* vazio */ { fprintf(fOut, "programa vazio --> programa\n"); }              /* programa recebe input vazio ou sequencia de declaracoes */
 | declaracao { fprintf(fOut, "declaracao --> programa\n"); }
 | programa declaracao { fprintf(fOut, "programa declaracao --> programa\n"); }
 ;

declaracao: funcao { fprintf(fOut, "funcao --> declaracao\n"); }                       /* declaracao pode declarar uma funcao ou uma variavel */
 | variavel { fprintf(fOut, "variavel --> declaracao\n"); }
 ;

variavel: var id ponto_ponto tipo igual exp ponto_virgula { fprintf(fOut, "com init --> variavel\n"); }     /* variavel a ser declarada pode ser inicializada com valor ou nao */
 | var id ponto_ponto tipo ponto_virgula { fprintf(fOut, "sem init --> variavel\n"); }
 ; 

funcao: chamada_fn id abre_parenteses parametros fecha_parenteses ponto_ponto tipo abre_chave definicao fecha_chave ponto_virgula {fprintf(fOut, "chamada_fn id abre_parenteses parametros fecha_parenteses ponto_ponto tipo abre_chave definicao fecha_chave ponto_virgula --> funcao\n");}     /* forma unica para declaracoes de funcao: termo "fn" seguido do identificador da funcao, os parametros da funcao entre parenteses, dois pontos, o tipo retornado pela funcao, a definicao da funcao entre chaves e o token terminador ponto e virgula */
 ;

 tipo: tipo_bool { fprintf(fOut, "tipo_bool --> tipo\n"); }                                          /* declaracao de tipo usada na declaracao de funcao deve ser do tipo int, float ou bool */
  | tipo_float { fprintf(fOut, "tipo_float --> tipo\n");}
  | tipo_int { fprintf(fOut, "tipo_int --> tipo\n"); }
  ;

parametros: /* vazio */                                                                       
 | id tipo virgula parametros { fprintf(fOut, "id tipo virgula parametros --> parametros\n"); }      /* parametros da funcao podem ser vazios ou conter sequencias de pares de identificadores e tipos, separados por virgulas */
 | id tipo { fprintf(fOut, "id tipo --> parametros\n"); }
 ;

definicao:  /* vazia */                                                                              /* definicao da funcao pode ser vazia ou formada por uma sequencia de declaracao de variaveis, seguida de uma sequencia de comandos */
 | sequencia_variavel sequencia_comandos { fprintf(fOut, "sequencia_variavel sequencia_comandos --> definicao\n"); }    
 ;

sequencia_variavel: /* vazia */                                                                      /* a sequencia de declaracao de variaveis na definicao da funcao pode ser vazia ou conter sequencia ilimitada de variaveis */
 | sequencia_variavel variavel          { fprintf(fOut, "sequecia_variavel variavel --> sequencia_variavel\n"); }
 | variavel                             { fprintf(fOut, "variavel --> sequencia_variavel\n"); }
 ;

sequencia_comandos:  /* vazia */                                                                     /* a sequencia de comandos na definicao da funcao pode ser vazia ou conter sequencia ilimitada de comandos */
 | sequencia_comandos comandos          { fprintf(fOut, "sequencia_comandos comandos --> sequencia_comandos\n"); }
 | comandos                             { fprintf(fOut, "comandos --> sequencia_comandos\n"); }
 ;

comandos: atribuicao                    { fprintf(fOut, "atribuicao --> comandos\n"); }                          /* a sequencia de comandos na definicao da funcao pode conter 4 tipos de comandos: atribuicao, condicional, loop ou chamada_return */           
 | condicional                          { fprintf(fOut, "condicional --> comandos\n"); }                         /* um comando condicional e formado pelo termo if seguido de uma condicao e sua definicao, podendo ou nao ser seguido do token else e sua definicao contendo a serie de comandos a ser realizada caso a condicao do if nao seja cumprida e contendo token terminador ponto e vírgula ao fim do comando */
 | loop                                 { fprintf(fOut, "loop --> comandos\n"); }
 | chamada_return exp ponto_virgula     { fprintf(fOut, "chamada_return exp ponto_virgula --> retorno\n"); }     /* um comando chamada_return deve conter o termo return, seguido de uma expressao contendo o valor a ser retornado e o token terminador ponto e virgula */
 ;

atribuicao: id igual exp ponto_virgula  { fprintf(fOut, "id igual exp ponto_virgula --> atribuicao\n"); }        /* o comando atribuicao diz respeito a atribuicao de uma variavel qualquer utilizando o identificador da variavel, seguido de um sinal de igual e uma expressao contendo o valor a ser atribuido, alem do token terminador ponto e vírgula */
 ;

condicional: condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave condicao_else abre_chave sequencia_comandos fecha_chave ponto_virgula { { fprintf(fOut, "condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave condicao_else abre_chave sequencia_comandos fecha_chave ponto_virgula --> condicional\n"); } }     /* comando condicional if com a presenca da condicao else */
 | condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave ponto_virgula { fprintf(fOut, "condicao_if abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave ponto_virgula --> condicional\n"); }                                                                                                                                   /* comando condicional if sem a presenca da condicao else */
 ;

loop: loop_while abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave ponto_virgula { fprintf(fOut, "loop_while abre_parenteses condicao fecha_parenteses abre_chave sequencia_comandos fecha_chave ponto_virgula --> loop\n"); }   /* um comando loop e formado pelo termo "while" seguido de uma condicao entre parenteses e uma sequencia de comandos entre chaves, com token terminador ponto_virgula */
 ;

condicao: exp comparador exp            { fprintf(fOut, "exp comparador exp --> condicao while\n"); }   /* uma condicao, presente no comando condicional, deve ser um booleano "true" ou duas expressoes comparadas por um token comparador */
 | bool_true                            { fprintf(fOut, "bool_true --> condicao while\n"); }
 ;

comparador: igualdade                   { fprintf(fOut, "igualdade --> comparador\n"); }                /* um token comparador, presente na condicao do comando condicional, deve ser um termo igualdade (==) ou um termo diferenca (!=) */
 | diferenca                            { fprintf(fOut, "diferenca --> comparador\n"); }
 ;

exp: id                                 { fprintf(fOut, "id --> exp\n"); }                              /* uma expressao pode conter envolver variaveis (identificadores), numeros inteiros, numeros float e booleanos */
 | li                                   { fprintf(fOut, "valor int --> exp\n"); }                        
 | lf                                   { fprintf(fOut, "valor float --> exp\n"); }
 | bool_false                           { fprintf(fOut, "valor false --> exp\n"); }
 | bool_true                            { fprintf(fOut, "valor true --> exp\n"); }
 | exp soma exp                         { fprintf(fOut, "exp soma exp --> exp\n"); }                    /* uma expressao pode conter as operacoes soma, subtracao e utilizacao de parenteses */
 | exp subtracao exp                    { fprintf(fOut, "exp subtracao exp- --> exp\n"); }
 | abre_parenteses exp fecha_parenteses { fprintf(fOut, "abre_parenteses exp fecha_parenteses --> exp\n"); }
 ;

%%

// funcao main implementa a logica de arquivos 
int main(int argc, char *argv[])
{
  // finaliza o programa caso nao receba argumentos de forma correta
  if (argc < 3) { 
    printf("Erro: argumentos insuficientes --> ./analise <programa> <nome_do_arquivo_de_saida> \n");
    return 0;  
  }

  else {
    fOut = fopen(argv[2], "w");       // abre para escrever o arquivo passado como argumento, relativo ao ponteiro "fOut"
    yyin = fopen(argv[1], "r");       // abre para ler o arquivo passado como argumento a ser analisado
    
    if(fOut == NULL)
    {
        /* arquivo nao foi criado portanto EXIT */
        printf("Nao foi possivel criar arquivo.\n");
        exit(EXIT_FAILURE);
    }

    yyparse();
    fclose(fOut);
    return 0;
  }
}

