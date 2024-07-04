#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Wed Jun 19 04:17:59 2024
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

%:- module(ch02, []).

%%%
%%%    2.11.2
%%%    
add2(X, Y) :-
    Y is X + 2.
add5(X, Y) :-
    Y is X + 5.
double(X, Y) :-
    Y is X * 2.

min_abs(Xs, Y) :-
    abs(Xs, Zs),
    min_list(Zs, Y).

max_abs(Xs, Y) :-
    abs(Xs, Zs),
    max_list(Zs, Y).

abs([], []).
abs([X|Xs], [Y|Ys]) :-
    Y is abs(X),
    abs(Xs, Ys).

min_list([X|Xs], Y) :-
    min_list(Xs, Y, X).
min_list([], X, X).
min_list([X|Xs], Y, X1) :-
    X2 is min(X, X1),
    min_list(Xs, Y, X2).

max_list([X|Xs], Y) :-
    max_list(Xs, Y, X).
max_list([], X, X).
max_list([X|Xs], Y, X1) :-
    X2 is max(X, X1),
    max_list(Xs, Y, X2).

%%%
%%%    2.11.4
%%%
zeller(N, M, C, Y, L, Z) :-
    Z is (N + (13 * M - 1) // 5 + Y + Y // 4 + C // 4 - 2 * C - (1 + L) * (M // 11)) mod 7.

%%%
%%%    2.11.5
%%%
signum(X, 1) :- X > 0, !.
signum(X, -1) :- X < 0, !.
signum(X, 0) :- X =:= 0, !.

%%%
%%%    2021
%%%    
%% signum(X, X) :- X =:= 0, !.
%% signum(X, S) :- S is X / abs(X).

interest_rate(M, IR) :-
    M =< 0,
    !,
    IR is 0.
interest_rate(M, IR) :-
    M < 1000,
    !,
    IR is 2.
interest_rate(M, IR) :-
    M < 10000,
    !,
    IR is 3.
interest_rate(M, IR) :-
    M < 100000,
    !,
    IR is 7.
interest_rate(_, 10).

%%%
%%%    D'oh! 2010
%%%    
%% interest_rate(M, 0) :- M =< 0, !.
%% interest_rate(M, 2) :- M < 1000, !.
%% interest_rate(M, 5) :- M < 10000, !.
%% interest_rate(M, 7) :- M < 100000, !.
%% interest_rate(_, 10).



%%%
%%%    2.11.7
%%%    
go_to_movie(A, C) :-
    A < 12,
    C > 3.
go_to_movie(A, C) :-
    A >= 12,
    A < 65,
    C > 7.
go_to_movie(A, C) :-
    A >= 65,
    C > 4.5.

%%%
%%%    2.11.10
%%%    
%% floor1(X, F) :-
%%     X >= 0,
%%     F is truncate(X).
%% %% floor1(X, F) :-
%% %%     X < 0,
%% %%     Xm is -X,
%% %%     ceiling(Xm, Fm),
%% %%     F is -Fm.
%% floor1(X, F) :-
%%     X < 0,
%%     F is truncate(X),
%%     F =:= X.
%% floor1(X, F) :-
%%     X < 0,
%%     F1 is truncate(X),
%%     F1 =\= X,
%%     F is F1 - 1.

floor1(X, F) :-
    T is truncate(X),
    floor2(X, T, F).
floor2(X, T, T) :- X >= 0, !.
floor2(X, T, T) :- X =:= T, !.
floor2(_, T, F) :- F is T - 1.

floor1(M, N, F) :-
    X is M / N,
    floor1(X, F).

ceiling1(X, C) :-
    Xm is -X,
    floor1(Xm, Cm),
    C is -Cm.

ceiling1(M, N, C) :-
    X is M / N,
    ceiling1(X, C).

%%%
%%%    2.11.11
%%%
leap_year(Y) :- Y mod 400 =:= 0, !.
leap_year(Y) :-
    Y mod 4 =:= 0,
    Y mod 100 =\= 0.

%%%
%%%    2.11.12
%%%
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
