%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               ch02.pl
%
%   STARTED:            Tue Sep 14 16:43:07 2010
%   MODIFICATIONS:
%
%   PURPOSE:
%
%
%
%   CALLING SEQUENCE:
%
%
%   INPUTS:
%
%   OUTPUTS:
%
%   EXAMPLE:
%
%   NOTES:
%
%%

square(X, Sq) :- Sq is X * X.
square_sum(X, Y, Z) :-
    square(X, Sqx),
    square(Y, Sqy),
    Z is Sqx + Sqy.

fahrenheit(F, C) :- C is (F - 32) * 5 / 9.
celsius(C, F) :- F is 9 / 5 * C + 32.

zerop(X) :- X =:= 0.
plusp(X) :- X > 0.
minusp(X) :- X < 0.
evenp(X) :- X mod 2 =:= 0.
oddp(X) :- X mod 2 =:= 1.

lcm(X, Y, Z) :-
    Z is X * Y // gcd(X, Y).

%% interest_rate(M, 0) :- M =< 0.
%% interest_rate(M, 2) :-
%%     M > 0,
%%     M < 1000.
%% interest_rate(M, 5) :-
%%     M >= 1000,
%%     M < 10000.
%% interest_rate(M, 7) :-
%%     M >= 10000,
%%     M < 100000.
%% interest_rate(M, 10) :-
%%     M >= 100000.

interest_rate(M, 0) :- M =< 0, !.
interest_rate(M, 2) :- M < 1000, !.
interest_rate(M, 5) :- M < 10000, !.
interest_rate(M, 7) :- M < 100000, !.
interest_rate(_, 10).

go_to_movie(A, M) :- A < 12, M > 3.0.
go_to_movie(A, M) :- A >= 12, A < 65, M > 7.0.
go_to_movie(A, M) :- A >= 65, M > 4.5.

logB(X, B, L) :-
    L is log(X) / log(B).

degrees_to_radians(D, R) :-
    R is D * pi / 180.

sec(Ang, Sec) :- Sec is 1 / cos(Ang).
cosec(Ang, Cosec) :- Cosec is 1 / sin(Ang).
cotan(Ang, Cotan) :- Cotan is 1 / tan(Ang).

%%%
%%%    2.11.2
%%%
add2(X, Y) :- Y is X + 2.
add5(X, Y) :- Y is X + 5.
double(X, Y) :- Y is X * 2.
min_abs4(X1, X2, X3, X4, Y) :-
    Y is min(min(abs(X1), abs(X2)), min(abs(X3), abs(X4))).
max_abs4(X1, X2, X3, X4, Y) :-
    Y is max(max(abs(X1), abs(X2)), max(abs(X3), abs(X4))).

%%%
%%%    2.11.4
%%%
zeller(N, M, C, Y, L, Z) :-
    Z is (N + (13 * M-1) // 5 + Y + Y//4 + C//4 - 2*C - (1+L)*(M//11)) mod 7.

%% zeller(N, M, C, Y, L, Z) :-
%%     Z is (N + floor((13 * M-1) / 5) + Y + floor(Y/4) + floor(C/4) - 2*C -(1+L)*floor(M/11)) mod 7.

%%%
%%%    2.11.11
%%%
%% leap_year(Y) :- Y mod 400 =:= 0.
%% leap_year(Y) :- Y mod 100 =\= 0, Y mod 4 =:= 0.

leap_year(Y) :- Y mod 400 =:= 0, !.
leap_year(Y) :- Y mod 100 =\= 0, Y mod 4 =:= 0.

%%%
%%%    2.11.12
%%%
son_of_zeller(Day, Month, Year, Z) :- leap_year(Year), zeller(Day, Month, Year//100, Year mod 100, 1, Z).
son_of_zeller(Day, Month, Year, Z) :- %leap_year(Year),  Fix this...
    zeller(Day, Month, Year//100, Year mod 100, 0, Z).
