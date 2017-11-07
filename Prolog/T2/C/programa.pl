/*
   Programacao Logica - Prof. Alexandre G. Silva - 30set2015
     Versao inicial     : 30set2015
     Adicao de gramatica: 15out2015
     Atualizacao        : 12out2016
     Atualizacao        : 10mai2017
     Ultima atualizacao : 12set2017

   RECOMENDACOES:
   
   - O nome deste arquivo deve ser 'programa.pl'
   - O nome do banco de dados deve ser 'desenhos.pl'
   - O nome do arquivo de gramatica deve ser 'gramatica.pl'
   
   - Dicas de uso podem ser obtidas na execucação: 
     ?- menu.
     
   - Exemplo de uso:
     ?- load.
     ?- searchAll(1).

   - Exemplos de uso da gramatica:
     ?- comando([pf, '10'], []).
     Ou simplesmente:
     ?- cmd("pf 10").
   
     ?- comando([repita, '5', '[', pf, '50', gd, '45', ']'], []).
     Ou simplesmente:
     ?- cmd("repita 5[pf 50 gd 45]").
     
   - Colocar o nome e matricula de cada integrante do grupo
     nestes comentarios iniciais do programa
*/

:- set_prolog_flag(double_quotes, codes).
:- initialization(load).

% Exibe menu principal
menu :-
    write('load.         -> Carrega todos os desenhos do banco de dados para a memoria'), nl,
    write('commit.       -> Grava alteracoes de todos os desenhos no banco de dados'), nl,
    write('new(Id,X,Y).  -> Insere ponto/deslocamento no desenho com identificador <Id>'), nl,
    write('search.       -> Consulta pontos/deslocamentos dos desenhos'), nl,
    write('remove.       -> Remove pontos/deslocamentos dos desenhos'), nl,
    write('svg.          -> Cria um arquivo de imagem vetorial SVG (aplica "commit." antes'), nl.

% Apaga os predicados 'xy' da memoria e carrega os desenhos a partir de um arquivo de banco de dados
load :-
    consult('gramatica.pl'),
    retractall(xy(_,_,_)),
    retractall(xylast(_,_,_)),
    retractall(angle(_)),
    retractall(active(_)),
    retractall(figureangle(_,_)),
    open('desenhos.pl', read, Stream),
    repeat,
        read(Stream, Data),
        (Data == end_of_file -> true ; assert(Data), fail),
        !,
        close(Stream).

