:- module(common_21321047_MoncadaSanchez, [eliminarRepetidos/2]).

%Descripcion: Predicado elimina un elemento del resto.
%Dominio: Elemento (int | string) x Lista (list) x Resultado(list).
%Metodo: Recursion de Cola.
%Metas primarias: eliminarResto.
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
%Metas primarias: eliminarRepetidos.
%Metas secundarias: eliminarResto/3.
eliminarRepetidos([], []).
eliminarRepetidos([H | T], Resultado) :-
    member(H, T),
    eliminarResto(H, T, Lista_limpia),
    eliminarRepetidos([H | Lista_limpia], Resultado).
eliminarRepetidos([H | T], [H | Resultado]) :-
    eliminarRepetidos(T, Resultado).