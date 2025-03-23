#ifndef CALCULADORA_H
#define CALCULADORA_H

#include <iostream>
#include <string>
#include <cmath>

using namespace std;

using TipoDado = float;  

struct No {
    TipoDado info;    
    No *pai;         
    No *esq;          
    No *dir;          
};

class Calculadora {
    private:
        No *raiz; 

        TipoDado info(No *p);
        No *esq(No *p);
        No *dir(No *p);
        No *pai(No *p);
        No *irmao(No *p);
        bool eh_esq(No *p);
        bool eh_dir(No *p);
        void cria_no_esq(No *pai, TipoDado x);
        void cria_no_dir(No *pai, TipoDado x);
        void adiciona(No *r, TipoDado x);
        void percorre(No *r);
        No* buscador(No *raiz, int num);
        float operacao(float a, float b, char op);

    public:
        Calculadora();
        ~Calculadora();
        void limpa(No *r);
        void adiciona(TipoDado x);
        void percorre();
        float resolveExp(char x[]);
        void leituraArquivo();
};

#endif