:- module(system_21321047_MoncadaSanchez, [mSystem/9, getSystemUsers/2, 
                                           getSystemLogedUser/2,getSystemChatbot/2, 
                                           getSystemChatbotsClean/3, setSystemNewChatbot/3, 
                                           setSystemNewUser/3, setSystemNewLogedUser/3,
                                           getSystemOptionByMessage/3, getSystemLogedUserString/2,
                                           getSystemChatHistory/2, setSystemTalk/5, setSystemNoTalk/3,
                                           getSystemActualChatbotCodeLink/2, getSystemActualFlowCodeLink/2,
                                           configureAndVerifySystemTalk/4, getFormatMessages/4,
                                           systemSimulateRec/4, setSystemLogout/5, getSystemInitialChatbotCodeLink/2,
                                           setSystemLogout/5]).

:- use_module(chatbot_21321047_MoncadaSanchez).
:- use_module(flow_21321047_MoncadaSanchez).
:- use_module(option_21321047_MoncadaSanchez).
:- use_module(chathistory_21321047_MoncadaSanchez).
:- use_module(common_21321047_MoncadaSanchez).

%%CONSTRUCTORES%%
%Descripcion: Predicado que crea un System como Lista.
%Dominio: name (string) X Users (list) X LogedUser (list) X ChatHistory (list) X 
%         InitialChatbotCodeLink (Int) X ActualChatbotCodeLink (int) X
%         ActualFlowCodeLink (int) X chatbots X system (list)
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

%%SELECTORES%%
%Descripcion: Predicado que obtiene una lista de Usuarios de un System
%Dominio: System x Users (list)
%Metodo: Ninguno.
%Metas primarias: getSystemUsers/2.
%Metas secundarias: mSystem/9.
getSystemUsers(System, Users):-
    mSystem(_, Users, _, _, _, _, _, _, System).

%Descripcion: Predicado que obtiene una lista del Usuario Logeado de un System
%Dominio: System (list) x User (list)
%Metodo: Ninguno.
%Metas primarias: getSystemLogedUser/2.
%Metas secundarias: mSystem/9.
getSystemLogedUser(System, LogedUser):-
    mSystem(_, _, LogedUser, _, _, _, _, _, System).

%Descripcion: Predicado que obtiene el Usuario Logeado de un System
%Dominio: System x User (string)
%Metodo: Ninguno.
%Metas primarias: getSystemLogedUserString/2.
%Metas secundarias: mSystem/9.
getSystemLogedUserString(System, Loged_User):-
    mSystem(_, _, [Loged_User | _], _, _, _, _, _, System).

%Descripcion: Predicado que obtiene una lista del Mensajes de ChatHistory de un System
%Dominio: System x ChatHistory (list)
%Metodo: Ninguno.
%Metas primarias: getSystemChatHistory/2.
%Metas secundarias: mSystem/9.
getSystemChatHistory(System, ChatHistory):-
    mSystem(_, _, _, ChatHistory, _, _, _, _, System).

%Descripcion: Predicado que obtiene el codigo inicial de un Chatbot de un System
%Dominio: System x InitialChatbotCodeLink (int)
%Metodo: Ninguno.
%Metas primarias: getSystemInitialChatbotCodeLink/2.
%Metas secundarias: mSystem/9.
getSystemInitialChatbotCodeLink(System, InitialChatbotCodeLink):-
    mSystem(_, _, _, _, _, InitialChatbotCodeLink, _, _, System).

%Descripcion: Predicado que obtiene el codigo actual de un Chatbot de un System
%Dominio: System x ActualChatbotCodeLink (int)
%Metodo: Ninguno.
%Metas primarias: getSystemActualChatbotCodeLink/2.
%Metas secundarias: mSystem/9.
getSystemActualChatbotCodeLink(System, ActualChatbotCodeLink):-
    mSystem(_, _, _, _, _, ActualChatbotCodeLink, _, _, System).

%Descripcion: Predicado que obtiene el codigo actual de un Flow de un System
%Dominio: System x ActualFlowCodeLink (int)
%Metodo: Ninguno.
%Metas primarias: getSystemActualFlowCodeLink/2.
%Metas secundarias: mSystem/9.
getSystemActualFlowCodeLink(System, ActualFlowCodeLink):-
    mSystem(_, _, _, _, _, _, ActualFlowCodeLink, _, System).

%Descripcion: Predicado que obtiene una lista de Chatbots de un System
%Dominio: System  x Chatbot (list)
%Metodo: Ninguno.
%Metas primarias: getSystemChatbot/2.
%Metas secundarias: mSystem/9.
getSystemChatbot(System, Chatbot):-
    mSystem(_, _, _, _, _, _, _, Chatbot, System).

%Descripcion: Predicado que obtiene una lista de Chatbots limpia(sin repetidos) a base de lista de id
%Dominio: ListaDeID (list) x ListaDeChatbots (list) x Resultado(list)
%Metodo: Recursion de cola
%Metas primarias: getSystemChatbotsClean/3.
%Metas secundarias: getChatbotId/2.
getSystemChatbotsClean([], Acum, ReverseAcum):-
    reverse(Acum, ReverseAcum).

