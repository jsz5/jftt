%{
    #include <stdio.h>
    #include <stdbool.h>
    bool doc=true;
%}

%x in_string
%x in_include
%x singleline
%x multiline
newline [\\\n]*
include_pattern \#include[ \t]*\<
%%
\" {ECHO; BEGIN(in_string);}
<in_string>{
    \\\" ECHO;
    \" {ECHO; BEGIN(INITIAL);}
    .  ECHO;
}

{include_pattern}  {ECHO; BEGIN(in_include);}
<in_include>{
    \> {ECHO; BEGIN(INITIAL);}
    .  ECHO;
}

\/{newline}\/ {BEGIN(singleline);}
<singleline>{
    \\{newline} ; 
    . ;
    \n {BEGIN(INITIAL);}
}
\/{newline}\* BEGIN(multiline);
<multiline>{
    . ;
    \*{newline}\/ {BEGIN(INITIAL);}
}
\/{newline}\/{newline}\/|\/{newline}\/{newline}\! {if(doc) ECHO; else BEGIN(singleline);}
\/{newline}\*{newline}\*|\/{newline}\*{newline}\! {if(doc) ECHO; else BEGIN(multiline);}

%%

int yywrap() {}

int main() {
    FILE *fp; 
    fp = fopen("zad3.cpp","r"); 
    yyin = fp; 
    yylex();
}