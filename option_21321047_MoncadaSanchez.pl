:- module(option_21321047_MoncadaSanchez, [mOption/6, getCodeOption/2]).

%Descripcion: Predicado creador de una opcion
%Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o más palabras claves) X Option (list)
%Metodo: No.
%Metas primarias: mOption/6.
%Metas secundarias: ninguna.
mOption(Code, Message, Codelink, InitialFlowCodeLink, Keywords, 
    [Code, Message, Codelink, InitialFlowCodeLink, Keywords]).

%Descripcion: Predicado que obtiene un Code de un Option
%Dominio: Option (list) x Code(int)
%Metodo: No.
%Metas primarias: getCodeOption/2.
%Metas secundarias: mOption/6.
getCodeOption(Option, Code) :-
    mOption(Code, _, _, _, _, Option).