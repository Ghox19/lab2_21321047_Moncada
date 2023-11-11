:- module(common_21321047_MoncadaSanchez, [eliminarRepetidos/2, addToEnd/3, downcaseLista/2]).

%Descripcion: Predicado elimina un elemento del resto.
%Dominio: Elemento (int | string) x Lista (list) x Resultado(list).
%Metodo: Recursion de Cola.
%Metas primarias: eliminarResto/3.
%Metas secundarias: ninguna.
eliminarResto(_, [], []).
eliminarResto(Elemento, [H | T], Resultado) :-
    Elemento = H,
    eliminarResto(Elemento, T, Resultado).
eliminarResto(Elemento, [H | T], [H | Resultado]) :-
    eliminarResto(Elemento, T, Resultado).

%Descripcion: Predicado elimina elementos repetidos dentro de una lista.
%Dominio: Lista (list) x Resultado(list).
%Metodo: Recursion de Cola.
%Metas primarias: eliminarRepetidos/2.
%Metas secundarias: eliminarResto/3.
eliminarRepetidos([], []).
eliminarRepetidos([H | T], Resultado) :-
    member(H, T),
    eliminarResto(H, T, Lista_limpia),
    eliminarRepetidos([H | Lista_limpia], Resultado).
eliminarRepetidos([H | T], [H | Resultado]) :-
    eliminarRepetidos(T, Resultado).

%Descripcion: Predicado que agrega un elemento al final de una lista.
%Dominio: Elemento x Lista (list) x Resultado(list).
%Metodo: Recursion de Cola.
%Metas primarias: addToEnd/3.
%Metas secundarias: Ninguna.
addToEnd(Elemento, [], [Elemento]).
addToEnd(Elemento, [H | T], [H | NT]) :-
    addToEnd(Elemento, T, NT).

downcaseLista([], []).
downcaseLista([H | T], [LowerH | LowerT]) :-
    downcase_atom(H, LowerH),  
    downcaseLista(T, LowerT).  