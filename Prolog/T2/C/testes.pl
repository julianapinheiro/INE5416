/*
    Testes para o trabalho t2C da disciplina de Paradigmas de Programação
    Alunos: Juliana Silva Pinheiro

    OBSERVAÇÃO:
    - Criar uma pasta 'Desenhos'
    - Os testes modificam o arquivo 'desenhos.pl' e retornam o arquivo ao 
    estado original (tartaruga) no final
*/

:- set_prolog_flag(double_quotes, codes).
:- initialization(testes).

testes :-
    teste0, teste1, teste2, teste3, teste4, teste5,
    tartaruga, commit.

% Teste: figuraclone, figuragiradireita, figuragiraesquerda
% Desenha 3 quadrados de mesmo tamanho lado a lado,
% girando um para esquerda e outro para direita 10 graus
teste0 :-
    consult('programa.pl'),
    tartaruga,
    cmd("pf 100 gd 90 pf 100 gd 90 pf 100 gd 90 pf 100"), 
    cmd("figclone 1 700 500"),
    cmd("figclone 1 300 500"),
    cmd("figgd 2 10"),
    cmd("figge 3 10"),
    svg('Desenhos/teste0.svg').

% Teste: figuraclone
% Desenha uma "flor grande" (do t2B) e a copia para a posição (700,200)
teste1 :-
    consult('programa.pl'),
    tartaruga,
    cmd("repita 36 [ gd 150 repita 8 [ pf 50 ge 45 ] ]"),
    cmd("figclone 1 700 200"),
    svg('Desenhos/teste1.svg').

% Teste: figuraparafrente
% Desenha uma circunferência em (500,500) e move-a para frente 250u
teste2 :-
    consult('programa.pl'),
    tartaruga,
    cmd("repita 36 [ ge 10 pf 10 ]"),
    cmd("figpf 1 250"),
    svg('Desenhos/teste2.svg').

% Teste: figuraparatras
% Desenha uma circunferência em (500,500) e move-a para trás 250u
teste3 :-
    consult('programa.pl'),
    tartaruga,
    cmd("repita 36 [ ge 10 pf 10 ]"),
    cmd("figpt 1 250"),
    svg('Desenhos/teste3.svg').

% Teste: figuragiradireita
% Desenha um quadrado em (500,500) e gira a direita 30 graus
teste4 :-
    consult('programa.pl'),
    tartaruga,
    cmd("pf 100 gd 90 pf 100 gd 90 pf 100 gd 90 pf 100"), 
    cmd("figgd 1 30"),
    svg('Desenhos/teste4.svg').

% Teste: figuragiraesquerda
% Desenha um quadrado em (500,500) e gira a esquerda 30 graus
teste5 :-
    consult('programa.pl'),
    tartaruga,
    cmd("pf 100 gd 90 pf 100 gd 90 pf 100 gd 90 pf 100"), 
    cmd("figge 1 30"),
    svg('Desenhos/teste5.svg').