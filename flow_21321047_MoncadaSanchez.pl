:- module(flow_21321047_MoncadaSanchez, [mFlow/4, getOptionsFlowClean/3, getOptionsFlow/2]).

:- use_module(option_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de un Flow como lista
%Dominio: id (int) X name-msg (String)  X Option  (Lista de 0 o más opciones) X Flow (list)
%Metodo: No.
%Metas primarias: flow/4.
%Metas secundarias: Ninguna.
mFlow(Id, Name_msg, Option, [Id, Name_msg, Option]).

%Descripcion: Predicado que obtiene una lista de Opciones de un Flow
%Dominio: Flow (list) x Options(list)
%Metodo: No.
%Metas primarias: getOptionsFlow/2.
%Metas secundarias: mFlow/4.
getOptionsFlow(Flow, Options) :-
    mFlow(_, _, Options, Flow).

%Descripcion: Predicado creador de una lista de Opciones limpia(sin repetidos) a base de lista de id
%Dominio: ListaDeID (list) x ListaDeOpciones (list) x Resultado(list)
%Metodo: Recursion de cola
%Metas primarias: getOptionsFlowClean/3.
%Metas secundarias: getCodeOption/2.
getOptionsFlowClean([], _, []).
getOptionsFlowClean([H | T], [HO | TO], Resultado) :-
    getCodeOption(HO, OC),
    \+ H = OC,
    getOptionsFlowClean([H | T], TO, Resultado).
getOptionsFlowClean([_ | T], [HO | TO], [HO | Resultado]) :-
    getOptionsFlowClean(T, TO, Resultado).

