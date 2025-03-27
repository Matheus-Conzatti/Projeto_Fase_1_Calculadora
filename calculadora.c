#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

typedef struct no {
    float valor;
    struct no *prox;
} No;

No *empilhar(No *pilha, float num) {
    No *novo = malloc(sizeof(No));
    if (novo) {
        novo->valor = num;
        novo->prox = pilha;
        return novo;
    } else {
        printf("\tErro na alocacao de memoria!\n");
    }
    return NULL;
}

No *desempilhar(No **pilha) {
    No *remover = NULL;
    if (*pilha) {
        remover = *pilha;
        *pilha = remover->prox;
    } else {
        printf("\tPilha vazia!\n");
    }
    return remover;
}

float operacao(float a, float b, char x) {
    switch (x) {
        case '+': 
            return a + b;
            break;
        case '-': 
            return a - b;
            break;
        case '/':
            if(b == 0){
                printf("Erro: não é possivel fazer divisão por zero!\n");
            }
            return a / b;
            break;
        case '*': 
            return a * b;
            break;
        case '^': 
            return pow(a, b);
            break;
        case '&': 
            return sqrt(a);
            break;
        case '%': 
            return fmod(a, b);
            break;
        default: 
            return 0.0;
    }
}

float resolverExp(char x[]) {
    char *poteiro;
    float num;
    No *n1, *n2, *pilha = NULL;

    poteiro = strtok(x, " ");
    while (poteiro) {
        if (poteiro[0] == '+' || poteiro[0] == '-' || poteiro[0] == '/' || poteiro[0] == '*' || poteiro[0] == '|' || poteiro[0] == '&') {
            n1 = desempilhar(&pilha);
            n2 = desempilhar(&pilha);

            num = operacao(n2->valor, n1->valor, poteiro[0]);
            pilha = empilhar(pilha, num);

            free(n1);
            free(n2);
        } else {
            num = atof(poteiro);
            pilha = empilhar(pilha, num);
        }
        poteiro = strtok(NULL, " ");
    }

    n1 = desempilhar(&pilha);
    num = n1->valor;
    free(n1);
    return num;
}

void lerArquivos(char *nomeArquivos[], int numeroArquivos) {
    FILE *arquivo;
    char linha[100];
    char expressaoOriginal[100];

    for (int i = 0; i < numeroArquivos; i++) {
        arquivo = fopen(nomeArquivos[i], "r");

        if (arquivo == NULL) {
            printf("Erro ao abrir o arquivo %s.\n", nomeArquivos[i]);
            continue;
        }

        printf("Resultados do arquivo %s:\n", nomeArquivos[i]);
        while (fgets(linha, sizeof(linha), arquivo) != NULL) {
            linha[strcspn(linha, "\n")] = 0;
            strcpy(expressaoOriginal, linha);
            printf("Expressao: %s = %.0f\n", expressaoOriginal, resolverExp(linha));
        }

        printf("\n");
        fclose(arquivo);
    }
}

int main() {
    char *nomesArquivos[] = {"expressoes1.txt", "expressoes2.txt", "expressoes3.txt"};
    int numArquivos = sizeof(nomesArquivos) / sizeof(nomesArquivos[0]);

    lerArquivos(nomesArquivos, numArquivos);
    return 0;
}