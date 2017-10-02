:- consult('linguagens.pl').

% Questão 1 (resolvida)
lingcompre(L) :- predecessora(L, _).

% Questão 2
lingprecompre(L) :- 
	predecessora(L, _),
	predecessora(_, L).

% Questão 3
lingpreano(Lp, A) :- 
	linguagem(L, A),
	predecessora(L, Lp).

