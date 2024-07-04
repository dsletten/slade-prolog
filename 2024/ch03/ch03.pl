#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Thu Jun 20 14:21:06 2024
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

%:- module(ch03, []).

%%%
%%%    3.14.4
%%%    
%% zero(0).
%% zero(0.0).
%% zero(-0.0).

zero(X) :- number(X), X =:= 0.

no_zeros([], []).
no_zeros([H|T], L) :-
    zero(H),
    !,
    no_zeros(T, L).
no_zeros([H|T], [H|L]) :-
    \+zero(H),
    no_zeros(T, L).

collect_numbers(X, L, [X|L]) :- number(X), !.
collect_numbers(_, L, L).

verb(is).
verb(am).
verb(are).
verb(have).
verb(has).
verb(go).
verb(went).
verb(gone).

verb_find([], []).
verb_find([H|T1], [H|T2]) :-
    verb(H),
    !,
    verb_find(T1, T2).
verb_find([_|T1], T2) :-
    verb_find(T1, T2).

%%%
%%%    3.14.5
%%%
proper_list([]).
proper_list([_|T]) :- proper_list(T).

%%%
%%%    3.14.6
%%%
last_atom([X], X) :- !.
last_atom([_|X], X) :- X \= [_|_].
last_atom([_|T], X) :- last_atom(T, X).

%%%
%%%    3.14.7
%%%
pairlis([], _, []) :- !.
pairlis(_, [], []) :- !.
pairlis([K|Ks], [V|Vs], [[K|V]|T]) :-
    pairlis(Ks, Vs, T).

%%%
%%%    3.14.8
%%%
make_person(Name, Age, Weight, Sex, Children, person(Name, Age, Weight, Sex, Children)).
name(person(N, _, _, _, _), N).
age(person(_, A, _, _, _), A).
weight(person(_, _, W, _, _), W).
sex(person(_, _, _, S, _), S).
children(person(_, _, _, _, C), C).

%%%
%%%    3.14.11
%%%
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
month(january, 11).
month(february, 12).

weekday(sunday, 0).
weekday(monday, 1).
weekday(tuesday, 2).
weekday(wednesday, 3).
weekday(thursday, 4).
weekday(friday, 5).
weekday(saturday, 6).

zeller(N, M, C, Y, L, Z) :-
    Z is (N + (13 * M - 1) // 5 + Y + Y // 4 + C // 4 - 2 * C - (1 + L) * (M // 11)) mod 7.

leap_year(Y) :- Y mod 400 =:= 0, !.
leap_year(Y) :-
    Y mod 4 =:= 0,
    Y mod 100 =\= 0.

son_of_zeller(D, M, Y, Z) :-
    leap_year(Y),
    !,
    C is Y // 100,
    Y1 is Y mod 100,
    zeller(D, M, C, Y1, 1, Z).
son_of_zeller(D, M, Y, Z) :-
    C is Y // 100,
    Y1 is Y mod 100,
    zeller(D, M, C, Y1, 0, Z).

daughter_of_zeller(Month, Day, Year, Z) :-
    month(Month, M),
    son_of_zeller(Day, M, Year, Dow),
    weekday(Z, Dow).
