#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <string.h>

typedef uint16_t half; // Representa a meia precisão

half meiaPrecisao(float num){
    uint32_t f = *(uint32_t*)&num;
    uint16_t sign = (f >> 16) & 0x8000;
    uint16_t expoente = ((f >> 23) & 0xFF) - 112; // Ajusta da operação do expoente.
    uint16_t mantissa = (f >> 12) & 0x03FF;

    if(expoente <= 0){
        return sign;
    }else if(expoente >= 31){
        return sign | 0x7C00 | (mantissa ? 1 : 0); 
    }

    return sign | (expoente << 10) | mantissa;
}

// Respresentação  de uma estrutura de dados dinâmica usando uma lista encadeadas.
typedef struct no {
    half valor; // Recebe um valor numérico
    struct no *prox; // Ponteiro para o próximo e nó na pilha.
} No;

// Função que faz o empilhamento dos valores ao topo da pilha
No *empilhar(No *pilha, float num) {
    No *novo = malloc(sizeof(No)); // Aloca memória para um novo nó.
    if (novo) {
        novo->valor = meiaPrecisao(num); // Faz atribuição de valor
        novo->prox = pilha; // O novo nó aponta para o topo atual da pilha
        return novo; // Retorna um novo topo.
    } else {
        printf("\tErro na alocacao de memoria!\n");
    }
    return NULL;
}

// Função para desempilhar o valor do topo da pilha.
No *desempilhar(No **pilha) {
    No *remover = NULL;
    if (*pilha) {
        remover = *pilha; // O nó a ser removido do topo da pilha.
        *pilha = remover->prox; // O novo topo passa a ser o proximo elemento.
    } else {
        printf("\tPilha vazia!\n");
    }
    return remover; // Retorna o nó removido
}

float operacao(float a, float b, char x) {
    switch (x) {
        case '+': 
            return a + b;
            break;
        case '-': 
            return a - b;
            break;
        case '/': // Divisão de número real.
            return (b != 0) ? a / b : NAN;
            break;
        case '*': 
            return a * b;
            break;
        case '^':  // Operação da Exponenciação
            return powf(a, b);
            break;
        case '&': // Raiz quadrada, somente um dos operador é usado
            return sqrtf(a);
            break;
        case '%': // Resto da divisão
            return fmodf(a, b);
            break;
        default: 
            return 0.0;
    }
}

// Função que resolve os calculos da calculadora RPN.
float resolverExp(char x[]) {
    char *poteiro;
    float num;
    No *n1, *n2, *pilha = NULL;

    poteiro = strtok(x, " ");
    while (poteiro) {
        if (strchr("+-/*^&%", poteiro[0])) {
            n1 = desempilhar(&pilha); // Faz a função desempilhar para guardar o valor na variavel n1
            n2 = desempilhar(&pilha); // Faz a função desempilhar para guardar o valor na variavel n2

            float val_1 = meiaPrecisao(n1->valor);
            float val_2 = meiaPrecisao(n2->valor);

            num = operacao(n2->valor, n1->valor, poteiro[0]); // Realiza a função da operação
            pilha = empilhar(pilha, num); // Empilha os resultado da função da operação.

            free(n1);
            free(n2);
        } else {
            num = atof(poteiro); // Converte a string em número
            pilha = empilhar(pilha, num);
        }
        poteiro = strtok(NULL, " ");
    }

    n1 = desempilhar(&pilha); // último número da pilha e também o resultado final
    num = meiaPrecisao(n1->valor);
    free(n1);
    return num;
}

// Função que faz a leitura dos arquivos txt, resolvendo as expressões numericas.
void lerArquivos(char *nomeArquivos[], int numeroArquivos) {
    FILE *arquivo;
    char linha[100];
    char expressaoOriginal[100];

    for (int i = 0; i < numeroArquivos; i++) {
        arquivo = fopen(nomeArquivos[i], "r"); // Abre o arquivo texto.

        if (arquivo == NULL) {
            printf("Erro ao abrir o arquivo %s.\n", nomeArquivos[i]);
            continue;
        }

        printf("Resultados do arquivo %s:\n", nomeArquivos[i]);
        while (fgets(linha, sizeof(linha), arquivo) != NULL) {
            linha[strcspn(linha, "\n")] = 0; // Remove a quebra de linha
            strcpy(expressaoOriginal, linha);
            printf("Expressao: %s = %.0f\n", expressaoOriginal, resolverExp(linha));
        }

        printf("\n");
        fclose(arquivo); // Fecha o arquivo de texto.
    }
}

int main() {
    char *nomesArquivos[] = {"expressoes1.txt", "expressoes2.txt", "expressoes3.txt"};
    int numArquivos = sizeof(nomesArquivos) / sizeof(nomesArquivos[0]);

    lerArquivos(nomesArquivos, numArquivos);
    return 0;
}
