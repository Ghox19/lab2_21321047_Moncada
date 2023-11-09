:- use_module(option_21321047_MoncadaSanchez).
:- use_module(common_21321047_MoncadaSanchez).
:- use_module(flow_21321047_MoncadaSanchez).
:- use_module(chatbot_21321047_MoncadaSanchez).
:- use_module(system_21321047_MoncadaSanchez).
:- use_module(user_21321047_MoncadaSanchez).

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
    maplist(getOptionCode, Option, OptionID_List),
    eliminarRepetidos(OptionID_List, OptionId_Clean),
    getFlowOptionsClean(OptionId_Clean, Option, Option_Clean),
    mFlow(Id, Name_msg, Option_Clean, Flow).

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
    maplist(getFlowId, Flows, FlowId_List),
    eliminarRepetidos(FlowId_List, FlowId_Clean),
    getChatbotFlowsClean(FlowId_Clean, Flows, Flow_Clean),
    mChatbot(ChatbotID, Name, WelcomeMessage, StartFlowId, Flow_Clean, Chatbot).

%Descripcion: Predicado que añade un Flow a un Chatbot.
%Dominio: chatbot X flow X chatbot.
%Metodo: Ninguno.
%Metas primarias: chatbotAddFlow/3.
%Metas secundarias: getChatbotFlows/2, maplist/3, getFlowId/2, member/2, addToEnd/3, mChatbot/6.
chatbotAddFlow(ChatbotIn, Flow, ChatbotOut):-
    getChatbotFlows(ChatbotIn, Chatbot_Flows),
    maplist(getFlowId, Chatbot_Flows, Chatbot_Id_Flows),
    getFlowId(Flow, Flow_ID),
    \+ member(Flow_ID, Chatbot_Id_Flows),
    addToEnd(Flow, Chatbot_Flows, NewChatbot_Flows),
    mChatbot(IdInput, NameInput, WelcomeMessageInput, StartFlowIdInput, _, ChatbotIn),
    mChatbot(IdInput, NameInput, WelcomeMessageInput, StartFlowIdInput, NewChatbot_Flows, ChatbotOut).

%Descripcion: Predicado que crea un System.
%Dominio: name (string) X InitialChatbotCodeLink (Int) X chatbots (Lista de 0 o más chatbots) X system
%Metodo: Recursion de Cola en el predicado "EliminarRepetidos", "getSystemChatbotsClean" y "getChatbotInitialFlowIdById".
%Metas primarias: system/4.
%Metas secundarias: getChatbotId/2, maplist/3, eliminarRepetidos/2, getSystemChatbotsClean/3, getChatbotInitialFlowIdById/3, mSystem/9.
system(Name, InitialChatbotCodeLink, Chatbot, System):-
    maplist(getChatbotId, Chatbot, ChatbotID_List),
    eliminarRepetidos(ChatbotID_List, ChatbotId_Clean),
    getSystemChatbotsClean(ChatbotId_Clean, Chatbot, Chatbot_Clean),
    getChatbotInitialFlowIdById(InitialChatbotCodeLink, Chatbot_Clean, ActualFlowCodeLink),
    mSystem(Name, 
            [], 
            [], 
            [], 
            InitialChatbotCodeLink, 
            InitialChatbotCodeLink, 
            ActualFlowCodeLink, 
            Chatbot_Clean, 
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
systemAddChatbot(SystemIn, _, SystemIn).

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
%Dominio: SystemIn X User X SystemOut.
%Metodo: Ninguno.
%Metas primarias: systemLogin/3.
%Metas secundarias: getSystemUsers/2, member/2, isLogedUser/1, setSystemNewLogedUser/3.
systemLogin(SystemIn, User, SystemOut):-
    getSystemUsers(SystemIn, Users_List),
    member(User, Users_List),   
    isLogedUser(SystemIn),
    setSystemNewLogedUser(SystemIn, [User], SystemOut).