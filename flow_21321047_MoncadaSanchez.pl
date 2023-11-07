:- module(flow_21321047_MoncadaSanchez, [mFlow/4, getFlowId/2, getFlowOptionsClean/3, getFlowOptions/2]).

:- use_module(option_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de un Flow como lista
%Dominio: id (int) X name-msg (String)  X Option  (Lista de 0 o más opciones) X Flow (list)
%Metodo: Ninguno.
%Metas primarias: mflow/4.
%Metas secundarias: Ninguna.
mFlow(Id, Name_msg, Option, [Id, Name_msg, Option]).

%Descripcion: Predicado que obtiene un id de un Flow
%Dominio: Flow (list) x Id(int)
%Metodo: Ninguno.
%Metas primarias: getOptionsFlow/2.
%Metas secundarias: mFlow/4.
getFlowId(Flow, Id) :-
    mFlow(Id, _, _, Flow).

%Descripcion: Predicado que obtiene una lista de Opciones de un Flow
%Dominio: Flow (list) x Options(list)
%Metodo: Ninguno.
%Metas primarias: getOptionsFlow/2.
%Metas secundarias: mFlow/4.
getFlowOptions(Flow, Options) :-
    mFlow(_, _, Options, Flow).

%Descripcion: Predicado creador de una lista de Opciones limpia(sin repetidos) a base de lista de id
%Dominio: ListaDeID (list) x ListaDeOpciones (list) x Resultado(list)
%Metodo: Recursion de cola
%Metas primarias: getFlowOptionsClean/3.
%Metas secundarias: getCodeOption/2.
getFlowOptionsClean([], _, []).
getFlowOptionsClean([H | T], [HO | TO], Resultado) :-
    getOptionCode(HO, OC),
    \+ H = OC,
    getFlowOptionsClean([H | T], TO, Resultado).
getFlowOptionsClean([_ | T], [HO | TO], [HO | Resultado]) :-
    getFlowOptionsClean(T, TO, Resultado).

