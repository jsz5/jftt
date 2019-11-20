
#!/bin/bash
lex $1
g++ lex.yy.c
./a.out
