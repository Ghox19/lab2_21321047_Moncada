:- module(flow_21321047_MoncadaSanchez, [mFlow/4, getFlowId/2, getFlowOptionsClean/3, 
                                        getFlowNameMsg/2, getFlowOptions/2, getFlowById/3]).

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

%Descripcion: Predicado que obtiene un Namemsg de un Flow
%Dominio: Flow (list) x NameMsg (string)
%Metodo: Ninguno.
%Metas primarias: getOptionsFlow/2.
%Metas secundarias: mFlow/4.
getFlowNameMsg(Flow, NameMsg) :-
    mFlow(_, NameMsg, _, Flow).

%Descripcion: Predicado que obtiene una lista de Opciones de un Flow
%Dominio: Flow (list) x Options(list)
%Metodo: Ninguno.
%Metas primarias: getOptionsFlow/2.
%Metas secundarias: mFlow/4.
getFlowOptions(Flow, Options) :-
    mFlow(_, _, Options, Flow).

%Descripcion: Predicado que obtiene una lista de Opciones limpia(sin repetidos) a base de lista de id.
%Dominio: ListaDeID (list) x ListaDeOpciones (list) x Resultado(list).
%Metodo: Recursion de cola.
%Metas primarias: getFlowOptionsClean/3.
%Metas secundarias: getCodeOption/2.
getFlowOptionsClean([], _, []).
getFlowOptionsClean([H | T], [HO | TO], Resultado) :-
    getOptionCode(HO, OC),
    \+ H = OC,
    getFlowOptionsClean([H | T], TO, Resultado).
getFlowOptionsClean([_ | T], [HO | TO], [HO | Resultado]) :-
    getFlowOptionsClean(T, TO, Resultado).

%Descripcion: Predicado que obtiene un Flow en base a su Id de una lista de Flow.
%Dominio: ListaDeFlow (list) x IdFlow (int) x Resultado(Flow).
%Metodo: Recursion de cola.
%Metas primarias: getFlowById/3.
%Metas secundarias: getFlowId/2.
getFlowById([], _, []).
getFlowById([H | T], IdFlow, Resultado):-
    getFlowId(H, IdFlow_List),
    \+ IdFlow = IdFlow_List,
    getFlowById(T, IdFlow, Resultado).
getFlowById([H | _], _, H).