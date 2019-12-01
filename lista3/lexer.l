%option noyywrap
%{

#include "calculator.tab.hpp"

int yylex();
%}
%x comment
%%
^#            BEGIN(comment);
<comment>{
    \\\n            ;
    .               ;
    \n              BEGIN(INITIAL);
}

[0-9]+        {yylval.number = atoi(yytext); return (NUM);}
"+"             { return ADD;}
"-"             { return SUBSTRACT;}
"*"             { return MULTIPLY;}
"/"             { return DIVIDE;}
"%"             { return MOD;}
"^"             { return POWER;}
\(              { return LEFT_BRACKET;}
\)              { return RIGHT_BRACKET;}
[ \t]+          ;
\\\n            ;
\n              { return END;}
EOF             { return 0;}
.               { return ERROR;}
%%