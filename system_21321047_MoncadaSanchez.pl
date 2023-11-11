:- module(system_21321047_MoncadaSanchez, [mSystem/9, getSystemUsers/2, 
                                           getSystemLogedUser/2,getSystemChatbot/2, 
                                           getSystemChatbotsClean/3, setSystemNewChatbot/3, 
                                           setSystemNewUser/3, setSystemNewLogedUser/3,
                                           getSystemOptionByMessage/3, getSystemLogedUserString/2,
                                           getSystemChatHistory/2, setSystemTalk/5, setSystemNoTalk/3,
                                           getSystemActualChatbotCodeLink/2, getSystemActualFlowCodeLink/2]).

:- use_module(chatbot_21321047_MoncadaSanchez).
:- use_module(flow_21321047_MoncadaSanchez).
:- use_module(option_21321047_MoncadaSanchez).

%Descripcion: Predicado que crea un System como Lista.
%Dominio: name (string) X InitialChatbotCodeLink (Int) X chatbots (Lista de 0 o más chatbots) X system (list)
%Metodo: Ninguno.
%Metas primarias: mSystem/9.
%Metas secundarias: Ninguna.
mSystem(Name, Users, LogedUser, ChatHistory, InitialChatbotCodeLink, ActualChatbotCodeLink, ActualFlowCodeLink, Chatbot, 
        [Name, 
        Users, 
        LogedUser, 
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

%Descripcion: Predicado que obtiene una lista del Usuario Logeado de un System
%Dominio: System (list) x User (list)
%Metodo: Ninguno.
%Metas primarias: getSystemUsers/2.
%Metas secundarias: mSystem/9.
getSystemLogedUser(System, LogedUser):-
    mSystem(_, _, LogedUser, _, _, _, _, _, System).

getSystemLogedUserString(System, Loged_User):-
    mSystem(_, _, [Loged_User | _], _, _, _, _, _, System).

getSystemChatHistory(System, ChatHistory):-
    mSystem(_, _, _, ChatHistory, _, _, _, _, System).

getSystemActualChatbotCodeLink(System, ActualChatbotCodeLink):-
    mSystem(_, _, _, _, _, ActualChatbotCodeLink, _, _, System).

getSystemActualFlowCodeLink(System, ActualFlowCodeLink):-
    mSystem(_, _, _, _, _, _, ActualFlowCodeLink, _, System).

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

getSystemOptionByMessage(SystemIn, Message, Option) :-
    getSystemChatbot(SystemIn, Chatbot_List),
    getSystemActualChatbotCodeLink(SystemIn, Chatbot_Id),
    getChatbotById(Chatbot_List, Chatbot_Id, Chatbot),
    getChatbotFlows(Chatbot, Flow_List),
    getSystemActualFlowCodeLink(SystemIn, Flow_Id),
    getFlowById(Flow_List, Flow_Id, Flow),
    getFlowOptions(Flow, Options_List),
    getOptionByMessage(Options_List, Message, Option).

%Descripcion: Predicado que define un nuevo System con una nueva lista de Chatbots
%Dominio: SystemIn x NewSystemChatbots (list) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemNewChatbot/3.
%Metas secundarias: mSystem/9.
setSystemNewChatbot(SystemIn, NewSystemChatbots, SystemOut):-
    mSystem(NameInput, 
            UsersInput, 
            LogedUserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            _,
            SystemIn),
    mSystem(NameInput, 
            UsersInput, 
            LogedUserInput, 
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
            LogedUserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemIn),
    mSystem(NameInput, 
            NewUsersList, 
            LogedUserInput, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemOut).

%Descripcion: Predicado que define un nuevo System con un nuevo User Logeado
%Dominio: SystemIn x LogedUser (string) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemNewLogedUser/3.
%Metas secundarias: mSystem/9.
setSystemNewLogedUser(SystemIn, LogedUser, SystemOut):-
    mSystem(NameInput, 
            Users_ListInput, 
            _, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemIn),
    mSystem(NameInput, 
            Users_ListInput, 
            LogedUser, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemOut).

setSystemTalk(SystemIn, ActualChatbotCodeLink, ActualFlowCodeLink, ChatHistory, SystemOut):-
    mSystem(NameInput, 
            Users_ListInput, 
            Loged_UserInput, 
            _, 
            InitialChatbotCodeLinkInput, 
            _, 
            _,
            System_ChatbotsInput,
            SystemIn),
    mSystem(NameInput, 
            Users_ListInput, 
            Loged_UserInput, 
            ChatHistory, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLink, 
            ActualFlowCodeLink,
            System_ChatbotsInput,
            SystemOut).

setSystemNoTalk(SystemIn, ChatHistory, SystemOut):-
    mSystem(NameInput, 
            Users_ListInput, 
            Loged_UserInput, 
            _, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemIn),
    mSystem(NameInput, 
            Users_ListInput, 
            Loged_UserInput, 
            ChatHistory, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLinkInput, 
            ActualFlowCodeLinkInput,
            System_ChatbotsInput,
            SystemOut).