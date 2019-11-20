%{
    #include <iostream>
    #include <cmath>
    #include <stack> 
    using namespace std;

    stack <int> s; 
    bool error=false;
    void errorDivide(){
        if(!error){
            error=true;
            cout<<"Błąd: dzielenie przez 0\n";
        }
    }
    void substract(int x, int y){
        s.push(x-y);
    }
    void add(int x, int y) {
        s.push(x+y);
    }
    void multiply(int x, int y) {
        s.push(x*y);
    }
    void divide(int x, int y) {
        if(y==0){
            errorDivide();
        }else{
            s.push(x/y);
        }
    }
    void mod(int x, int y) {
        if(y==0){
            errorDivide();
        }else{
            s.push(x%y);
        }
    }
    void power(int x, int y) {
        s.push(pow(x,y)); 
    }
    void printResult()
    {
        if(!error){
            if(s.size()<1){
                cout<<"Błąd: za mała liczba argumentów\n";
            }else if(s.size()>1){
                cout<<"Błąd: za mała liczba operatorów\n";
            }else{
                cout<<"="<<s.top()<<endl;
            }
        }
        error=false;
        s=stack<int>();
    }
    void result(void (*action)(int, int))
    {
        if(s.size()>1){
            int y=s.top();
            s.pop();
            int x=s.top();
            s.pop();
            action(x,y);        
        }else if(!error){
            cout<<"Błąd: za mała liczba argumentów\n";
            error=true;
        }
    }
%}

%x in_string
%x singleline
%x multiline

%%
-?[0-9]+ {s.push(atoi(yytext));}
"-" result(&substract);
"+" result(&add);
"*" result(&multiply);
"/" result(&divide);
"%" result(&mod);
"^" result(&power);
\n {printResult(); BEGIN(INITIAL);}
[ \t] ;
. {cout<<"Błąd: zły symbol "<<yytext<<endl;error=true; BEGIN(INITIAL);}
%%

int yywrap() {}

int main() {
    yylex();
}