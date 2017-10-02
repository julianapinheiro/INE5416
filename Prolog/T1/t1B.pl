:- consult('linguagens.pl').   %considere 'linguagens.pl' dado

% t1B
% -----------------------------------

% Questão 1 (resolvida)
lingnaosaopre(L) :- linguagem(L, _), \+predecessora(_, L).

% Escrever demais questões...

% Questão 2
lingprecomum(L1, L2, Lp) :- predecessora(L1, Lp), predecessora(L2, Lp), L1\=L2.

% Questão 3
lingprepre(Lpp, Lp, L) :- predecessora(L, Lp), predecessora(Lp, Lpp).

% Questão 4
lingpredecada(Lp, L) :- predecessora(L, Lp), linguagem(L, X), linguagem(Lp, Y), X-Y>=10.

% Questão 5
lingdecada(L, D) :- DECADA is D-mod(D,10), linguagem(L, A), DECADA+10>A, A>=DECADA.

% Questão 6 correto
lingcommultipre(L) :- predecessora(L, A), predecessora(L, B), A\=B.
