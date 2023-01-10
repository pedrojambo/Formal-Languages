calcula: lex.yy.o
	cc -g -o calcula calc.tab.c lex.yy.o

lex.yy.o: lex.yy.c calc.tab.h
	cc -g -c lex.yy.c

lex.yy.c: calc.l calc.tab.h
	flex calc.l

calc.tab.h calc.tab.c: calc.y
	bison -d calc.y