% Grava os desenhos da memoria em arquivo
commit :-
    open('desenhos.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(xylast),  %listagem dos predicados 'xylast'
    listing(angle),   %listagem dos predicados 'angle'
    listing(active),  %listagem dos predicados 'active'
    listing(xy),      %listagem dos predicados 'xy'
    listing(figureangle),
    tell(Screen),
    close(Stream).

% Ponto de deslocamento, se <Id> existente
new(Id,X,Y) :-
    xy(Id,_,_),
    assertz(xy(Id,X,Y)),
    !.

% Ponto inicial, caso contrario
new(Id,X,Y) :-
    asserta(xy(Id,X,Y)),
    !.

% Exibe opcoes de busca
search :-
    write('searchId(Id,L).  -> Monta lista <L> com ponto inicial e todos os deslocamentos de <Id>'), nl,
    write('searchFirst(L).  -> Monta lista <L> com pontos iniciais de cada <Id>'), nl,
    write('searchLast(L).   -> Monta lista <L> com pontos/deslocamentos finais de cada <Id>'), nl.

% Exibe opcoes de remocao
remove :-
    write('removeLast.      -> Remove todos os pontos/deslocamentos de <Id>'), nl,
    write('removeLast(Id).  -> Remove o ultimo ponto de <Id>'), nl.

% Grava os desenhos em SVG
svg :-
    commit,
    open('desenhos.svg', write, Stream),
    telling(Screen),
    tell(Stream),
    consult('db2svg.pl'),  %programa para conversao
    tell(Screen),
    close(Stream).

% Grava os desenhos em SVG, com o nome do arquivo como argumento
svg(File) :-
    commit,
    open(File, write, Stream),
    telling(Screen),
    tell(Stream),
    consult('db2svg.pl'),  %programa para conversao
    tell(Screen),
    close(Stream).

%------------------------------------
% t2B
% -----------------------------------

% Auxiliares
% Modificar lápis
setLapis(L) :- retractall(active(_)), asserta(active(L)).

% Modificar ângulo
setAngle(A) :- retractall(angle(_)), asserta(angle(A)).

% Deslocar X, Y
andar(X, Y) :-  active(Lapis),
                xylast(Id, X0, Y0),
                (   Lapis =:= 1 -> new(Id, X, Y), !; !),
                retractall(xylast(_, _, _)),
                NewX is X0 + X, NewY is Y0 + Y,
                asserta(xylast(Id, NewX, NewY)).

% Questao 1 (resolvida, mas pode ser alterada se necessario)
% Limpa os desenhos e reinicia no centro da tela (de 1000x1000)
tartaruga :-
    retractall(xy(_,_,_)),
    retractall(xylast(_,_,_)),
    retractall(angle(_)),
    retractall(active(_)),
    retractall(figureangle(_,_)),
    new(1, 500, 500),
    asserta(xylast(1, 500, 500)),
    asserta(figureangle(1, 90)),
    setAngle(90),
    setLapis(1).

% Questao 2
% Para frente N passos (conforme angulo atual)
parafrente(N) :-
    angle(A), 
    X is N * cos(A*pi/180), 
    Y is N * sin(A*pi/180)*(-1),
    andar(X, Y).

% Questao 3
% Para tras N passos (conforme angulo atual)
paratras(N) :- 
    angle(A),
    X is N * cos(A*pi/180)*(-1), 
    Y is N * sin(A*pi/180),
    andar(X, Y).

% Questao 4
% Gira a direita G graus
giradireita(G) :- 
    angle(A), NovoA is mod(A - G, 360), setAngle(NovoA).

% Questao 5
% Gira a esquerda G graus
giraesquerda(G) :- 
    angle(A), NovoA is mod(A + G, 360), setAngle(NovoA).

% Questao 6
% Use nada (levanta lapis)
usenada :- 
    setLapis(0).

% Questao 7
% Use lapis
uselapis :- 
    setLapis(1),
    xylast(Id, _, _),
    NewId is Id + 1,
    (NewId > 0 -> xylast(Id,X,Y), new(NewId, X, Y), 
        assertz(figureangle(NewId, 90)), retractall(xylast(_,_,_)), 
        asserta(xylast(NewId, X, Y)); true).
    
%------------------------------------
% t2C
% -----------------------------------

% Auxiliares (src: t2A/programa.pl)
% Monta a lista <S> com todos os <Id>s
allIds(L) :- findall(Id, xy(Id, _, _), L1), sort(L1, L).

% Monta a lista <All> com todos os pontos xy da database 
listXY(Id, All) :- 
    findall(V, (xy(Id, X, Y), append([Id], [X], L), 
    append(L, [Y], V)), All).

% Determina um novo <Id> na sequencia numerica existente
newId(Id) :- allIds(S), last(S, Last), Id is Last + 1.

% Modifica ângulo da figura
setfigureangle(Id, A) :- 
    retractall(figureangle(Id, _)), 
    asserta(figureangle(Id, A)).

% Questao 1
% Duplica a figura <Id> (criando um novo Id), na coordenada inicial <X,Y>
% cloneId do t2A/programa.pl modificado
figuraclone(Id, X, Y) :- 
    newId(NewId),
    asserta(figureangle(NewId, 90)),
    retractall(xylast(_,_,_)),
    listXY(Id, All),
    length(All, Size),
    between(0, Size, Middle),
    nth0(Middle, All, J),
    nth0(1, J, XNew),
    nth0(2, J, YNew),
    (
        (Middle =:= 0) -> 
            new(NewId, X, Y); 
        new(NewId, XNew, YNew)
    ), ( Middle =:= Size - 1 -> true), !.

% Questao 2
% Translada a figura <Id> para <N> passos a frente
% Implementado utilizando o <angle> atual para o cálculo do deslocamento
figuraparafrente(Id, N) :- 
    angle(A),
    X is N * cos(A*pi/180), 
    Y is N * sin(A*pi/180)*(-1),
    listXY(Id, [CoInicial|_]),
    nth0(1,CoInicial,X0),
    nth0(2,CoInicial,Y0),
    retract(xy(Id, X0, Y0)),
    NewX is X0 + X,
    NewY is Y0 + Y,
    asserta(xy(Id, NewX, NewY)), !.

% Questao 3
% Translada a figura <Id> para <N> passos para trás
% Implementado utilizando o <angle> atual para o cálculo do deslocamento
figuraparatras(Id, N) :- 
    M is -N,    
    figuraparafrente(Id, M).

% Questao 4
% Rotaciona a figura <Id> em A graus no sentido horário a partir da
% coordenada absoluta inicial
figuragiradireita(Id, A) :-
    figureangle(Id, G),
    NovoG is mod(G - A, 360),
    setfigureangle(Id, NovoG),
    listXY(Id, [CoInicial|Desl]),  % Coordenada inicial
    nth0(1,CoInicial,X0),          % Desl = lista de deslocamentos
    nth0(2,CoInicial,Y0),
    retractall(xy(Id, _, _)),      % Retract todos os deslocamentos
    length(Desl, Size),            % Numero de deslocamentos
    between(0, Size, I),           % Iteração por I
    nth0(I, Desl, J),
    nth0(1, J, X1),
    nth0(2, J, Y1),
    NewX is X1*cos(A*pi/180) - Y1*sin(A*pi/180),
    NewY is Y1*cos(A*pi/180) + X1*sin(A*pi/180),
    assertz(xy(Id, NewX, NewY)),        % Asserta novo deslocamento(i)
    % Asserta coordenada inicial
    (I =:= Size - 1 -> asserta(xy(Id, X0, Y0)), !).          

% Questao 5
% Rotaciona a figura <Id> em A graus no sentido anti-horário a partir da
% coordenada absoluta inicial
figuragiraesquerda(Id, A) :-
    B is -A,
    figuragiradireita(Id, B).         
