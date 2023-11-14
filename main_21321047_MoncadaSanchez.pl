:- module(main_21321047_MoncadaSanchez, [option/6, flow/4, flowAddOption/3, chatbot/6, chatbotAddFlow/3,
                                           system/4, systemAddChatbot/3, systemAddUser/3, systemLogin/3,
                                           systemLogout/2, systemTalkRec/3, systemSynthesis/3, systemSimulate/4]).

:- use_module(option_21321047_MoncadaSanchez).
:- use_module(common_21321047_MoncadaSanchez).
:- use_module(flow_21321047_MoncadaSanchez).
:- use_module(chatbot_21321047_MoncadaSanchez).
:- use_module(system_21321047_MoncadaSanchez).
:- use_module(user_21321047_MoncadaSanchez).
:- use_module(chathistory_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de una opcion
%Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o más palabras claves) X Option
%Metodo: Ninguno.
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
    getFlowOptionsClean(Option, [], OptionClean),
    mFlow(Id, Name_msg, OptionClean, Flow).

%Descripcion: Predicado que agrega un Flow a una option.
%Dominio: flow X option X flow.
%Metodo: Recursion de Cola en el predicado addToEnd.
%Metas primarias: flowAddOption/3.
%Metas secundarias: getOptionsFlow/2, maplist/3, getOptionCode/2, member/2, addToEnd/3, mFlow/4.
flowAddOption(FlowIn, Option, FlowOut):-
    getFlowOptions(FlowIn, Flow_Options),
    maplist(getOptionCode, Flow_Options, Flow_ID_Options),
    getOptionCode(Option, Option_ID),
    \+ member(Option_ID, Flow_ID_Options),
    addToEnd(Option, Flow_Options, NewFlow_Options),
    mFlow(IdInput, Name_msgInput, _, FlowIn),
    mFlow(IdInput, Name_msgInput, NewFlow_Options, FlowOut).

%Descripcion: Predicado que crea un Chatbot.
%Dominio: chatbotID (int) X name (String) X welcomeMessage (String) X startFlowId(int) X  flows (Lista de 0 o más flujos) X chatbot
%Metodo: Recursion de Cola en el predicado "EliminarRepetidos" y "getChatbotFlowsClean".
%Metas primarias: chatbot/6.
%Metas secundarias: getFlowId/2, maplist/3, eliminarRepetidos/2, getChatbotFlowsClean/3, mChatbot/6.
chatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flows, Chatbot):-
    getChatbotFlowsClean(Flows, [], FlowClean),
    mChatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, FlowClean, Chatbot).

%Descripcion: Predicado que añade un Flow a un Chatbot.
%Dominio: chatbot X flow X chatbot.
%Metodo: Recursion de Cola en el predicado "addToEnd".
%Metas primarias: chatbotAddFlow/3.
%Metas secundarias: getChatbotFlows/2, maplist/3, getFlowId/2, member/2, addToEnd/3, mChatbot/6.
chatbotAddFlow(ChatbotIn, Flow, ChatbotOut):-
    getChatbotFlows(ChatbotIn, ChatbotFlows),
    maplist(getFlowId, ChatbotFlows, Chatbot_Id_Flows),
    getFlowId(Flow, Flow_ID),
    \+ member(Flow_ID, Chatbot_Id_Flows),
    addToEnd(Flow, ChatbotFlows, NewChatbot_Flows),
    mChatbot(IdInput, NameInput, WelcomeMessageInput, StartFlowIdInput, _, ChatbotIn),
    mChatbot(IdInput, NameInput, WelcomeMessageInput, StartFlowIdInput, NewChatbot_Flows, ChatbotOut).

%Descripcion: Predicado que crea un System.
%Dominio: name (string) X InitialChatbotCodeLink (Int) X chatbots (Lista de 0 o más chatbots) X system
%Metodo: Recursion de Cola en el predicado "EliminarRepetidos", "getSystemChatbotsClean" y "getChatbotInitialFlowIdById".
%Metas primarias: system/4.
%Metas secundarias: getChatbotId/2, maplist/3, eliminarRepetidos/2, getSystemChatbotsClean/3, getChatbotInitialFlowIdById/3, mSystem/9.
system(Name, InitialChatbotCodeLink, Chatbot, System):-
    getSystemChatbotsClean(Chatbot, [], ChatbotClean),
    getChatbotInitialFlowIdById(InitialChatbotCodeLink, ChatbotClean, ActualFlowCodeLink),
    mSystem(Name, 
            [], 
            [], 
            [], 
            InitialChatbotCodeLink, 
            InitialChatbotCodeLink, 
            ActualFlowCodeLink, 
            ChatbotClean, 
            System).

