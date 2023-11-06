:- module(system_21321047_MoncadaSanchez, [mSystem/9, getSystemChatbotsClean/3]).

:- use_module(chatbot_21321047_MoncadaSanchez).

%Descripcion: Predicado que crea un System como Lista.
%Dominio: name (string) X InitialChatbotCodeLink (Int) X chatbots (Lista de 0 o más chatbots) X system (list)
%Metodo: No.
%Metas primarias: mSystem/9.
%Metas secundarias: Ninguna.
mSystem(Name, Users, Loged_User, ChatHistory, InitialChatbotCodeLink, ActualChatbotCodeLink, ActualFlowCodeLink, Chatbot, 
        [Name, 
        Users, 
        Loged_User, 
        ChatHistory, 
        InitialChatbotCodeLink, 
        ActualChatbotCodeLink, 
        ActualFlowCodeLink, 
        Chatbot]).

%Descripcion: Predicado creador de una lista de Chatbots limpia(sin repetidos) a base de lista de id
%Dominio: ListaDeID (list) x ListaDeChatbots (list) x Resultado(list)
%Metodo: Recursion de cola
%Metas primarias: getSystemChatbotsClean/3.
%Metas secundarias: getChatbotId/2.
getSystemChatbotsClean([], _, []).
getSystemChatbotsClean([H | T], [HO | TO], Resultado) :-
    getChatbotId(HO, OC),
    \+ H = OC,
    getSystemChatbotsClean([H | T], TO, Resultado).
getSystemChatbotsClean([_ | T], [HO | TO], [HO | Resultado]) :-
    getSystemChatbotsClean(T, TO, Resultado).