getSystemChatbotsClean([H | T], Acum, Resultado) :-
    getChatbotId(H, OptionId),
    maplist(getChatbotId, Acum, AcumIds),
    maplist(getChatbotId, T, TIds),
    \+ member(OptionId, AcumIds),
    \+ member(OptionId, TIds),
    addToEnd(H, Acum, NewAcum),
    getSystemChatbotsClean(T, NewAcum, Resultado),
    !.

getSystemChatbotsClean([_ | T], Acum, Resultado) :-
    getSystemChatbotsClean(T, Acum, Resultado).

%Descripcion: Predicado que obtiene un Option a base de un mensaje, realizando la busqueda en el Chatbot actual y su Flow actual.
%Dominio: System x Message (string) x Option
%Metodo: Recursion de cola en las funciones "getChatbotById", "getFlowById" y "getOptionByMessage"
%Metas primarias: getSystemOptionByMessage/3.
%Metas secundarias: getChatbotId/2.
getSystemOptionByMessage(SystemIn, Message, Option) :-
    getSystemChatbot(SystemIn, ChatbotList),
    getSystemActualChatbotCodeLink(SystemIn, ChatbotId),
    getChatbotById(ChatbotList, ChatbotId, Chatbot),
    getChatbotFlows(Chatbot, FlowList),
    getSystemActualFlowCodeLink(SystemIn, FlowId),
    getFlowById(FlowList, FlowId, Flow),
    getFlowOptions(Flow, Options_List),
    getOptionByMessage(Options_List, Message, Option).

%Descripcion: Predicado que obtiene los mensajes formateados del chat History
%Dominio: Messages(list) x User (string) x System x FormattedMessages (string)
%Metodo: Recursion de cola.
%Metas primarias: getFormatMessages/4.
%Metas secundarias: getFormatMessagesAux/5, generateAndFormatMessage/3, append/3.
getFormatMessages(Messages, User, System, FormattedMessages):-
    getFormatMessagesAux(Messages, User, System, FormattedMessages, []).

getFormatMessagesAux([], _, _, FormattedMessages, FormattedMessages).
getFormatMessagesAux([H | T], User, System, FormattedMessages, Acc):-
    generateAndFormatMessage(System, H, FormattedMessage),
    append(Acc, [FormattedMessage], NewAcc),
    getFormatMessagesAux(T, User, System, FormattedMessages, NewAcc).

%%MODIFICADORES%%
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

%Descripcion: Predicado que define un nuevo System con un Usuario Deslogeado
%Dominio: SystemIn x LogedUser (string) x ActualChatbotCodeLink (int) x ActualFlowCodelink (int) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemLogout/3.
%Metas secundarias: mSystem/9.
setSystemLogout(SystemIn, LogedUser, ActualChatbotCodeLink, ActualFlowCodeLink, SystemOut):-
    mSystem(NameInput, 
            Users_ListInput, 
            _, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            _, 
            _,
            System_ChatbotsInput,
            SystemIn),
    mSystem(NameInput, 
            Users_ListInput, 
            LogedUser, 
            ChatHistoryInput, 
            InitialChatbotCodeLinkInput, 
            ActualChatbotCodeLink, 
            ActualFlowCodeLink,
            System_ChatbotsInput,
            SystemOut).

%Descripcion: Predicado que define un nuevo System luego de una interaccion.
%Dominio: SystemIn x ActualChatbotCodeLink (int) x ActualFlowCodeLink (int) x ChatHistory (list) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemTalk/3.
%Metas secundarias: mSystem/9.
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

%Descripcion: Predicado que define un nuevo System con un nuevo ChatHistory
%Dominio: SystemIn x ChatHistory (list) x SystemOut 
%Metodo: Ninguno.
%Metas primarias: setSystemNoTalk/3.
%Metas secundarias: mSystem/9.
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

%%OTRAS FUNCIONES%%
%Descripcion: Predicado que configura y verifica una interaccion a base de la existencia de una opcion posible
%Dominio: SystemIn x Message (string) x Option x SystemOut 
%Metodo: Recursion de cola en la funcion "addToEnd".
%Metas primarias: configureAndVerifySystemTalk/4.
%Metas secundarias: getOptionCodelink/2, getOptionInitialFlowCodeLink/2,
%                  getSystemLogedUserString/2, get_time/1, chathistorymMessage/6,
%                  getSystemChatHistory/2, addToEnd/3, setSystemTalk/5, setSystemNoTalk/3.
configureAndVerifySystemTalk(SystemIn, Message, Option, SystemOut):-
    getOptionCodelink(Option, NewActualChatbotCodeLink),
    getOptionInitialFlowCodeLink(Option, NewActualFlowCodeLink),
    getSystemLogedUserString(SystemIn, User),
    get_time(FechaCreacion),
    chathistorymMessage(FechaCreacion, User, Message, NewActualChatbotCodeLink, NewActualFlowCodeLink, Register),
    getSystemChatHistory(SystemIn, ChatHistory),
    addToEnd(Register, ChatHistory, NewChatHistory),
    setSystemTalk(SystemIn, NewActualChatbotCodeLink, NewActualFlowCodeLink, NewChatHistory, SystemOut).
