%{
%}

%x comment
%x in_tag
%x cdata
begin "<!--"
close -->
%%
{begin} BEGIN(comment);
<comment>{
{close} {BEGIN(INITIAL);} 
.|\n ;   
}

{begin}.*--.*{close}  ECHO;

\" BEGIN(in_tag);
<in_tag>{
    \" {ECHO; BEGIN(INITIAL);}
    .  ECHO;
}

"<![CDATA[" {ECHO; BEGIN(cdata);}
<cdata>{
    ]]> { ECHO; BEGIN(INITIAL); }
    .  ECHO;
}
%%

int yywrap() {}

int main() {
    FILE *fp; 
    fp = fopen("zad2.xml","r"); 
    yyin = fp; 
    yylex();
}