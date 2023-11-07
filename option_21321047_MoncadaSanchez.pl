:- module(option_21321047_MoncadaSanchez, [mOption/6, getOptionCode/2]).

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