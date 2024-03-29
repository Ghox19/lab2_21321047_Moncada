:- module(common_21321047_MoncadaSanchez, [addToEnd/3, downcaseLista/2, 
                                        concatenarConSaltos/2, myRandom/2]).

%%OTRAS FUNCIONES%%
%Descripcion: Predicado que agrega un elemento al final de una lista.
%Dominio: Elemento x Lista (list) x Resultado(list).
%Metodo: Recursion de Cola.
%Metas primarias: addToEnd/3.
%Metas secundarias: Ninguna.
addToEnd(Elemento, [], [Elemento]).
addToEnd(Elemento, [H | T], [H | NT]) :-
    addToEnd(Elemento, T, NT).

%Descripcion: Predicado que obtiene de una lista de strings la misma pero en downcase.
%Dominio: Lista (list) x ResultadoLista (list).
%Metodo: Recursion de Cola.
%Metas primarias: downcaseLista/2.
%Metas secundarias: downcase_atom/2.
downcaseLista([], []).
downcaseLista([H | T], [LowerH | LowerT]) :-
    downcase_atom(H, LowerH),  
    downcaseLista(T, LowerT).  

%Descripcion: Predicado que concatena una lista de elemento con salto de linea.
%Dominio: Lista (list) x CadenaConcatenada (string).
%Metodo: Recursion de Cola.
%Metas primarias: concatenarConSaltos/2.
%Metas secundarias: atom_concat/2.
concatenarConSaltos([], '').
concatenarConSaltos([H | T], CadenaConcatenada) :-
    concatenarConSaltos(T, CadenaRestante),
    atom_concat(H, '\n', ElementoConSalto),
    atom_concat(ElementoConSalto, CadenaRestante, CadenaConcatenada).

%Descripcion: Predicado que genera un numero pseudocodigo.
%Dominio: Xn (int) x Xn1 (int).
%Metodo: Ninguno.
%Metas primarias: myRandom/2.
%Metas secundarias: No.
myRandom(Xn, Xn1):-
	MulTemp is 1103515245 * Xn,
	SumTemp is MulTemp + 12345,
	Xn1 is SumTemp mod 2147483648.