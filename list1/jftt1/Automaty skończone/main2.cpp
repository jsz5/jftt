#include <iostream>
#include <string>

using namespace std;

/**
 * Zwraca true jeżeli słowo jest prefixem drugiego słowa, false w.p.p
 * @param prefix
 * @param word
 * @param symbol
 * @return
 */
bool checkIfPrefix(wstring prefix, wstring word, wchar_t symbol) {
    wcout<<prefix<<" "<<word<<endl;
    for (int i = 0; i < prefix.length(); i++) {
        if (word[i] != prefix[i]) return false;
    }
    return word[prefix.length()] == symbol;
}

/**
 * Generuje funkcję przejść stanów
 * @param states
 * @param alphabet
 * @param pattern
 */
void statesArray(int **states, wstring alphabet, wstring pattern) {
    int k;
    int m = pattern.length();
    for (int q = 0; q <= m; q++) {
        for (int a = 0; a < alphabet.length(); a++) {
            k = min(m + 1, q + 1); //inkrementujemy stan q jeżeli alphabet[a] to następna litera wzorca
            while (k > 0 && !checkIfPrefix(pattern.substr(q - k + 1, k - 1), pattern.substr(0, q + 1), alphabet[a])) {
                k--;
            }
            states[q][a] = k;
        }
    }

}
/**
 * Zwraca index litery w alfabecie
 * @param letter
 * @param alphabet
 * @return
 */
int getLetterIndex(wchar_t letter, wstring alphabet) {
    for (int i = 0; i < alphabet.length(); i++) {
        if (alphabet[i] == letter) return i;
    }
    return 0;
}

/**
 * Zwraca informacje, na którym miejscu został znaleziony wzorzec
 * @param states
 * @param word
 * @param m
 * @param alphabet
 */
void findPattern(int **states, wstring word, int m, wstring alphabet) {
    int q = 0;
    for (int i = 0; i < word.length(); i++) {
        q = states[q][getLetterIndex(word[i], alphabet)];
        if (q == m) {
            cout << "Wzorzec występuje z przesunięciem " << i - m + 1 << endl;
        }
    }
}

int main() {
    wstring alphabet = L"abc";
    wstring word = L"αβαβγβαβαβαβαβγ";
    wstring pattern = L"ababaca";



    int m = pattern.length();
    int n = alphabet.length();
    int **states = new int *[m + 2];
    for (int i = 0; i <= m + 1; i++) {
        states[i] = new int[n];
    }
    statesArray(states, alphabet, pattern);
    findPattern(states, word, m, alphabet);
    return 0;
}