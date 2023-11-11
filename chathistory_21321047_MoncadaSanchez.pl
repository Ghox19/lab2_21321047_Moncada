:- module(chathistory_21321047_MoncadaSanchez, [chathistorymMessage/6, getChatHistoryFechaCreacion/2, 
                                                getChatHistoryFechaCreacion/2, getChatHistoryUser/2, 
                                                getChatHistoryMessage/2, getChatHistoryChatbotId/2,
                                                getChatHistoryFlowId/2]).

chathistorymMessage(FechaCreacion, User, Message, Chatbot_Id, Flow_Id, 
    [FechaCreacion, User, Message, Chatbot_Id, Flow_Id]).

getChatHistoryFechaCreacion(ChatHistory_Message, FechaCreacion):-
    chathistorymMessage(FechaCreacion, _, _, _, _,ChatHistory_Message).

getChatHistoryUser(ChatHistory_Message, User):-
    chathistorymMessage(_, User, _, _, _,ChatHistory_Message).

getChatHistoryMessage(ChatHistory_Message, Message):-
    chathistorymMessage(_, _, Message, _, _,ChatHistory_Message).

getChatHistoryChatbotId(ChatHistory_Message, Chatbot_Id):-
    chathistorymMessage(_, _, _, Chatbot_Id, _,ChatHistory_Message).

getChatHistoryFlowId(ChatHistory_Message, Flow_Id):-
    chathistorymMessage(_, _, _, _, Flow_Id,ChatHistory_Message).