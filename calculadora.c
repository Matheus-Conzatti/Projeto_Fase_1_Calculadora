// Nome: Matheus Conzatti de Souza

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Representação de uma estrutura de dados dinâmica usando uma lista encadeada
typedef struct no{
    float valor; // Recebe um valor numérico
    struct no *prox; // Ponteiro para o próximo nó na pilha
}No;


// Variáveis para os comandos especiais N RES, V MEM e MEM
float memoria = 0.0;
float resultado[100]; // Armazena todos os resultados
int contResultados = 0; // Contador da quantidade de resultados

// Função que faz o empilhamento dos valores ao topo da pilha
No *empilhar(No *pilha, float num) {
    No *novo = malloc(sizeof(No)); // Aloca memória para um novo nó
    if(novo){
        novo->valor = num; // Atribui valor
        novo->prox = pilha; // O novo nó aponta para o topo atual da pilha
        return novo; // Retorna o novo topo
    }else{
        printf("\tErro na alocação de memória!\n");
    }

    return NULL;
}

// Função para desempilhar o valor do topo da pilha
No *desempilhar(No **pilha) {
    No *remover = NULL;
    if(*pilha){
        remover = *pilha; // O nó a ser removido do topo da pilha
        *pilha = remover->prox; // O novo topo passa a ser o próximo elemento
    }else{
        printf("\tPilha vazia!\n");
    }

    return remover; // Retorna o nó removido
}

// Função de operações matemáticas
float operacao(float a, float b, char x){
    switch (x) {
        case '+': // Soma
            return a + b; 
            break;
        case '-':  // Subtração
            return a - b;
            break;
        case '/': // Divisão de numeros reais
            return (b != 0) ? a / b : NAN; // Não deixa a divisão por zero
            break;
        case '*': // Multiplicação
            return a * b;
            break;
        case '^': 
            return powf(a, b);  // Exponenciação
            break;
        case '&': 
            return sqrtf(a);  // Raiz quadrada
            break;
        case '%': 
            return fmodf(a, b); // Resto da divisão
            break;
        default: 
            return 0.0;
    }
}

// Função que resolve os cálculos da calculadora RPN
float resolverExp(char x[]){
    char *ponteiro;
    float num;
    No *n1, *n2, *pilha = NULL;

    ponteiro = strtok(x, " "); // Divide as strings usando um espaçamento.
    while (ponteiro) {
        if(ponteiro[0] == '('){
            if(strstr(ponteiro, "RES")){
                // Processa o comando (N RES)
                int n = atoi(ponteiro + 5); // Captura o número após "N RES"
                if(n >= 0 && n < contResultados) {
                    num = resultado[n];
                    pilha = empilhar(pilha, num);
                }else{
                    printf("\tResultado N não foi encontrado.\n");
                }
            }else if(strstr(ponteiro, "MEM")){
                // Processa o comando (MEM)
                pilha = empilhar(pilha, memoria); // Utiliza o valor da memória
            }else if(strstr(ponteiro, "V MEM")){ // O strstr é para subtrings dentor da string
                // Processa o comando (V MEM)
                float v = atof(ponteiro + 6); // Captura o número após "V MEM"
                memoria = v;
            }
        }else if(strchr("+-/*^&%", ponteiro[0])){
            if (pilha && pilha->prox) {  // Verifica se há pelo menos dois elementos na pilha
                n1 = desempilhar(&pilha); // Desempilha o topo da pilha
                n2 = desempilhar(&pilha); // Desempilha o próximo valor da pilha

                num = operacao(n2->valor, n1->valor, ponteiro[0]); // Realiza a operação
                pilha = empilhar(pilha, num);
                resultado[contResultados++] = num; // Armazena o resultado
                free(n1); // Para evitar o consumo desnecessário de memória
                free(n2); // Para evitar o consumo desnecessário de memória
            }else{
                printf("\tErro: Pilha nao contem elementos suficientes para a operacao!\n");
            }
        }else{
            num = atof(ponteiro); // Converte a string em número
            pilha = empilhar(pilha, num);
            resultado[contResultados++] = num; // Armazena o resultado
        }
        ponteiro = strtok(NULL, " "); // Divide as strings usando um espaçamento.
    }

    if(pilha){
        n1 = desempilhar(&pilha); // Pega o último valor da pilha
        num = n1->valor;
        free(n1);// Para evitar o consumo desnecessário de memória
    }else{
        num = 0.0;
        printf("\tErro: Pilha final vazia!\n");
    }
    return num;
}