%Descripcion: Predicado que agrega un Chatbot a un System.
%Dominio: SystemIn X Chatbot X SystemOut.
%Metodo: Recursion de Cola en el predicado "addToEnd".
%Metas primarias: systemAddChatbot/3.
%Metas secundarias: getSystemChatbot/2, maplist/3, getChatbotId/2, member/2, addToEnd/3, setSystemNewChatbot/3.
systemAddChatbot(SystemIn, Chatbot, SystemOut):-
    getSystemChatbot(SystemIn, System_Chatbots),
    maplist(getChatbotId, System_Chatbots, System_ID_Chatbots),
    getChatbotId(Chatbot, Chatbot_ID),
    \+ member(Chatbot_ID, System_ID_Chatbots),
    addToEnd(Chatbot, System_Chatbots, NewSystem_Chatbots),
    setSystemNewChatbot(SystemIn, NewSystem_Chatbots, SystemOut).

%Descripcion: Predicado que agrega un Usuario a un System.
%Dominio: SystemIn X User X SystemOut.
%Metodo: Recursion de Cola en el predicado "addToEnd".
%Metas primarias: systemAddUser/3.
%Metas secundarias: getSystemUsers/2, member/2, addToEnd/3, setSystemNewUser/3.
systemAddUser(SystemIn, User, SystemOut):-
    getSystemUsers(SystemIn, Users_List),
    \+ member(User, Users_List),
    addToEnd(User, Users_List, NewUsers_List),
    setSystemNewUser(SystemIn, NewUsers_List, SystemOut).

%Descripcion: Predicado que permite logear un User a un System.
%Dominio: SystemIn X User (string) X SystemOut.
%Metodo: Ninguno.
%Metas primarias: systemLogin/3.
%Metas secundarias: getSystemUsers/2, member/2, isLogedUser/1, setSystemNewLogedUser/3.
systemLogin(SystemIn, User, SystemOut):-
    getSystemUsers(SystemIn, Users_List),
    member(User, Users_List),   
    isLogedUser(SystemIn),
    setSystemNewLogedUser(SystemIn, [User], SystemOut).

%Descripcion: Predicado que permite deslogear un System.
%Dominio: SystemIn X SystemOut.
%Metodo: Recursion de cola en la funcion "getChatbotInitialFlowIdById".
%Metas primarias: systemLogout/3.
%Metas secundarias: isLogedUser/1, getSystemInitialChatbotCodeLink/2, getSystemChatbot/2, 
%                   getChatbotInitialFlowIdById/3, setSystemLogout/5.
systemLogout(SystemIn, SystemOut):-
    \+ isLogedUser(SystemIn),
    getSystemInitialChatbotCodeLink(SystemIn, InitialChatbotCodeLink),
    getSystemChatbot(SystemIn, Chatbot),
    getChatbotInitialFlowIdById(InitialChatbotCodeLink, Chatbot, IntialFlowCodeLink),
    setSystemLogout(SystemIn, [], InitialChatbotCodeLink, IntialFlowCodeLink, SystemOut).

%Descripcion: Predicado que permite interactuar con un System.
%Dominio: system X message (string) X system.
%Metodo: Recursion de cola en la funcion "getSystemOptionByMessage" y "configureAndVerifySystemTalk".
%Metas primarias: systemTalkRec/3.
%Metas secundarias: isLogedUser/1, getSystemOptionByMessage/3, configureAndVerifySystemTalk/4.
systemTalkRec(SystemIn, Message, SystemOut):-
    \+ isLogedUser(SystemIn),
    getSystemOptionByMessage(SystemIn, Message, Option),
    configureAndVerifySystemTalk(SystemIn, Message, Option, SystemOut).

%Descripcion: Predicado que permite obtener un string formateado de las interacciones realizadas en un System de un User
%Dominio: system X User (string) X Message (string).
%Metodo: Recursion de cola en la funcion "concatenarConSaltos".
%Metas primarias: systemSynthesis/3.
%Metas secundarias: getSystemChatHistory/2, getFormatMessages/4, concatenarConSaltos/2.
systemSynthesis(System, User, Message):-
    getSystemChatHistory(System, ChatHistory),
    getFormatMessages(ChatHistory, User, System, FormattedMessages),
    concatenarConSaltos(FormattedMessages, Message).

%Descripcion: Predicado que permite simular un diálogo entre dos chatbots del sistema.
%Dominio: system X MaxInteraccion (int) X Seed (int) X system.
%Metodo: Recursion de cola en la funcion "systemSimulateRec".
%Metas primarias: systemSimulate/3.
%Metas secundarias: systemLogout/2, getUserBySeed/2, systemAddUser/3, systemLogin/3, systemSimulateRec/4.
systemSimulate(SystemIn, MaxInteractions, Seed, SystemOut):-
    getUserBySeed(Seed, UserName),
    systemAddUser(SystemIn, UserName, SystemNewUser),
    systemLogin(SystemNewUser, UserName, SystemSet),
    systemSimulateRec(SystemSet, MaxInteractions, Seed, SystemOut).