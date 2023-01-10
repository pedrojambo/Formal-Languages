analise: lex.yy.o
	gcc -g -o analise bison.tab.c lex.yy.o

lex.yy.o: lex.yy.c bison.tab.h
	gcc -g -c lex.yy.c

lex.yy.c: flex.l bison.tab.h
	flex flex.l

bison.tab.h bison.tab.c: bison.y
	bison -d bison.y

