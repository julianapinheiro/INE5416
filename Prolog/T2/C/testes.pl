%	:- set_prolog_flag(double_quotes, codes).
%	:- initialization(testes).

testes :-
	consult('programa.pl'),
	load,
	cmd("pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54
	ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37
	pt 28 gd 95 pf 54 ge 37 pt 28 gd 95"),
	cmd("un pt 200 ge 90 pf 200 ul"),
	cmd("repita 36 [ gd 150 repita 8 [ pf 50 ge 45 ] ]"),
	cmd("un pt 400 ul"),
	cmd("repita 72 [ ge 10 pf 5 ]"), %foi
	cmd("un pt 150 ul"),
	cmd("repita 12 [ pf 100 gd 150 ]"), 
	svg.

teste1 :-
	consult('programa.pl'),
	load,
	cmd("repita 12 [ pf 100 gd 150 ]"), 
	svg.