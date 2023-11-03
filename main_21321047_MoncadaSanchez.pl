:- use_module(option_21321047_MoncadaSanchez).
:- use_module(common_21321047_MoncadaSanchez).
:- use_module(flow_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de una opcion
%Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o más palabras claves) X Option
%Metodo: No.
%Metas primarias: option/6.
%Metas secundarias: mOption/6.
option(Code, Message, Codelink, InitialFlowCodeLink, Keywords, Option):-
    mOption(Code, Message, Codelink, InitialFlowCodeLink, Keywords, Option).

%Descripcion: Predicado creador de un Flow
%Dominio: id (int) X name-msg (String)  X Option  (Lista de 0 o más opciones) X Flow
%Metodo: Recursion de cola en el predicado "EliminarRepetidos" y "getOptionsFlowClean"
%Metas primarias: flow/4.
%Metas secundarias: maplist/3, eliminarRepetidos/2, getOptionsFlowClean/3, mFlow/4.
flow(Id, Name_msg, Option, Flow):-
    maplist(getCodeOption, Option, OptionID_List),
    eliminarRepetidos(OptionID_List, OptionId_Clean),
    getOptionsFlowClean(OptionId_Clean, Option, Option_Clean),
    mFlow(Id, Name_msg, Option_Clean, Flow).

%Descripcion: Predicado que agtrega un Flow a una option.
%Dominio: flow X option X flow.
%Metodo: Recursion de Cola en el predicado addToEnd.
%Metas primarias: flowAddOption/4.
%Metas secundarias: getOptionsFlow/2, maplist/3, getCodeOption/2, member/2, addToEnd/3, mFlow/4.
flowAddOption(FlowIn, Option, FlowOut):-
    getOptionsFlow(FlowIn, Flow_Options),
    maplist(getCodeOption, Flow_Options, Flow_ID_Options),
    getCodeOption(Option, Option_ID),
    \+ member(Option_ID, Flow_ID_Options),
    addToEnd(Option, Flow_Options, NewFlow_Options),
    mFlow(IdInput, Name_msgInput, _, FlowIn),
    mFlow(IdInput, Name_msgInput, NewFlow_Options, FlowOut).
flowAddOption(_, _, []).