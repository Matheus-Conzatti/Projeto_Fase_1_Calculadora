// Nome: Matheus Conzatti de Souza
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdint.h>
// #include <avr/io.h>

typedef uint16_t float16;

// Protótipos das funções para evitar erros de compilação
float16 floatHalf(float f);
float halfToFloat(float16 h);

typedef struct no {
    float valor;
    struct no *prox;
} No;

float16 resultadoHalf[100];
int contResultados = 0;  // Mantendo apenas uma declaração
float memoria = 0.0;

// Função de conversão de float para half-float
float16 floatHalf(float f) {
    uint32_t bin;
    memcpy(&bin, &f, sizeof(bin));

    uint16_t sinal = (bin >> 16) & 0x8000;
    int16_t exp = ((bin >> 23) & 0xFF) - 127 + 15;
    uint16_t mantissa = (bin >> 13) & 0x03FF;

    if (exp <= 0) return sinal;
    else if (exp >= 31) return sinal | 0x7C00;

    return sinal | (exp << 10) | mantissa;
}

// Função de conversão de half-float para float
float halfToFloat(float16 h) {
    uint32_t sinal = (h & 0x8000) << 16;
    uint32_t exp = (h & 0x7C00) >> 10;  // Corrigido erro de sintaxe
    uint32_t mantissa = (h & 0x03FF);  // Corrigido erro de nome

    if(exp == 0){
        if (mantissa == 0) return 0.0f;
        exp = 1;
    }else if (exp == 31) return (sinal ? -INFINITY : INFINITY);
    exp = exp - 15 + 127;
    uint32_t bin = sinal | (exp << 23) | (mantissa << 13);

    float res;
    memcpy(&res, &bin, sizeof(res));
    return res;
}

// Função que faz o empilhamento dos valores ao topo da pilha
No *empilhar(No *pilha, float num) {
    No *novo = malloc(sizeof(No)); // Aloca memória para um novo nó
    if(novo){
        novo->valor = num; // Atribui valor
        novo->prox = pilha; // O novo nó aponta para o topo atual da pilha
        return novo; // Retorna o novo topo
    }else
        printf("\tErro na alocação de memória!\n");
    return NULL;
}

// Função para desempilhar o valor do topo da pilha
No *desempilhar(No **pilha) {
    No *remover = NULL;
    if(*pilha){
        remover = *pilha; // O nó a ser removido do topo da pilha
        *pilha = remover->prox; // O novo topo passa a ser o próximo elemento
    }else printf("\tPilha vazia!\n");
    return remover; // Retorna o nó removido
}

// Função de operações matemáticas
float operacao(float a, float b, char x){
    switch (x) {
        case '+': return a + b; break;// Soma
        case '-': return a - b; break; // Subtração
        case '/': return (b != 0) ? a / b : NAN; break; // Divisão de numeros reais. Não deixa a divisão por zero
        case '*': return a * b; break; // Multiplicação
        case '^': return powf(a, b); break; // Exponenciação  
        case '&': return sqrtf(a); break; // Raiz quadrada
        case '%': return fmodf(a, b); break; // Resto da divisão
        default: return 0.0;
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
                    num = halfToFloat(resultadoHalf[n]);
                    pilha = empilhar(pilha, num);
                }else printf("\tResultado N não foi encontrado.\n");
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

                float16 h = floatHalf(num);
                resultadoHalf[contResultados++] = h; // Armazena o resultado
                printf("\tResultado (16-bit): 0x%04X => %.4f\n", h, halfToFloat(h));

                free(n1); // Para evitar o consumo desnecessário de memória
                free(n2); // Para evitar o consumo desnecessário de memória
            }else printf("\tErro: Pilha nao contem elementos suficientes para a operacao!\n");
        }else{
            num = atof(ponteiro); // Converte a string em número
            pilha = empilhar(pilha, num);
            float16 h = floatHalf(num);
            resultadoHalf[contResultados++] = h; // Armazena o resultado
            printf("\tEmpilhado (16-bit): 0x%04X => %.4f\n", h, halfToFloat(h));
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
        printf("\n"); // Quebra de linha
        fclose(arquivo); // Fecha o arquivo de texto
    }
}

