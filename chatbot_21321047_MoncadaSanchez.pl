:- module(chatbot_21321047_MoncadaSanchez, [mChatbot/6, getChatbotId/2, getChatbotName/2,
                                            getChatbotFlows/2, getChatbotById/3,
                                            getChatbotFlowsClean/3, getChatbotInitialFlowIdById/3]).

:- use_module(flow_21321047_MoncadaSanchez).
:- use_module(common_21321047_MoncadaSanchez).

%%CONSTRUCTORES%%
%Descripcion: Predicado creador de un Chatbot como lista
%Dominio: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows (Lista de 0 o más flujos) X chatbot(list)
%Metodo: Ninguno.
%Metas primarias: mChatbot/6.
%Metas secundarias: Ninguna.
mChatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, 
    [ChatbotID, Name, WelcomeMessage, StartFlowId, Flows]).

%%SELECTORES%%
%Descripcion: Predicado que obtiene un Id de un Chatbot.
%Dominio: Chatbot (list) x Id (int).
%Metodo: Ninguno.
%Metas primarias: getChatbotId/2.
%Metas secundarias: mChatbot/6.
getChatbotId(Chatbot, Id) :-
    mChatbot(Id, _, _, _, _, Chatbot).

%Descripcion: Predicado que obtiene un Nombre de un Chatbot.
%Dominio: Chatbot (list) x Name (string).
%Metodo: Ninguno.
%Metas primarias: getChatbotId/2.
%Metas secundarias: mChatbot/6.
getChatbotName(Chatbot, Name) :-
    mChatbot(_, Name, _, _, _, Chatbot).

%Descripcion: Predicado que obtiene una lista de Flows de un Chatbot
%Dominio: Chatbot (list) x Flows(list)
%Metodo: Ninguno.
%Metas primarias: getChatbotFlows/2.
%Metas secundarias: mChatbot/6.
getChatbotFlows(Chatbot, Flows) :-
    mChatbot(_, _, _, _, Flows, Chatbot).

%Descripcion: Predicado que obtiene la Id del flow inicial de un Chatbot
%Dominio: Chatbot (list) x StartFlowId (int)
%Metodo: Ninguno.
%Metas primarias: getChatbotStartFlowId/2.
%Metas secundarias: mChatbot/6.
getChatbotStartFlowId(Chatbot, StartFlowId) :-
    mChatbot(_, _, _, StartFlowId, _, Chatbot).

%Descripcion: Predicado creador de una lista de Flows limpia(sin repetidos) a base de lista de id
%Dominio: ListaDeID (list) x ListaDeFlows (list) x Resultado(list)
%Metodo: Recursion de cola
%Metas primarias: getChatbotFlowsClean/3.
%Metas secundarias: getFlowId/2.
getChatbotFlowsClean([], Acum, ReverseAcum):-
    reverse(Acum, ReverseAcum).

getChatbotFlowsClean([H | T], Acum, Resultado) :-
    getFlowId(H, OptionId),
    maplist(getFlowId, Acum, AcumIds),
    maplist(getFlowId, T, TIds),
    \+ member(OptionId, AcumIds),
    \+ member(OptionId, TIds),
    addToEnd(H, Acum, NewAcum),
    getChatbotFlowsClean(T, NewAcum, Resultado),
    !.

getChatbotFlowsClean([_ | T], Acum, Resultado) :-
    getChatbotFlowsClean(T, Acum, Resultado).

%Descripcion: Predicado que obtiene una lista de Flows limpia(sin repetidos) a base de lista de id
%Dominio: IdChatbot (int) x ListaDeChatbots (list) x Resultado(int)
%Metodo: Recursion de cola
%Metas primarias: getChatbotFlowInitialFlowIdById/3.
%Metas secundarias: getChatbotId/2, getChatbotStartFlowId/2.
getChatbotInitialFlowIdById(_, [], []).
getChatbotInitialFlowIdById(Id, [H | T], Resultado):-
    getChatbotId(H, IdChatbot),
    \+ Id = IdChatbot,
    getChatbotInitialFlowIdById(Id, T, Resultado).
getChatbotInitialFlowIdById(_, [H | _], Resultado):-
    getChatbotStartFlowId(H, Resultado).

%Descripcion: Predicado que obtiene un Flow a base de un Id
%Dominio: Chatbot (list) x IdChatbot (int) x Resultado(Flow)
%Metodo: Recursion de cola.
%Metas primarias: getChatbotById/3.
%Metas secundarias: getChatbotId/2.
getChatbotById([], _, []).
getChatbotById([H | T], IdChatbot, Resultado):-
    getChatbotId(H, IdChatbot_List),
    \+ IdChatbot = IdChatbot_List,
    getChatbotById(T, IdChatbot, Resultado).
getChatbotById([H | _], _, H).