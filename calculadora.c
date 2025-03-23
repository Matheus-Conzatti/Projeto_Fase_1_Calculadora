#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct no{
    float valor;
    struct no *prox;
}No;

No *empilhar(No *pilha, float num){
    No *novo = malloc(sizeof(No));

    if(novo){
        novo -> valor = num;
        novo -> prox = pilha;
        return novo;
    }else{
        printf("\tErro na alocacao de memoria!\n");
    }

    return NULL;
}

No *desempilhar(No **pilha){
    No *remover = *pilha;
    if(*pilha){
        *pilha = remover -> prox;
    }else{
        printf("\tPilha vazia!\n");
    }

    return remover;
}

float operacao(float a, float b, char x){
    switch(x){
        case '+':
            return a + b;
            break;
        case '-':
            return a - b;
            break;
        case '/':
            return a / b;
            break;
        case '*':
            return a * b;
            break;
        case '|':
            return pow(a, b);
            break;
        case '&':
            return sqrt(a);
        default:
            return 0.0;
    }
}

float resolveExp(char x[]){
    char *ponteiro;
    float num;
    No *n1, *n2, *pilha = NULL;
    int x = 0;
    int strtok();

    ponteiro = strtok(x, " ");
    while (ponteiro){
        if (ponteiro[0] == '+' || ponteiro[0] == '-' || ponteiro[0] == '/' || ponteiro[0] == '*' || ponteiro[0] == '|' || ponteiro[0] == '&'){
            n1 = desempilhar(&pilha);
            n2 = desempilhar(&pilha);

            num = operacao(n2 -> valor, n1 -> valor, ponteiro[0]);
            pilha = empilhar(pilha, num);

            free(n1);
            free(n2);
        }else{
            num = strtol(ponteiro, NULL, 10);
            pilha = empilhar(pilha, num);
        }

        ponteiro = strtok(NULL, " ");
    }

    n1 = desempilhar(&pilha);
    num = n1 -> valor;
    free(n1);
    return num;
}

int main(){
    char expA[50] = {"3 2 +"};
  char expB[50] = {"2 3 4 *"};
  char expC[50] = {"4 2 2 /"};
  char expD[50] = {"4 2 |"};
  char expE[50] = {"4 &"}; // Expressão com problema 
  char expF[50] = {"4 2 + 3 *"};

  printf("Resultado da letra A(%s): ", expA);
  printf("%.0f\n", resolverExp(expA));
  
  printf("\n");
  printf("Resultado da letra B(%s): ", expB);
  printf("%.0f\n", resolverExp(expB));
  
  printf("\n");
  printf("Resultado da letra C(%s): ", expC);
  printf("%.0f\n", resolverExp(expC));
  
  printf("\n");
  printf("Resultado da letra D(%s): ", expD);
  printf("%.0f\n", resolverExp(expD));
  printf("\n");
  
  //printf("Resultado da letra E(%s): ", expE);
  //printf("%.0f\n", resolverExp(expE));
  
  printf("\n");
  printf("Resultado da letra F(%s): ", expF);
  printf("%.0f\n", resolverExp(expF)); 
}