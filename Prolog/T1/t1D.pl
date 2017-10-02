:- consult('linguagens.pl').   %considere 'linguagens.pl' dado

% t1D
% -----------------------------------

% Questão 1 (resolvida)
lingmaisantiga_aux([], _, L, L).
lingmaisantiga_aux([H|T], A1, L1, L) :- linguagem(H, A2), A1 =< A2, lingmaisantiga_aux(T, A1, L1, L).
lingmaisantiga_aux([H|T], A1, _ , L) :- linguagem(H, A2), A1 >= A2, lingmaisantiga_aux(T, A2, H , L).

lingmaisantiga(L) :- findall(L1, linguagem(L1, _), Lista), lingmaisantiga_aux(Lista, 9999, _, L).

% Questão 2 (CORRETO)

lingmaisrecente(L) :- findall(A, linguagem(_, A), Lista), max_list(Lista, Ano), linguagem(L, Ano).

% Questão 3 (CORRETO)

qsaopre(L, N) :- findall(Lp, predecessora(L, Lp), La), length(La, N). 

lingcommaispre_aux(L, N) :- linguagem(L,_), qsaopre(L,N).
lingcommaispre(L) :- findall(N, lingcommaispre_aux(_,N), Lista), max_list(Lista, Q), lingcommaispre_aux(L, Q).

% Questão 4 (CORRETO)

qtempre(L, N) :- findall(Ls, predecessora(Ls, L), La), length(La, N).

linginfluente_aux([], _, L, L).
linginfluente_aux([H|T], N1, L1, L) :- qtempre(H, N2), N1 >= N2, linginfluente_aux(T, N1, L1, L).
linginfluente_aux([H|T], N1, _ , L) :- qtempre(H, N2), N1 =< N2, linginfluente_aux(T, N2, H, L).

linginfluente(L) :- findall(L1, linguagem(L1, _), Lista), linginfluente_aux(Lista, 0, _, L).

% Questão 5 (CORRETO)

qano(A, N) :- findall(L, linguagem(L, A), La), length(La, N).

linganocriativo_aux(A, N) :- linguagem(_, A), qano(A,N).
linganocriativo(A) :- findall(N, linganocriativo_aux(_,N), L), max_list(L, Q), linganocriativo_aux(A, Q).

% Questão 6 (CORRETO)

lingdecada(L, D) :- Decada is D-mod(D,10), linguagem(L, A), Decada+10>A, A>=Decada.
qdecada(D, N) :- findall(L, lingdecada(L, D), La), length(La, N).

lingdecadacriativa_aux(A, N) :- linguagem(_,A), qdecada(A,N), A is A-mod(A,10).
lingdecadacriativa(A) :- findall(N, lingdecadacriativa_aux(_, N), Lista), max_list(Lista, Ano), lingdecadacriativa_aux(A, Ano).

% Questão 7 (CORRETO)

linglistapre(X, []) :- \+ predecessora(X, _).
linglistapre(X, [Y|L]) :- predecessora(X, Y), linglistapre(Y, L).

	 	  	 	     	  		  	  	      	    	 	
