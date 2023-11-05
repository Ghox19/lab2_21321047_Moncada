:- module(chatbot_21321047_MoncadaSanchez, [mChatbot/6, getChatbotFlowsClean/3]).

:- use_module(flow_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de un Chatbot como lista
%Dominio: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows (Lista de 0 o más flujos) X chatbot(list)
%Metodo: No.
%Metas primarias: mChatbot/6.
%Metas secundarias: Ninguna.
mChatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, 
    [ChatbotID, Name, WelcomeMessage, StartFlowId, Flows]).

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