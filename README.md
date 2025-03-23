# Atividade Avaliativa - RA01

Este trabalho pode ser realizado em grupos de até 4 alunos. Grupos com mais de 4 alunos irão
provocar a anulação do trabalho. Você deve ler todo documento antes de começar e considerar o
seguinte código de ética: você poderá discutir todas as questões com seus colegas de classe,
professores e amigos. Poderá também consultar os livros de referência da disciplina, livros na
biblioteca virtual ou não, e a internet de forma geral e abrangente nos idiomas que desejar. Contudo, o trabalho é seu e deverá ser realizado por você. Cópias ensejarão a anulação do trabalho.

# Objetivo

Pesquisar e praticar. Pesquisar os conteúdos que irão complementar o material apresentado em sala ou nos livros sugeridos na ementa e praticar estes mesmos conceitos. Esta é uma oportunidade para aprimorar sua formação e se destacar. Uma avaliação com oportunidade de crescimento acadêmico e profissional. 

# Descrição do trabalho

Seu objetivo será desenvolver um programa, usando Python, C, ou C++, capaz de abrir um arquivo
de texto, contendo expressões aritméticas simples, com uma expressão aritmética por linha e
executar as expressões em um ambiente de testes, seu notebook, e em um Arduíno Uno.
O seu programa deverá executar cada uma das expressões indicadas no Arduíno e apresentar o
resultado das operações contidas em todas as linhas do arquivo de entrada.
O programa que você irá desenvolver deverá ler o código, expressões aritméticas, em um arquivo txt e gerar o Assembly necessário para que este código seja executado no Arduino. A gravação no Arduino pode ser feita por um ambiente externo.

# Caracteristicas Especiais

As expressões serão escritas em notação RPN, segundo o formato a seguir:
a) Adição:+, no formato (A B +);
b) Subtração: - no formato (A B -) ;
c) Multiplicação: * no formato (A B *);
d) Divisão Real: | no formato (A B |);
e) Divisão de inteiros: / no formato (A B /);
f) Resto da Divisão de Inteiros: % no formato (A B %);
g) Potenciação: ^ no formato (A B ^);

Neste caso, A e B representam números reais. Use o ponto para indicar a vírgula decimal.
Todas as operações serão executadas sobre números reais de meia precisão (16 bits/ IEEE754). As
únicas exceções são a divisão de inteiros e a operação resto da divisão de inteiros. Além disso, O
expoente da operação de potenciação será sempre um inteiro positivo. As expressões indicadas
podem ser aninhadas para a criação de expressões compostas, sem nenhum limite definido de
aninhamento. Isto implica na possibilidade de que o texto lido contenha linhas com expressões
como:
a) (A (C D *) +)
b) ((A B %) (D E *) /)
Onde A, B, C, D e E representam números reais. Além das expressões já definidas existem três
comandos especiais (N RES), (V MEM) e (MEM), de tal forma que:
a) (N RES): devolve o resultado da expressão que está N linhas antes, onde N é um
número inteiro não negativo;
b) (V MEM): armazena um valor, V, em um espaço de memória chamado de MEM, capaz
de armazenar um valor real;
c) (MEM): devolve o valor armazenado na memória. Se a memória não tiver sido usada
anteriormente devolve o número real zero. Cada arquivo de textos é um escopo de
aplicação.
Para teste, você deverá fornecer, no mínimo 3 arquivos de texto contendo, cada um, no mínimo
10 linhas com expressões aritméticas. Estes arquivos deverão estar disponíveis no ambiente de
testes, no mesmo diretório do código fonte do seu programa. E cada um deles deve conter todas as
expressões e comandos possíveis na linguagem. Seu programa não pode ter um menu, ou qualquer
forma de seleção entre os seus arquivos de teste. O programa deverá ser executado recebendo
como argumento, na linha de comando, o nome do arquivo de teste.
Atenção: as primeiras linhas do seu código devem conter os nomes dos integrantes do grupo, em
ordem alfabética, além do nome do grupo no ambiente virtual de aprendizagem (Canvas). A nota
será lançada para o grupo.

# Autor

Nome Autor: Matheus conzatti de Souza