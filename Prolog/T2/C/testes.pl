:- set_prolog_flag(double_quotes, codes).
:- initialization(teste3).

%------------------------------------
% t2B
% -----------------------------------

testes :-
	consult('programa.pl'),
	load,
	cmd("pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54
	ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37
	pt 28 gd 95 pf 54 ge 37 pt 28 gd 95"),
	cmd("un pt 200 ge 90 pf 200 ul"),
	cmd("repita 36 [ gd 150 repita 8 [ pf 50 ge 45 ] ]"),
	cmd("un pt 400 ul"),
	cmd("repita 72 [ ge 10 pf 5 ]"),
	cmd("un pt 150 ul"),
	cmd("repita 12 [ pf 100 gd 150 ]"), 
	svg('desenhos.svg').

%------------------------------------
% t2C
% -----------------------------------

% Teste: figuraclone, figuragiradireita, figuragiraesquerda
% Desenha 3 quadrados de mesmo tamanho lado a lado,
% girando um para esquerda e outro para direita 10 graus
teste0 :-
	consult('programa.pl'),
	load,
	cmd("pf 100 gd 90 pf 100 gd 90 pf 100 gd 90 pf 100"), 
	cmd("figclone 1 700 500"),
	cmd("figclone 1 300 500"),
	cmd("figgd 2 10"),
	cmd("figge 3 10"),
	svg('teste0.svg').

% Teste: figuraclone
% Desenha uma "flor grande" (do t2B) e a copia para a posição (700,200)
teste1 :-
	consult('programa.pl'),
	tartaruga,
	load,
	cmd("repita 36 [ gd 150 repita 8 [ pf 50 ge 45 ] ]"),
	cmd("figclone 1 700 200"),
	svg('teste1.svg').

% Teste: figuraparafrente
% Desenha uma circunferência em (500,500) e move-a para frente 300u
teste2 :-
	consult('programa.pl'),
	tartaruga,
	load,
	cmd("repita 72 [ ge 10 pf 5 ]"),
	cmd("figpf 1 300"),
	svg('teste2.svg').

% Teste: figuraparatras
% Desenha uma circunferência em (500,500) e move-a para trás 200u
teste3 :-
	consult('programa.pl'),
	tartaruga,
	load,
	cmd("repita 72 [ ge 10 pf 5 ]"),
	cmd("figpt 1 200"),
	svg('teste3.svg').

% Teste: figuragiradireita
% Desenha um quadrado em (500,500) e gira a direita 45 graus
teste4 :-
	consult('programa.pl'),
	tartaruga,
	load,
	cmd("pf 100 gd 90 pf 100 gd 90 pf 100 gd 90 pf 100"), 
	cmd("figgd 1 45"),
	svg('teste4.svg').

% Teste: figuragiraesquerda
% Desenha um quadrado em (500,500) e gira a esquerda 30 graus
teste5 :-
	consult('programa.pl'),
	tartaruga,
	load,
	cmd("pf 100 gd 90 pf 100 gd 90 pf 100 gd 90 pf 100"), 
	cmd("figge 1 30"),
	svg('teste5.svg').