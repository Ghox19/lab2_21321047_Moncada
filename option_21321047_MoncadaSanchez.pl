:- module(option_21321047_MoncadaSanchez, [mOption/6, getOptionCode/2, getOptionByMessage/3,
                                          getOptionCodelink/2, getOptionMessage/2, getOptionInitialFlowCodeLink/2]).

:- use_module(common_21321047_MoncadaSanchez).

%Descripcion: Predicado creador de una opcion
%Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o más palabras claves) X Option (list)
%Metodo: Ninguno.
%Metas primarias: mOption/6.
%Metas secundarias: ninguna.
mOption(Code, Message, Codelink, InitialFlowCodeLink, Keywords, 
    [Code, Message, Codelink, InitialFlowCodeLink, Keywords]).

%Descripcion: Predicado que obtiene un Code de un Option
%Dominio: Option (list) x Code(int)
%Metodo: Ninguno.
%Metas primarias: getOptionCode/2.
%Metas secundarias: mOption/6.
getOptionCode(Option, Code) :-
    mOption(Code, _, _, _, _, Option).

getOptionMessage(Option, Message) :-
    mOption(_, Message, _, _, _, Option).

getOptionCodelink(Option, Codelink) :-
    mOption(_, _, Codelink, _, _, Option).

getOptionInitialFlowCodeLink(Option, InitialFlowCodeLink):-
    mOption(_, _, _, InitialFlowCodeLink, _, Option).

getOptionKeywords(Option, Keywords) :-
    mOption(_, _, _, _, Keywords, Option).

getOptionByMessageId([], _, []).
getOptionByMessageId([H | T], Id, Resultado):-
    getOptionCode(H, Id_Option),
    \+ Id_Option = Id,
    getOptionByMessageId(T, Id, Resultado).
getOptionByMessageId([H | _], _, H).

getOptionByMessageKeyword([], _, []).
getOptionByMessageKeyword([H | T], Keyword, Resultado):-
    getOptionKeywords(H, Keywords_Option),
    downcase_atom(Keyword, L_Keyword),
    downcaseLista(Keywords_Option, L_Keywords_Option),
    \+ member(L_Keyword, L_Keywords_Option),
    getOptionByMessageKeyword(T, Keyword, Resultado).
getOptionByMessageKeyword([H | _], _, H).

getOptionByMessage(Option_List, Message, Option):-
    atom_number(Message, Number),
    getOptionByMessageId(Option_List, Number, Option).
getOptionByMessage(Option_List, Message, Option):-
    getOptionByMessageKeyword(Option_List, Message, Option).