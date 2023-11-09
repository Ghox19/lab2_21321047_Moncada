:- module(user_21321047_MoncadaSanchez, [isLogedUser/1]).

:- use_module(system_21321047_MoncadaSanchez).

isLogedUser(System):-
    getSystemLogedUser(System, []).