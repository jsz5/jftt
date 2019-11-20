%{

int lines = 0;
int words = 0;
%}

%%
^[ \t]*\n?  ;//usuń wszystkie z początku i pusta linia
[ \t]+$     ;//usuń wszystkie z końca
[ \t]+ {printf(" ");} //ciąg tabulatorów lub spacji na jedną spację
[a-zA-Z0-9]+ {printf("%s", yytext); words++;} //słowo
\n  {printf("\n"); lines++;} //nowa linia
%%

int yywrap() {}

int main() {
    FILE *fp; 
    fp = fopen("zad1.txt","r"); 
    yyin = fp; 
    yylex();
    printf("\nlines %d, words %d\n",lines,words);
}