configureAndVerifySystemTalk(SystemIn, Message, _, SystemOut):-
    getSystemActualChatbotCodeLink(SystemIn, ActualChatbotCodeLink),
    getSystemActualFlowCodeLink(SystemIn, ActualFlowCodeLink),
    getSystemLogedUserString(SystemIn, User),
    getSystemChatHistory(SystemIn, ChatHistory),
    get_time(FechaCreacion),
    chathistorymMessage(FechaCreacion, User, Message, ActualChatbotCodeLink, ActualFlowCodeLink, Register),
    addToEnd(Register, ChatHistory, NewChatHistory),
    setSystemNoTalk(SystemIn, NewChatHistory, SystemOut).

%Descripción: Genera y formatea un mensaje a partir de un mensaje del historial de chat en un System.
%Dominio: System x ChatHistoryMessage (list) x Message (string)
%Meta primaria: generateAndFormatMessage/3
%Metas secundarias: getChatHistoryFechaCreacion/2, getChatHistoryUser/2, getChatHistoryMessage/2,
%                   getChatHistoryChatbotId/2, getSystemChatbot/2, getChatbotById/3, getChatbotName/2,
%                   getChatHistoryFlowId/2, getChatbotFlows/2, getFlowById/3, getFlowNameMsg/2,
%                   getFlowOptions/2, getOptionListFormat/2, concatenarConSaltos/2, atom_concat/2.                   
generateAndFormatMessage(System, ChatHistoryMessage, Message) :-
    getChatHistoryFechaCreacion(ChatHistoryMessage, Numero),
    getChatHistoryUser(ChatHistoryMessage, Usuario),
    getChatHistoryMessage(ChatHistoryMessage, Mensaje),
    getChatHistoryChatbotId(ChatHistoryMessage, ChatbotId),
    getSystemChatbot(System, ChatbotList),
    getChatbotById(ChatbotList, ChatbotId, Chatbot),
    getChatbotName(Chatbot, NombreChatbot),
    getChatHistoryFlowId(ChatHistoryMessage, FlowId),
    getChatbotFlows(Chatbot, FlowList),
    getFlowById(FlowList, FlowId, Flow),
    getFlowNameMsg(Flow, NombreFlujo),
    getFlowOptions(Flow, Option_List),
    getOptionListFormat(Option_List, Option),
    concatenarConSaltos(Option, Opciones),
    atom_concat(Numero, ' - ', Parte1),
    atom_concat(Parte1, Usuario, Parte2),
    atom_concat(Parte2, ': ', Parte3),
    atom_concat(Parte3, Mensaje, Parte4),
    atom_concat(Parte4, '\n', Parte5),
    atom_concat(Parte5, Numero, Parte6),
    atom_concat(Parte6, ' - ', Parte7),
    atom_concat(Parte7, NombreChatbot, Parte8),
    atom_concat(Parte8, ': ', Parte9),
    atom_concat(Parte9, NombreFlujo, Parte10),
    atom_concat(Parte10, '\n', Parte11),
    atom_concat(Parte11, Opciones, Parte12),
    atom_concat(Parte12, '\n', Message).

%Descripcion: Predicado que genera una interaccion con el System sin verificacion de Login
%Dominio: SystemIn x Message (string) x SystemOut 
%Metodo: Recursion de cola en la funcion "getSystemOptionByMessage" y "configureAndVerifySystemTalk".
%Metas primarias: systemTalkRec/3.
%Metas secundarias: getSystemOptionByMessage/3, configureAndVerifySystemTalk/4.
systemTalkRecNoLogin(SystemIn, Message, SystemOut):-
    getSystemOptionByMessage(SystemIn, Message, Option),
    configureAndVerifySystemTalk(SystemIn, Message, Option, SystemOut).

%Descripcion: Predicado que genera un ciclo de interacciones en un System en base a un numero de interacciones y un seed.
%Dominio: SystemIn x MaxInteractions (int) x Seed (int) x SystemOut 
%Metodo: Recursion de cola en la funcion "systemTalkRecNoLogin".
%Metas primarias: systemSimulateRec/3.
%Metas secundarias: number_string/2, systemTalkRecNoLogin/3, myRandom/2.
systemSimulateRec(System, MaxInteractions, Seed, SystemOut):-
    \+ MaxInteractions = 0,
    Residuo is Seed mod 10,
    number_string(Residuo, Eleccion),
    systemTalkRecNoLogin(System, Eleccion, InnerSystem),
    NewMaxInteractions is MaxInteractions - 1,
    myRandom(Seed, NewSeed),
    systemSimulateRec(InnerSystem, NewMaxInteractions, NewSeed, SystemOut).
systemSimulateRec(System, _, _, System).