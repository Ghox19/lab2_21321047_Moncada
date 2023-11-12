:- module(user_21321047_MoncadaSanchez, [isLogedUser/1, getUserBySeed/2]).

:- use_module(system_21321047_MoncadaSanchez).

%Descripcion: Predicado que verifica si existe un Usuario Logeado en el System.
%Dominio: System.
%Metodo: Ninguno.
%Metas primarias: isLogedUser/1.
%Metas secundarias: getSystemLogedUser/2.
isLogedUser(System):-
    getSystemLogedUser(System, []).

%Descripcion: Predicado que obtiene un nombre de usuario a base de un numero de Seed
%Dominio: Seed (int) x User (string).
%Metodo: Ninguno.
%Metas primarias: getUserBySeed/2.
%Metas secundarias: number_string/2, atom_concat/3, atom_string/2.
getUserBySeed(Seed, User):-
    number_string(Seed, NumberSeed),
    atom_concat("user", NumberSeed, AtomUser),
    atom_string(AtomUser, User).