// Função que faz a leitura e gera o arquivo Assembly
void geraAssembly(char *exp, FILE *arqAssembly){
    char *token = strtok(exp, " ");
    float num1, num2;

    while(token){
        if(strchr("+-*/^%", token[0])){
            num2 = atof(strtok(NULL, " ")); // A fução atof serve para converte strings númericas em número descimal
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

    // Parte do cabeçalho do arquivo Assembly
    fprintf(arquivosAssembly, 
        "; Definição dos registradores\n"
        ".equ UBRR0L = 0xC4\n"
        ".equ UCSR0B = 0xC1\n"
        ".equ UCSR0C = 0xC2\n"
        ".equ UCSR0A = 0xC0\n"
        ".equ UDR0   = 0xC6\n"
        ".equ TXEN0  = 3\n"
        ".equ UCSZ01 = 2\n"
        ".equ UCSZ00 = 1\n"
        ".equ UDRE0  = 5\n\n"

        ".text\n"
        ".global start\n"
        "start:\n"
    );

    for(int i = 0; i < numeroArquivos; i++){
        arquivo = fopen(nomeArquivos[i], "r");
        if (!arquivo) {
            printf("Erro ao abrir o arquivo %s.\n", nomeArquivos[i]);
            continue;
        }
        
        while(fgets(linha, sizeof(linha), arquivo)){
            linha[strcspn(linha, "\n")] = 0;
            // Faz o processamento da calculadora RPN
            char *token = strtok(linha, " ");
            No *pilha = NULL;

            while(token){
                if(strchr("+-/*^%", token[0])){
                    No *n1 = desempilhar(&pilha);
                    No *n2 = desempilhar(&pilha);
                    int16_t op1 = floatHalf(n2->valor);
                    int16_t op2 = floatHalf(n1->valor);

                    fprintf(arquivosAssembly, "    ; Operando 1\n");
                    fprintf(arquivosAssembly, "    ldi r30, lo8(%d)\n", op1);
                    fprintf(arquivosAssembly, "    ldi r31, hi8(%d)\n", op1);

                    fprintf(arquivosAssembly, "    ; Operando 2\n");
                    fprintf(arquivosAssembly, "    ldi r24, lo8(%d)\n", op2);
                    fprintf(arquivosAssembly, "    ldi r25, hi8(%d)\n", op2);
                    switch(token[0]){
                        case '+': fprintf(arquivosAssembly, "    add r30, r24\n"); break;
                        case '-': fprintf(arquivosAssembly, "    sub r30, r24\n"); break;
                        case '*': fprintf(arquivosAssembly, "    mul r30, r124\n"); break;
                        case '/': fprintf(arquivosAssembly, "    call div_avr\n"); break;
                        case '^': fprintf(arquivosAssembly, "    call pow_avr\n"); break;
                        case '%': fprintf(arquivosAssembly, "    call mod_avr\n"); break;
                    }
                    float res = operacao(n2->valor, n1->valor, token[0]);
                    pilha = empilhar(pilha, res);
                    free(n1);
                    free(n2);
                }else{
                    float num = atof(token);
                    pilha = empilhar(pilha, num);
                }
                token = strtok(NULL, " ");
            }
            while(pilha){
                No *tmp = desempilhar(&pilha);
                free(tmp);
            }
        }
        fclose(arquivo); // Fecha na parte do arquivo do Assembly
    }
    // Serve para evitar algum erro inesperado.
    fprintf(arquivosAssembly, "    rjmp _start\n\n");
    // Complementa com as funções auxiliares no arquivo Assembly
    fprintf(arquivosAssembly,
        "; Inicializa comunicação serial\n"
        "uart_init:\n"
        "    ldi r16, 103              ; Baud rate 9600 (para 16MHz)\n"
        "    out UBRR0L, r16\n"
        "    ldi r16, (1<<TXEN0)\n"
        "    out UCSR0B, r16\n"
        "    ldi r16, (1<<UCSZ01)|(1<<UCSZ00)\n"
        "    out UCSR0C, r16\n"
        "    ret\n\n"

        "; Envia caractere via serial\n"
        "uart_transmit:\n"
        "    sbis UCSR0A, UDRE0\n"
        "    rjmp uart_transmit\n"
        "    out UDR0, r16\n"
        "    ret\n\n"

        "; Converte inteiro de 8 bits para 2 dígitos hex e envia\n"
        "print_int:\n"
        "    push r18\n"
        "    push r19\n"
        "    mov r18, r16\n"
        "    swap r18\n"
        "    andi r18, 0x0F\n"
        "    cpi r18, 10\n"
        "    brlt pi_digit1\n"
        "    subi r18, -55\n"
        "    rjmp pi_send1\n"
        "pi_digit1:\n"
        "    subi r18, -48\n"
        "pi_send1:\n"
        "    mov r16, r18\n"
        "    rcall uart_transmit\n"

        "    pop r19\n"
        "    push r19\n"
        "    mov r19, r16\n"
        "    andi r19, 0x0F\n"
        "    cpi r19, 10\n"
        "    brlt pi_digit2\n"
        "    subi r19, -55\n"
        "    rjmp pi_send2\n"
        "pi_digit2:\n"
        "    subi r19, -48\n"
        "pi_send2:\n"
        "    mov r16, r19\n"
        "    rcall uart_transmit\n"

        "    pop r18\n"
        "    ret\n"
    );
    fclose(arquivosAssembly);
}

int main() {
    char *nomesArquivos[] = {"expressoes1.txt", "expressoes2.txt", "expressoes3.txt"};
    int numArquivos = sizeof(nomesArquivos) / sizeof(nomesArquivos[0]); // Verifica o tamanho da lista de arquivos

    lerArquivos(nomesArquivos, numArquivos); // Chama a função de leitura de arquivo texto
    lerArqGeradoAssembly(nomesArquivos, numArquivos); // Chama a função de leitura de arquivo Assembly
    return 0;
}