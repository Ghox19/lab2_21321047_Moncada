:- use_module(main_21321047_MoncadaSanchez).
:- use_module(option_21321047_MoncadaSanchez).
:- use_module(common_21321047_MoncadaSanchez).
:- use_module(flow_21321047_MoncadaSanchez).
:- use_module(chatbot_21321047_MoncadaSanchez).
:- use_module(system_21321047_MoncadaSanchez).
:- use_module(user_21321047_MoncadaSanchez).
:- use_module(chathistory_21321047_MoncadaSanchez).

/*
%Script de pruebas Nº1
option(1, "1) Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
% flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
%Chatbot1
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2) París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3) Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4) Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),
%Opciones segundo flujo Chatbot1
option(1, "1) Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2) Museos", 1, 2, ["Museo"], OP8),
option(3, "3) Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4) Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1) Solo", 1, 3, ["Solo"], OP11),
option(2, "2) En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3) En familia", 1, 3, ["Familia"], OP13),
option(4, "4) Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5) En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),
%Chatbot2
option(1, "1) Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2) Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3) Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10),
systemTalkRec(S10, "hola", S11),
systemTalkRec(S11, "1", S12),
systemTalkRec(S12, "1", S13),
systemTalkRec(S13, "Museo", S14),
systemTalkRec(S14, "1", S15),
systemTalkRec(S15, "3", S16),
systemTalkRec(S16, "5", S17),
systemSynthesis(S17, "user2", Str1),
systemSimulate(S3, 5, 32131, S99),
systemSynthesis(S99, "user32131", Str2).
%Para la prueba de el output de Synthesis
write(Str1),
write(Str2).

%PRUEBA DE FUNCIONES
%RF 1 -> option

option(1, "1) Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP01),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP02),
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP03),

%RF 2 -> flow

flow(1, "flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP01], F1),
flow(2, "flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP01, OP02, OP03], F2),
flow(3, "flujo 3 Chatbot1\n¿Vas solo o acompañado?", [], F3),

%RF 3 -> flowAddOption

% flowAddOption(F1, OP01, F4), % si se descomenta da falso porque ya existe
flowAddOption(F3, OP01, F5),    
flowAddOption(F5, OP02, F6), 

%RF 4 -> chatbot

chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F1], CB01),
chatbot(1, "Agencia Viajes", "Bienvenido\n¿Dónde quieres viajar?", 1, [F1, F6], CB02),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F5, F5, F1], CB03),

%RF 5 -> chatbotAddFlow

chatbotAddFlow(CB01, F2, CB04),
chatbotAddFlow(CB04, F3, CB05),
chatbotAddFlow(CB01, F3, CB06),

%RF 6 -> system

system("Chatbots Paradigmas1", 0, [CB01], S01),
system("Chatbots Paradigmas2", 0, [CB01, CB01, CB02], S02),
system("Chatbots Paradigmas3", 0, [CB05, CB06], S03),

%RF 7 -> systemAddChatbot

systemAddChatbot(S01, CB02, S04),
systemAddChatbot(S04, CB03, S05), 
systemAddChatbot(S03, CB02, S06),

%RF 8 -> systemAddUser

systemAddUser(S06, "user1", S07),
systemAddUser(S07, "user2", S08), 
systemAddUser(S08, "user3", S09),

%RF 9 -> systemLogin

systemLogin(S09, "user1", S010),
systemLogin(S09, "user1", S011),
systemLogin(S09, "user2", S012),

%RF 10 -> systemLogout

systemLogout(S012, S013),
%systemLogout(S013, S014),%si se descomenta da false
systemLogin(S013, "user2", S015),
systemLogout(S015, S016),

%RF 11 -> systemTalkRec Este debe ejecutarse luego del script de prueba presentado al inicio, debido a la falta de vinculos

systemTalkRec(S0, "1", S1),
systemTalkRec(S1, "3", S2),
systemTalkRec(S2, "5", S3), 

%RF 12 -> systemSynthesis Este debe ejecutarse luego del script de prueba presentado al inicio, debido a la falta de vinculos
write("\n\nEjemplo RF13 1\n\n"),
systemSynthesis(S1, "user1", Str01),
write(Str01),
write("\n\nEjemplo RF13 2\n\n"),
systemSynthesis(S2, "user1", Str02),
write(Str02),
write("\n\nEjemplo RF13 3\n\n"),
systemSynthesis(S3, "user2", Str03),
write(Str03). 

; RF 13 -> systemSimulate Este debe ejecutarse luego del script de prueba presentado al inicio, debido a la falta de vinculos

write("\n\nEjemplo RF13 1\n\n"),
systemSimulate(S0, 5, 24, S1),
systemSynthesis(S1, "user24", Str01),
write(Str01),
write("\n\nEjemplo RF13 2\n\n"),
systemSimulate(S1, 5, 7246, S2),
systemSynthesis(S2, "user7246", Str02),
write(Str02),
write("\n\nEjemplo RF13 3\n\n"),
systemSimulate(S2, 5, 82345, S3),
systemSynthesis(S3, "user82345", Str03),
write(Str03). 
*/