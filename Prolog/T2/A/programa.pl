/*
   Programacao Logica - Prof. Alexandre G. Silva - 30set2015
     Versao inicial     : 30set2015
     Ultima atualizacao : 12set2017

   RECOMENDACOES:

   - O nome deste arquivo deve ser 'programa.pl'

   - O nome do banco de dados deve ser 'desenhos.pl'

   - Dicas de uso podem ser obtidas na execucação:
     ?- menu.

   - Exemplo de uso:
     ?- load.
     ?- searchAll(id1).

   - Colocar o nome e matricula de cada integrante do grupo
     nestes comentarios iniciais do programa
*/

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
    retractall(xy(_,_,_)),
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
    listing(xy),  %listagem dos predicados 'xy'
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

%------------------------------------
% t2A
% -----------------------------------

% Auxiliares
% Encontra o deslocamento final de <Id>
searchLastEach(Id, N) :- searchId(Id,L), last(L, N).

% Monta a lista <S> com todos os <Id>s
allIds(L) :- findall(Id, xy(Id, _, _), L1), sort(L1, L).

% Monta a lista <All> com todos os pontos xy da database
listXY(Id, All) :- findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All).

% Questao 1 (resolvida)
% Monta lista <L> com ponto inicial e todos os deslocamentos de <Id>
searchId(Id,L) :-
    bagof([X,Y], xy(Id,X,Y), L).

% Questao 2 (CORRETO)
% Monta lista <L> com pontos iniciais de cada <Id>
searchFirst(L) :-  findall(H, searchId(_, [H|_]), L).

% Questao 3 (CORRETO)
% Monta lista <L> com pontos ou deslocamentos finais de cada <Id>
searchLast(L) :-  findall(N, searchLastEach(_, N), L).

% Questao 4 (CORRETO)
% Remove todos os pontos ou deslocamentos do ultimo <Id>
removeLast :- allIds(S), last(S, Last), retractall(xy(Last, _, _)), !.

% Questao 5 (CORRETO)
% Remove o ultimo ponto ou deslocamento de <Id>
removeLast(Id) :- listXY(Id, All), last(All, Last), nth0(1, Last, Xf),
                  nth0(2, Last, Yf), retract(xy(Id, Xf, Yf)), !.

% Questao 6 (CORRETO)
% Determina um novo <Id> na sequencia numerica existente
newId(Id) :- allIds(S), last(S, Last), Id is Last + 1.

% Questao 7 (CORRETO)
% Duplica a figura com <Id> a partir de um nova posicao (X,Y)
% Deve ser criado um <Id_novo> conforme a sequencia (questao 6)
cloneId(Id,X,Y) :- newId(NID),
    				listXY(Id, All),
    				length(All, Size),
    				between(0, Size, Middle),
    				nth0(Middle, All, J),
                    nth0(1, J, XNew),
                    nth0(2, J, YNew),
                    XFinal is XNew + X,
                    YFinal is YNew + Y,
                    (
                        (Middle =:= 0) -> 
                            new(NID, XFinal, YFinal); 
                        new(NID, XNew, YNew)
                    ), ( Middle =:= Size - 1 -> true).
