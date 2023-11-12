:- module(chathistory_21321047_MoncadaSanchez, [chathistorymMessage/6, getChatHistoryFechaCreacion/2, 
                                                getChatHistoryFechaCreacion/2, getChatHistoryUser/2, 
                                                getChatHistoryMessage/2, getChatHistoryChatbotId/2,
                                                getChatHistoryFlowId/2]).

%Descripcion: Predicado creador de un mensaje de ChatHistory.
%Dominio: FechaCreacion (float) x User (string) x Message (string) x ChatbotId (int) x FlowId (int) x Message (list).
%Metodo: Ninguno.
%Metas primarias: chathistorymMessage/6.
%Metas secundarias: Ninguna.
chathistorymMessage(FechaCreacion, User, Message, ChatbotId, FlowId, 
    [FechaCreacion, User, Message, ChatbotId, FlowId]).

%Descripcion: Predicado que obtiene una fecha de creacion de un Message de Chathistory.
%Dominio: ChatHistoryMessage (list) x FechaCreacion (float).
%Metodo: Ninguno.
%Metas primarias: getChatHistoryFechaCreacion/2.
%Metas secundarias: chathistorymMessage/6.
getChatHistoryFechaCreacion(ChatHistoryMessage, FechaCreacion):-
    chathistorymMessage(FechaCreacion, _, _, _, _,ChatHistoryMessage).

%Descripcion: Predicado que obtiene un User de un Message de Chathistory.
%Dominio: ChatHistoryMessage (list) x User (string).
%Metodo: Ninguno.
%Metas primarias: getChatHistoryUser/2.
%Metas secundarias: chathistorymMessage/6.
getChatHistoryUser(ChatHistoryMessage, User):-
    chathistorymMessage(_, User, _, _, _,ChatHistoryMessage).

%Descripcion: Predicado que obtiene un Mensaje de un Message de Chathistory.
%Dominio: ChatHistoryMessage (list) x Mensaje (string).
%Metodo: Ninguno.
%Metas primarias: getChatHistoryMessage/2.
%Metas secundarias: chathistorymMessage/6.
getChatHistoryMessage(ChatHistoryMessage, Message):-
    chathistorymMessage(_, _, Message, _, _,ChatHistoryMessage).

%Descripcion: Predicado que obtiene un ChatbotId de un Message de Chathistory.
%Dominio: ChatHistoryMessage (list) x ChatbotId (int).
%Metodo: Ninguno.
%Metas primarias: getChatHistoryChatbotId/2.
%Metas secundarias: chathistorymMessage/6.
getChatHistoryChatbotId(ChatHistoryMessage, ChatbotId):-
    chathistorymMessage(_, _, _, ChatbotId, _,ChatHistoryMessage).

%Descripcion: Predicado que obtiene un FlowId de un Message de Chathistory
%Dominio: ChatHistoryMessage (list) x FlowId (int)
%Metodo: Ninguno.
%Metas primarias: getChatHistoryFlowId/2.
%Metas secundarias: chathistorymMessage/6.
getChatHistoryFlowId(ChatHistoryMessage, FlowId):-
    chathistorymMessage(_, _, _, _, FlowId,ChatHistoryMessage).