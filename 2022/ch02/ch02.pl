#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Sun Oct  2 21:42:22 2022
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
add2(X, Y) :- Y is X + 2.
add5(X, Y) :- Y is X + 5.
double(X, Y) :- Y is X * 2.
min_abs4(A, B, C, D, X) :-
    absolute([A, B, C, D], L),
    minimum(L, X).
max_abs4(A, B, C, D, X) :-
    absolute([A, B, C, D], L),
    maximum(L, X).

absolute([], []).
absolute([X|Xs], [Y|Ys]) :-
    Y is abs(X),
    absolute(Xs, Ys).

minimum([X|Xs], M) :-
    minimum(Xs, X, M).
minimum([], M, M).
minimum([X|Xs], Acc, M) :-
    X < Acc,
    minimum(Xs, X, M).
minimum([X|Xs], Acc, M) :-
    X >= Acc,
    minimum(Xs, Acc, M).

maximum([X|Xs], M) :-
    maximum(Xs, X, M).
maximum([], M, M).
maximum([X|Xs], Acc, M) :-
    X > Acc,
    maximum(Xs, X, M).
maximum([X|Xs], Acc, M) :-
    X =< Acc,
    maximum(Xs, Acc, M).

%% ?- add2(5, X).
%% X = 7.

%% ?- add5(5, X).
%% X = 10.

%% ?- double(7, X).
%% X = 14.

%% ?- minimum([1], M).
%% M = 1.

%% ?- minimum([], M).
%% false.

%% ?- minimum([1, 2, 3], M).
%% M = 1.

%% ?- minimum([1, 2, -1, 3], M).
%% M = -1 ;
%% false.

%% ?- min_abs4(3, 5, -2, -8, M).
%% M = 2 ;
%% false.

%% ?- max_abs4(3, 5, -2, -8, M).
%% M = 8 ;
%% false.

%% ?- add2(5, X).
%% X = 7.

%% ?- add2(-12, X).
%% X = -10.

%% ?- add2(0.4, X).
%% X = 2.4.

%% ?- add5(5, X).
%% X = 10.

%% ?- add5(-12, X).
%% X = -7.

%% ?- add5(0.4, X).
%% X = 5.4.

%% ?- double(5, X).
%% X = 10.

%% ?- double(-12, X).
%% X = -24.

%% ?- double(0.4, X).
%% X = 0.8.

%%%
%%%    2.11.3
%%%
ajoutez(X, Y, Z) :-
    Z is X + Y.
retranchez(X, Y, Z) :-
    Z is X - Y.
hochstmas(X, Y, M) :-
    M is max(X, Y).
multiplizieren(X, Y, Z) :-
    Z is X * Y.
njia_ya_kutokea :-
    halt.

%% ?- ajoutez(2, 5, X).
%% X = 7.

%% ?- retranchez(7, 2, X).
%% X = 5.

%% ?- hochstmas(4, 7, M).
%% M = 7.

%% ?- multiplizieren(5, 3, X).
%% X = 15.

%%%
%%%    2.11.4
%%%
zeller(N, M, C, Y, L, Z) :-
    Z is (N + (13 * M - 1) div 5 + Y + Y div 4 + C div 4 - 2 * C - (1 + L) * (M div 11)) mod 7.

%%%
%%%    2.11.5
%%%
%% signum(X, 1) :- X > 0.
%% signum(X, -1) :- X < 0.
%% signum(0, 0).
%% signum(0.0, 0).

signum(X, X) :- X =:= 0.
signum(X, S) :- X =\=0, S is X / abs(X).

%%%
%%%    Same as SBCL
%%%    
%% ?- signum(-0.0, S).
%% S = -0.0 ;

%% ????
%% ?- X = 2, signum(-X, S). <- Input to signum is -(2) (Compound term not number)
%% X = 2,
%% S = -1.

interest_rate(M, 0)  :- M =< 0.
interest_rate(M, 2)  :- M >  0,     M < 1000.
interest_rate(M, 5)  :- M >= 1000,  M < 10000.
interest_rate(M, 7)  :- M >= 10000, M < 100000.
interest_rate(M, 10) :- M >= 100000.

%% ?- interest_rate(99, I).
%% I = 2 ;
%% false.

%% ?- interest_rate(5000000, I).
%% I = 10.

%%%
%%%    2.11.7
%%%
go_to_movies(A, C) :-
    A < 12,
    C > 3.
go_to_movies(A, C) :-
    A >= 12,
    A < 65,
    C > 7.
go_to_movies(A, C) :-
    A >= 65,
    C > 4.5.

%% ?- go_to_movies(8, 4).
%% true ;
%% false.

%% ?- go_to_movies(16, 4).
%% false.

%%%
%%%    2.11.10
%%%
%% floor(X, F) :-
%%     X >= 0,
%%     F is truncate(X).
%% floor(X, F) :-
%%     X < 0,
%%     ceiling(-X, C),
%%     F is -C.

floor(X, F) :-
    T is truncate(X),
    T1 is T - 1,
    floor(X, T, T1, F).
floor(X, T, _, T) :-
    X =:= T.
floor(X, T, _, T) :-
    X =\= T,
    X >= 0.
floor(X, T, T1, T1) :-
    X =\= T,
    X < 0.

floor(X, Y, F) :-
    Z is X / Y,
    floor(Z, F).

%% ceiling(X, C) :-
%%     X < 0,
%%     C is truncate(X).
%% ceiling(X, C) :-
%%     X >= 0,
%%     floor(-X, F),
%%     C is -F.

ceiling(X, C) :-
    T is truncate(X),
    T1 is T + 1,
    ceiling(X, T, T1, C).
ceiling(X, T, _, T) :-
    X =:= T.
ceiling(X, T, _, T) :-
    X =\= T,
    X < 0.
ceiling(X, T, T1, T1) :-
    X =\= T,
    X >= 0.

ceiling(X, Y, C) :-
    Z is X / Y,
    ceiling(Z, C).


f(X, Y) :- type(X, T), write(T), Y is X + 2.
type(X, number) :- number(X).
type(X, compound) :- compound(X).

%%%
%%%    2.11.11
%%%
leap_year(Y) :- Y mod 400 =:= 0.
leap_year(Y) :- Y mod 100 =\= 0, Y mod 4 =:= 0.

%%%
%%%    2.11.12
%%%
%% son_of_zeller(D, M, Y, Z) :-
%%     leap_year(Y),
%%     C is Y // 100,
%%     Y1 is Y mod 100,
%%     zeller(D, M, C, Y1, 1, Z).
%% son_of_zeller(D, M, Y, Z) :-
%%     \+leap_year(Y),
%%     C is Y // 100,
%%     Y1 is Y mod 100,
%%     zeller(D, M, C, Y1, 0, Z).

son_of_zeller(D, M, Y, Z) :-
    leap_year(Y),
    zeller(D, M, Y // 100, Y mod 100, 1, Z).
son_of_zeller(D, M, Y, Z) :-
    \+leap_year(Y),
    zeller(D, M, Y // 100, Y mod 100, 0, Z).

%% ?- son_of_zeller(24, 12, 1996, Z).
%% Z = 6 ;
%% false.

%% ?- son_of_zeller(1, 7, 1996, Z).
%% Z = 0 ;
%% false.

%% ?- son_of_zeller(2, 7, 1996, Z).
%% Z = 1 ;
%% false.

%% ?- son_of_zeller(3, 7, 1996, Z).
%% Z = 2 ;
%% false.

%% ?- son_of_zeller(16, 5, 1999, Z).
%% Z = 5.
