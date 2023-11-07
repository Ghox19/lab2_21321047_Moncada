:- module(chatbot_21321047_MoncadaSanchez, [mChatbot/6, getChatbotId/2 ,getChatbotFlows/2, getChatbotFlowsClean/3, getChatbotInitialFlowIdById/3]).

:- use_module(flow_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de un Chatbot como lista
%Dominio: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows (Lista de 0 o más flujos) X chatbot(list)
%Metodo: Ninguno.
%Metas primarias: mChatbot/6.
%Metas secundarias: Ninguna.
mChatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, 
    [ChatbotID, Name, WelcomeMessage, StartFlowId, Flows]).

%Descripcion: Predicado que obtiene un Id de un Chatbot
%Dominio: Chatbot (list) x Id (int)
%Metodo: Ninguno.
%Metas primarias: getChatbotId/2.
%Metas secundarias: mChatbot/6.
getChatbotId(Chatbot, Id) :-
    mChatbot(Id, _, _, _, _, Chatbot).

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
getChatbotFlowsClean([], _, []).
getChatbotFlowsClean([H | T], [HO | TO], Resultado) :-
    getFlowId(HO, OC),
    \+ H = OC,
    getChatbotFlowsClean(T, TO, Resultado).
getChatbotFlowsClean([_ | T], [HO | TO], [HO | Resultado]) :-
    getChatbotFlowsClean(T, TO, Resultado).

%Descripcion: Predicado creador de una lista de Flows limpia(sin repetidos) a base de lista de id
%Dominio: IdChatbot (int) x ListaDeChatbots (list) x Resultado(int)
%Metodo: Recursion de cola
%Metas primarias: getChatbotFlowInitialFlowIdById/3.
%Metas secundarias: getChatbotId/2, getChatbotStartFlowId/2.
getChatbotInitialFlowIdById(_, [], []).
getChatbotInitialFlowIdById(Id, [H | T], Resultado):-
    getChatbotId(H, Id_Chatbot),
    \+ Id = Id_Chatbot,
    getChatbotInitialFlowIdById(Id, T, Resultado).
getChatbotInitialFlowIdById(_, [H | _], Resultado):-
    getChatbotStartFlowId(H, Resultado).