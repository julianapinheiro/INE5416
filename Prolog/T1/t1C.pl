:- consult('linguagens.pl').   %considere 'linguagens.pl' dado

% t1C
% -----------------------------------

% Questão 1 (resolvida)
qano(A, N) :- findall(L, linguagem(L, A), La), length(La, N).

% Escrever demais questões...

% Questão 2 correto
qsaopre(L, N) :- findall(Lp, predecessora(L, Lp), La), length(La, N).

% Questão 3
qsaopre(N) :- findall(List, bagof(L, predecessora(L, Lp), List), La), length(La, N).

% Questão 4
qtempre(N) :- findall(List, bagof(Lp, predecessora(L, Lp), List), La), length(La, N).

% Questão 5 correto
lingdecada(L, D) :- DECADA is D-mod(D,10), linguagem(L, A), DECADA+10>A, A>=DECADA.
qdecada(D, N) :- findall(L, lingdecada(L, D), La), length(La, N).

% Questão 6 correto
lingspan(L, A1, A2) :- linguagem(L, A), A2>=A, A>=A1.
qtotal(A1, A2, N) :- findall(L, lingspan(L, A1, A2), La), length(La, N).
	 	  	 	     	  		  	  	      	    	 	