// Função que faz a leitura dos arquivos txt, resolvendo as expressões numéricas
void lerArquivos(char *nomeArquivos[], int numeroArquivos){
    FILE *arquivo;
    char linha[100];
    char expressaoOriginal[100];
    int i;

    for(i = 0; i < numeroArquivos; i++){
        arquivo = fopen(nomeArquivos[i], "r"); // Abre o arquivo texto

        if(arquivo == NULL){
            printf("Erro ao abrir o arquivo %s.\n", nomeArquivos[i]);
            continue;
        }

        printf("Resultados do arquivo %s:\n", nomeArquivos[i]);
        while(fgets(linha, sizeof(linha), arquivo) != NULL){
            linha[strcspn(linha, "\n")] = 0; // Remove a quebra de linha
            strcpy(expressaoOriginal, linha);
            printf("Expressao: %s = %.0f\n", expressaoOriginal, resolverExp(linha));
        }

        printf("\n");
        fclose(arquivo); // Fecha o arquivo de texto
    }
}

// Função que faz a leitura e gera o arquivo Assembly
void geraAssembly(char *exp, FILE *arqAssembly){
    char *token = strtok(exp, " ");
    float num1, num2;

    while(token){
        if(strchr("+-*/^%", token[0])){
            num2 = atof(strtok(NULL, " "));
            // A fução atof serve para converte strings númericas em número descimal
            num1 = atof(strtok(NULL, " ")); // O strtok é para a extração de tokens
            // O ldi é para fazer o carregamento imediato
            fprintf(arqAssembly,"  ldi r16, %d\n", (int)num1);  // Os r16 e r17 são registradores em pequenas areas de armazenamento da cpu 
            fprintf(arqAssembly, "  ldi r17, %d\n", (int)num2); // Os r16 e r17 são registradores em pequenas areas de armazenamento da cpu

            if(strcmp(token, "+") == 0){
                fprintf(arqAssembly, "  add r16, r17\n");
            }else if(strcmp(token, "-") == 0){
                fprintf(arqAssembly, "  sub r16, r17\n");
            }else if (strcmp(token, "*") == 0){ 
                fprintf(arqAssembly, "  mul r16, r17\n");
            }else if (strcmp(token, "/") == 0){
                // A função call é uma instrução de subrotina
                fprintf(arqAssembly, "  call div_avr\n"); // Operação que chama a divisão
            }else if (strcmp(token, "^") == 0){ 
                fprintf(arqAssembly, "  call pow_avr\n"); // Operação que chama a potênciação
            }else if(strcmp(token, "%")  == 0){
                fprintf(arqAssembly, "  call mod_avr\n"); // Operação que chama resto da divisão
            }
        }
        token = strtok(NULL, " ");
    }
}

void lerArqGeradoAssembly(char *nomeArquivos[], int numeroArquivos){
    FILE *arquivo, *arquivosAssembly;
    char linha[100];

    arquivosAssembly = fopen("calculadora.asm", "w");

    if(!arquivosAssembly){
        printf("Erro ao criar arquivo Assembly.\n");
        return;
    }

    for(int i = 0; i < numeroArquivos; i++){
        arquivo = fopen(nomeArquivos[i], "r");
        if (!arquivo) {
            printf("Erro ao abrir o arquivo %s.\n", nomeArquivos[i]);
            continue;
        }
        printf("Gerando Assembly para %s...\n", nomeArquivos[i]);
        while (fgets(linha, sizeof(linha), arquivo)) {
            linha[strcspn(linha, "\n")] = 0;
            geraAssembly(linha, arquivosAssembly);
        }
        fclose(arquivo); // Fecha o arquivo de texto
    }
    fclose(arquivosAssembly);// Fecha na parte do arquivo do Assembly
}

int main() {
    char *nomesArquivos[] = {"expressoes1.txt", "expressoes2.txt", "expressoes3.txt"};
    int numArquivos = sizeof(nomesArquivos) / sizeof(nomesArquivos[0]); // Verifica o tamanho da lista de arquivos

    lerArquivos(nomesArquivos, numArquivos); // Chama a função de leitura de arquivo texto
    lerArqGeradoAssembly(nomesArquivos, numArquivos); // Chama a função de leitura de arquivo Assembly
    return 0;
}
