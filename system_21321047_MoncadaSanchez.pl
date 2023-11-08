:- module(system_21321047_MoncadaSanchez, [mSystem/9, getSystemUsers/2, getSystemChatbot/2, getSystemChatbotsClean/3, setSystemNewChatbot/3, setSystemNewUser/3]).

:- use_module(chatbot_21321047_MoncadaSanchez).

%Descripcion: Predicado que crea un System como Lista.
%Dominio: name (string) X InitialChatbotCodeLink (Int) X chatbots (Lista de 0 o más chatbots) X system (list)
%Metodo: Ninguno.
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

%Descripcion: Predicado que obtiene una lista de Usuarios de un System
%Dominio: System (list) x Users (list)
%Metodo: Ninguno.
%Metas primarias: getSystemUsers/2.
%Metas secundarias: mSystem/9.
getSystemUsers(System, Users):-
    mSystem(_, Users, _, _, _, _, _, _, System).

%Descripcion: Predicado que obtiene una lista de Chatbots de un System
%Dominio: System (list) x Chatbot (list)
%Metodo: Ninguno.
%Metas primarias: getSystemChatbot/2.
%Metas secundarias: mSystem/9.
getSystemChatbot(System, Chatbot):-
    mSystem(_, _, _, _, _, _, _, Chatbot, System).

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

%Descripcion: Predicado que define un nuevo System con una nueva lista de Chatbots
%Dominio: SystemIn x NewSystemChatbots (list) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemNewChatbot/3.
%Metas secundarias: mSystem/9.
setSystemNewChatbot(SystemIn, NewSystemChatbots, SystemOut):-
    mSystem(NameInput, 
            UsersInput, 
            Loged_UserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            _,
            SystemIn),
    mSystem(NameInput, 
            UsersInput, 
            Loged_UserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            NewSystemChatbots,
            SystemOut).

%Descripcion: Predicado que define un nuevo System con una nueva lista de Users
%Dominio: SystemIn x NewUsersList(list) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemNewUsers/3.
%Metas secundarias: mSystem/9.
setSystemNewUser(SystemIn, NewUsersList, SystemOut):-
    mSystem(NameInput, 
            _, 
            Loged_UserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemIn),
    mSystem(NameInput, 
            NewUsers_List, 
            Loged_UserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemOut).