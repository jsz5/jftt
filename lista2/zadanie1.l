%{
#include <stdio.h>
int lines = 0;
int words = 0;
%}

%%
^[ \t]*\n? ;//usuń wszystkie z początku i pusta linia
[ \t]+$     ;//usuń wszystkie z końca
[ \t]+ {printf(" "); words++;}//ciąg tabulatorów lub spacji na jedną spację
\n  {printf("\n"); lines++; words++;}
%%

int yywrap() {}

int main() {
    FILE *fp; 
    fp = fopen("zad1.txt","a"); 
    fprintf(fp, "\n");
    fclose(fp);
    fp = fopen("zad1.txt","r"); 
    yyin = fp; 
    yylex();
    printf("\nlines %d, words %d\n",lines,words);
}