all: calculator.tab lexer.l.c
	g++ -o calculator calculator.tab.cpp lexer.l.c -lm

lexer.l.c: lexer.l
	flex -o lexer.l.c lexer.l

calculator.tab: calculator.ypp
	bison -d calculator.ypp

clean:
	rm calculator.tab.* lexer.l.*

cleanall:
	rm calculator