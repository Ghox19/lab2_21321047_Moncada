:- module(option_21321047_MoncadaSanchez, [mOption/6]).

%Descripcion: Predicado creador de una opcion
%Dominio: code (Int)  X message (String)  X ChatbotCodeLink (Int) X InitialFlowCodeLink (Int) X Keyword (lista de 0 o más palabras claves) X Option (list)
%Metas primarias: mOption.
%Metas secundarias: ninguna.
mOption(Code, Message, Codelink, InitialFlowCodeLink, Keywords, 
    [Code, Message, Codelink, InitialFlowCodeLink, Keywords]).