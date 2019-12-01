#include <iostream>
#include <string>

using namespace std;

/**
 * Find longest proper Prefix which is also Suffix table
 * @param pattern
 * @param lps
 */
void findPrefixSuffixTable(wstring pattern, int patternSize, int lps[])
{
    lps[0]=-1;
    int j=-1;
    for(int i=1; i<patternSize; i++){
        while(j>-1 && pattern[j+1]!=pattern[i]){
            j=lps[j];
        }
        if(pattern[j+1]==pattern[i]){
            j++;

        }
        lps[i]=j;
    }
}
/**
 * check if pattern exists in text
 * @param text
 * @param pattern
 * @return
 */
bool kmp(wstring text, wstring pattern)
{
    int patternSize=pattern.length();
    int lps[pattern.length()];
    findPrefixSuffixTable(pattern,patternSize,lps);
    int q=0;
    bool exists=false;
    for(int i=0; i<text.length(); i++){
        while(q>0 &&pattern[q]!=text[i]){
            q=lps[q-1]+1;
        }
        if(pattern[q]==text[i]){
            q++;
        }
        if(q==patternSize){
            exists=true;
            cout<<"Wzorzec występuje na indexie "<<i-patternSize+1<<endl;
            q=lps[q-1]+1;
        }
    }
    return exists;
}

int main() {
    wstring pattern=L"ąćąć";
    if(!kmp(L"ąćąćąćąśśśćąćąćąćąćśśśćąćś",pattern)){
        cout<<"Wzorzec nie występuje w tekście\n";
    }

    return 0;
}