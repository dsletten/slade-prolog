#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Tue Mar 16 21:12:11 2021
%   Modifications:
%
%   Purpose:
%
%
%
%   Calling Sequence:
%
%
%   Inputs:
%
%   Outputs:
%
%   Example:
%
%   Notes:
%
%%

%%%
%%%    3.14.4
%%%    
remove_zeros([], []).
remove_zeros([0|T1], T2) :- remove_zeros(T1, T2).
%%
%%    D'oh!
%%    
%% remove_zeros([H|T1], [H|T2]) :- number(H),
%%                                 H =\= 0,    <-- Only numbers!!!
%%                                 remove_zeros(T1, T2).
%% remove_zeros([H|T1], [H|T2]) :- atom(H), remove_zeros(T1, T2).
remove_zeros([H|T1], [H|T2]) :- H \= 0,
                                remove_zeros(T1, T2).

collect_numbers(H, L, L) :- atom(H).
collect_numbers(H, L, [H|L]) :- number(H).

%% ?- remove_zeros([1, 0, 2, 0, 3], L).
%% L = [1, 2, 3] ;
%% false.

%% ?- remove_zeros([a, b, c, d, e], L).
%% L = [a, b, c, d, e].

%% ?- collect_numbers(1, [2, 3, 4, 5], L).
%% L = [1, 2, 3, 4, 5].

%% ?- collect_numbers(a, [2, 3, 4, 5], L).
%% L = [2, 3, 4, 5] ;
%% false.

verb(is).
verb(am).
verb(are).
verb(have).
verb(has).
verb(go).
verb(went).
verb(gone).

verb_find([], []).
verb_find([W|T1], [W|T2]) :- verb(W), !,
                             verb_find(T1, T2).
verb_find([_|T1], T2) :- verb_find(T1, T2).

%% ?- verb_find([tom, went, to, the, store], L).
%% L = [went].

%% ?- verb_find([tom, went, to, the, store, and, mary, went, to, town], L).
%% L = [went, went].

%% ?- verb_find([have, you, gone, to, the, store], L).
%% L = [have, gone].

%%%
%%%    3.14.5
%%%
proper_list([]).
proper_list([_|T]) :- proper_list(T).

%% ?- proper_list(x).
%% false.

%% ?- proper_list(X).
%% X = [] ;
%% X = [_4006] ;
%% X = [_4006, _4012] ;
%% X = [_4006, _4012, _4018] 

%% ?- proper_list(9).
%% false.

%% ?- proper_list([a, b, c]).
%% true.

%% ?- proper_list([a, b|c]).
%% false.

%%%
%%%    3.14.6
%%%
last_atom([X], X).
last_atom([_|X], X) :- atom(X).
last_atom([_|X], X) :- number(X).
last_atom([_|T], X) :- last_atom(T, X).

%% ?- last_atom([a, b, c], X).
%% X = c ;
%% false.

%% ?- last_atom([a, b|c], X).
%% X = c ;
%% false.

%% ?- last_atom([a, 1, b, 2], X).
%% X = 2 ;
%% false.

%% ?- last_atom([a, 1, b|2], X).
%% X = 2 ;
%% false.

%%%
%%%    3.14.7 (See 2019. Handles optional seed pairlis!)
%%%
%pairlis([], [], []).
%% pairlis([], [_|_], []).
%% pairlis([_|_], [], []).
pairlis([], _, []) :- !.
pairlis(_, [], []) :- !.
pairlis([K|T1], [V|T2], [[K|V]|T3]) :- pairlis(T1, T2, T3).

%% ?- pairlis([a, b, c], [1, 2, 3], P).
%% P = [[a|1], [b|2], [c|3]] ;
%% false.

%% ?- pairlis([a, b, c], [1, 2], P).
%% P = [[a|1], [b|2]] ;
%% false.

%% ?- pairlis([a, b], [1, 2, 3], P).
%% P = [[a|1], [b|2]].

%%%
%%%    3.14.11
%%%
month(january, 11).
month(february, 12).
month(march, 1).
month(april, 2).
month(may, 3).
month(june, 4).
month(july, 5).
month(august, 6).
month(september, 7).
month(october, 8).
month(november, 9).
month(december, 10).

day('sunday', 0).
day('monday', 1).
day('tuesday', 2).
day('wednesday', 3).
day('thursday', 4).
day('friday', 5).
day('saturday', 6).


zeller(N, M , C, Y, L, Z) :- Z is (N + (13 * M - 1) div 5 + Y + Y div 4 + C div 4 - 2 * C - (1 + L) * (M div 11)) mod 7.

leap_year(Y) :- 0 is Y mod 100, !,
                0 is Y mod 400.
leap_year(Y) :- 0 is Y mod 4.

son_of_zeller(D, M, Y, Z) :- leap_year(Y), !,
                             zeller(D, M, Y // 100, Y mod 100, 1, Z).
son_of_zeller(D, M, Y, Z) :- zeller(D, M, Y // 100, Y mod 100, 0, Z).

daughter_of_zeller(Month, D, Y, Dow) :- month(Month, M),
                                        son_of_zeller(D, M, Y, Z),
                                        day(Dow, Z).

%% ?- daughter_of_zeller(september, 1, 1996, D).
%% D = sunday.

%% ?- daughter_of_zeller(february, 24, 1996, D).
%% D = saturday.

%% ?- daughter_of_zeller(july, 16, 1999, D).
%% D = friday.

%% ?- daughter_of_zeller(june, 1, 1996, D).
%% D = saturday.

%% ?- daughter_of_zeller(march, 17, 2021, D).
%% D = wednesday.

