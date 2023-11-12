:- module(option_21321047_MoncadaSanchez, [mOption/6, getOptionCode/2, getOptionByMessage/3,
                                          getOptionCodelink/2, getOptionMessage/2, getOptionInitialFlowCodeLink/2,
                                          getOptionListFormat/2]).

:- use_module(common_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de una opcion
%Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o más palabras claves) X Option (list)
%Metodo: Ninguno.
%Metas primarias: mOption/6.
%Metas secundarias: ninguna.
mOption(Code, Message, Codelink, InitialFlowCodeLink, Keywords, 
    [Code, Message, Codelink, InitialFlowCodeLink, Keywords]).

%Descripcion: Predicado que obtiene un Code de un Option
%Dominio: Option (list) x Code (int)
%Metodo: Ninguno.
%Metas primarias: getOptionCode/2.
%Metas secundarias: mOption/6.
getOptionCode(Option, Code) :-
    mOption(Code, _, _, _, _, Option).

%Descripcion: Predicado que obtiene un Mensaje de un Option
%Dominio: Option (list) x Message (string)
%Metodo: Ninguno.
%Metas primarias: getOptionMessage/2.
%Metas secundarias: mOption/6.
getOptionMessage(Option, Message) :-
    mOption(_, Message, _, _, _, Option).

%Descripcion: Predicado que obtiene un CodeLink de Chatbot de un Option
%Dominio: Option (list) x Code (int)
%Metodo: Ninguno.
%Metas primarias: getOptionCode/2.
%Metas secundarias: mOption/6.
getOptionCodelink(Option, Codelink) :-
    mOption(_, _, Codelink, _, _, Option).

%Descripcion: Predicado que obtiene un InitialFlowCodeLink de un Option
%Dominio: Option (list) x InitialFlowCodeLink(int)
%Metodo: Ninguno.
%Metas primarias: getOptionInitialFlowCodeLink/2.
%Metas secundarias: mOption/6.
getOptionInitialFlowCodeLink(Option, InitialFlowCodeLink):-
    mOption(_, _, _, InitialFlowCodeLink, _, Option).

%Descripcion: Predicado que obtiene un Code de un Option
%Dominio: Option (list) x Keywords (list)
%Metodo: Ninguno.
%Metas primarias: getOptionKeywords/2.
%Metas secundarias: mOption/6.
getOptionKeywords(Option, Keywords) :-
    mOption(_, _, _, _, Keywords, Option).

%Descripcion: Predicado que obtiene un Option en base a una Id
%Dominio: OptionList (list) x Id (int) x Option
%Metodo: Ninguno.
%Metas primarias: getOptionByMessageId/3.
%Metas secundarias: getOptionCode/2.
getOptionByMessageId([], _, []).
getOptionByMessageId([H | T], Id, Resultado):-
    getOptionCode(H, Id_Option),
    \+ Id_Option = Id,
    getOptionByMessageId(T, Id, Resultado).
getOptionByMessageId([H | _], _, H).

%Descripcion: Predicado que obtiene un Option en base a un Keyword
%Dominio: OptionList (list) x Keyword (string) x Option
%Metodo: Ninguno.
%Metas primarias: getOptionByMessageKeyword/2.
%Metas secundarias: getOptionKeywords/2, downcase_atom/2, downcaseLista/2, member/2.
getOptionByMessageKeyword([], _, []).
getOptionByMessageKeyword([H | T], Keyword, Resultado):-
    getOptionKeywords(H, Keywords_Option),
    downcase_atom(Keyword, L_Keyword),
    downcaseLista(Keywords_Option, L_Keywords_Option),
    \+ member(L_Keyword, L_Keywords_Option),
    getOptionByMessageKeyword(T, Keyword, Resultado).
getOptionByMessageKeyword([H | _], _, H).

%Descripcion: Predicado que obtiene una Option a base de un Message
%Dominio: OptionList (list) x Message (string) x Option
%Metodo: Ninguno.
%Metas primarias: getOptionByMessage/2.
%Metas secundarias: atom_number/2, getOptionByMessageId/3, getOptionByMessageKeyword/3.
getOptionByMessage(OptionList, Message, Option):-
    atom_number(Message, Id),
    getOptionByMessageId(OptionList, Id, Option).
getOptionByMessage(OptionList, Message, Option):-
    getOptionByMessageKeyword(OptionList, Message, Option).

%Descripcion: Predicado que obtiene una Lista de Opciones en formato string.
%Dominio: OptionList (list) x Resultado (string).
%Metodo: Ninguno.
%Metas primarias: getOptionListFormat/2.
%Metas secundarias: maplist/3, getOptionMessage/3.
getOptionListFormat(OptionList, Resultado):-
    maplist(getOptionMessage, OptionList, Resultado).