#include "calculadora.h"
#include <cstring> 
#include <cstdlib>
#include <fstream>
#include <vector>
#include <iostream>

using namespace std;

TipoDado Calculadora::info(No *p) {
    return p->info;
}

No* Calculadora::esq(No *p) {
    return p->esq;
}

No* Calculadora::dir(No *p) {
    return p->dir;
}

No* Calculadora::pai(No *p) {
    return p->pai;
}

No* Calculadora::irmao(No *p) {
    if (p == raiz)
        return nullptr;
    else {
        if (eh_esq(p))
            return dir(pai(p));
        else
            return esq(pai(p));
    }
}

bool Calculadora::eh_esq(No *p) {
    if (p == raiz)
        return false;
    else
        return (esq(pai(p)) == p);
}

bool Calculadora::eh_dir(No *p) {
    if (p == raiz)
        return false;
    else
        return (dir(pai(p)) == p);
}

void Calculadora::cria_no_esq(No *pai, TipoDado x) {
    if (esq(pai) == nullptr) {
        No *novono = new No;
        novono->info = x;
        novono->pai = pai;
        novono->esq = novono->dir = nullptr;
        pai->esq = novono;
    }
}

void Calculadora::cria_no_dir(No *pai, TipoDado x) {
    if (dir(pai) == nullptr) {
        No *novono = new No;
        novono->info = x;
        novono->pai = pai;
        novono->esq = novono->dir = nullptr;
        pai->dir = novono;
    }
}

void Calculadora::adiciona(No *r, TipoDado x) {
    if (x == info(r))
        cout << "Repetido!" << endl;
    else if (x < info(r)) {
        if (esq(r) == nullptr)
            cria_no_esq(r, x);
        else
            adiciona(esq(r), x);
    } else {
        if (dir(r) == nullptr)
            cria_no_dir(r, x);
        else
            adiciona(dir(r), x);
    }
}

void Calculadora::percorre(No *r) {
    if (r != nullptr) {
        percorre(esq(r));
        cout << info(r) << endl;  
        percorre(dir(r));
    }
}

Calculadora::Calculadora() {
    raiz = nullptr;
}

Calculadora::~Calculadora() {
    limpa(raiz);
}

void Calculadora::limpa(No *r) {
    if (r != nullptr) {
        percorre(esq(r));
        percorre(dir(r));
        delete r;
    }
}

void Calculadora::adiciona(TipoDado x) {
    if (raiz == nullptr) {
        raiz = new No;
        raiz->info = x;
        raiz->pai = nullptr;
        raiz->esq = raiz->dir = nullptr;
    } else {
        adiciona(raiz, x);
    }
}

void Calculadora::percorre() {
    percorre(raiz);
}

No* Calculadora::buscador(No *raiz, int num) {
    while (raiz) {
        if (num < raiz->info) {
            raiz = raiz->esq;
        } else if (num > raiz->info) {
            raiz = raiz->dir;
        } else {
            return raiz;
        }
    }
    return nullptr;
}

float Calculadora::operacao(float a, float b, char op) {
    switch(op) {
        case '+':
            return a + b;
            break;
        case '-':
            return a - b;
            break;
        case '*':
            return a * b;
            break;
        case '/':
            return a / b;
            break;
        case '^':
            return pow(a, b);
            break;
        case '|':
            return sqrt(a);
            break;
        default:
            return 0.0;
    }
}

float Calculadora::resolveExp(char x[]) {
    char *poteiro;
    float num;
    No *pilha = nullptr;

    poteiro = strtok(x, " ");
    while (poteiro) {
        if (poteiro[0] == '+' || poteiro[0] == '-' || poteiro[0] == '*' || 
            poteiro[0] == '/' || poteiro[0] == '^' || poteiro[0] == '|') {

            if (pilha && pilha->esq) {
                No *n1 = pilha;
                pilha = pilha->esq;
                No *n2 = pilha;
                pilha = pilha->esq;

                num = operacao(n2->info, n1->info, poteiro[0]);

                No *novoNo = new No;
                novoNo->info = num;
                novoNo->esq = pilha;
                pilha = novoNo;

                delete n1;
                delete n2;
            }
        } else {
            num = strtol(poteiro, nullptr, 10);
            No *novoNo = new No;
            novoNo->info = num;
            novoNo->esq = pilha;
            pilha = novoNo;
        }
        poteiro = strtok(nullptr, " ");
    }

    if (pilha) {
        num = pilha->info;
        delete pilha;
    }
    return num;
}

void Calculadora::leituraArquivo() {
    vector<string> nomesAquivos = {"expressoes1.txt", "expressoes2.txt", "expressoes3.txt"}; 


    for(const string& nomeAquivos : nomesAquivos){
        ifstream arquivo(nomeAquivos);

        if(!arquivo.is_open()){
            cerr << "Erro ao abrir o arquivo!" << endl;
            cerr << "Verifique se o arquivo 'expressoes1.txt' existe no mesmo diretorio do executavel." << endl;
            continue;
        }

        string linha;
        while(getline(arquivo, linha)){
            cout << "Expressao: " << linha << endl;

            char expr[linha.length() + 1];
            strcpy(expr, linha.c_str());

            float resultado = resolveExp(expr);
            cout << "Resultado: " << resultado << endl;
        }

        arquivo.close();
    }
}
