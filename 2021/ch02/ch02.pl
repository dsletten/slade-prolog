#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Wed Mar 10 19:37:40 2021
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
%%%    2.11.2
%%%    
add2(X, Y) :- Y is X + 2.


%% ?- add2(3, Y).
%% Y = 5.

%% ?- add2(3, 6).
%% false.

%% ?- add2(0, 2).
%% true.

add5(X, Y) :- Y is X + 5.

double(X, Y) :- Y is 2 * X.


%% ?- double(pi, Y).
%% Y = 6.283185307179586.

%% ?- add5(3, Y), double(Y, Z).
%% Y = 8,
%% Z = 16.

min_abs4(A, B, C, D, M) :- Aa is abs(A),
                           Ba is abs(B),
                           Ca is abs(C),
                           Da is abs(D),
                           M1 is min(Aa, Ba),
                           M2 is min(Ca, Da),
                           M is min(M1, M2).

%% ?- min_abs4(3, 5, -2, -8, M).
%% M = 2.

max_abs4(A, B, C, D, M) :- Aa is abs(A),
                           Ba is abs(B),
                           Ca is abs(C),
                           Da is abs(D),
                           M1 is max(Aa, Ba),
                           M2 is max(Ca, Da),
                           M is max(M1, M2).

%% ?- max_abs4(3, 5, -2, -8, M).
%% M = 8.

%%%
%%%    2.11.4
%%%
%zeller(N, M , C, Y, L, Z) :- Z is (N + floor((13 * M - 1) / 5) + Y + floor(Y / 4) + floor(C / 4) - 2 * C - (L + 1) * floor(M / 11) mod 7.

zeller(N, M , C, Y, L, Z) :- Z is (N + (13 * M - 1) div 5 + Y + Y div 4 + C div 4 - 2 * C - (1 + L) * (M div 11)) mod 7.

%% zeller(24, 12, 19, 96, 1, 6).
%% zeller(16, 5, 19, 99, 0, 5).
%% zeller(1, 7, 19, 96, 1, 0).
%% zeller(2, 7, 19, 96, 1, 1).
%% zeller(3, 7, 19, 96, 1, 2).
%% zeller(10, 1, 20, 21, 0, 3).    

%%%
%%%    2.11.5
%%%

%% interest_rate(M, 2) :- M > 0, M < 1000.
%% interest_rate(M, 5) :- M >= 1000, M < 10000.
%% interest_rate(M, 7) :- M >= 10000, M < 100000.
%% interest_rate(M, 10) :- M >= 100000.


%% ?- interest_rate(0, I).
%% false.

%% ?- interest_rate(1, I).
%% I = 2 ;
%% false.

%% ?- interest_rate(999, I).
%% I = 2 ;
%% false.

%% ?- interest_rate(1000, I).
%% I = 5 ;
%% false.

%% ?- interest_rate(9999, I).
%% I = 5 ;
%% false.

%% ?- interest_rate(10000, I).
%% I = 7 ;
%% false.

%% ?- interest_rate(99999, I).
%% I = 7 ;
%% false.

%% ?- interest_rate(100000, I).
%% I = 10.

%% ?- interest_rate(1000000, I).
%% I = 10.

%%%    Negative value?!
interest_rate(0, 0) :- !.
interest_rate(M, 2) :- M < 1000, !.
interest_rate(M, 5) :- M < 10000, !.
interest_rate(M, 7) :- M < 100000, !.
interest_rate(_, 10).


%% ?- interest_rate(0, I).
%% I = 0.

%% ?- interest_rate(1, I).
%% I = 2.

%% ?- interest_rate(999, I).
%% I = 2.

%% ?- interest_rate(1000, I).
%% I = 5.

%% ?- interest_rate(9999, I).
%% I = 5.

%% ?- interest_rate(10000, I).
%% I = 7.

%% ?- interest_rate(99999, I).
%% I = 7.

%% ?- interest_rate(100000, I).
%% I = 10.

%% ?- interest_rate(1000000, I).
%% I = 10.

signum(X, X) :- X =:= 0, !.
signum(X, S) :- S is X / abs(X).


%% ?- signum(0, S).
%% S = 0.

%% ?- signum(0.0, S).
%% S = 0.0.

%% ?- signum(1, S).
%% S = 1.

%% ?- signum(1.0, S).
%% S = 1.0.

%% ?- signum(-1, S).
%% S = -1.

%% ?- signum(-1.0, S).
%% S = -1.0.

%% ?- signum(pi, S).
%% S = 1.0.

%% ?- signum(-pi, S).
%% S = -1.0.

%% ?- signum(99, S).
%% S = 1.

%% ?- signum(-99, S).
%% S = -1.

%% ?- signum(-99, -1).
%% true.

%% ?- signum(-99, -1.0).
%% false.

go_to_movie(A, C) :- A < 12,
                     C >= 3.
go_to_movie(A, C) :- A >= 12,
                     A < 65,
                     C >= 7.
go_to_movie(A, C) :- A >= 65,
                     C >= 4.5.

%%%
%%%    2.11.10
%%%
%% floor1(X, F) :- X >= 0, !,
%%                 F is truncate(X).
%% floor1(X, F) :- X < 0,
%%                 Y is float_fractional_part(X),
%%                 Y =:= 0, !,
%%                 F is -truncate(-X).
%% floor1(X, F) :- X < 0,
%%                 Y is float_fractional_part(X),
%%                 Y =\= 0,
%%                 F is -truncate(-X) - 1.

floor1(X, F) :- X >= 0, !,
                F is truncate(X).
floor1(X, F) :- X < 0,
                float_fractional_part(X) =:= 0, !,
                F is -truncate(-X).
floor1(X, F) :- X < 0,
                F is -truncate(-X) - 1.

ceiling1(X, C) :- X1 is -X,
                  floor1(X1, F),
                  C is -F.

%%%
%%%    2.11.11
%%%
leap_year(Y) :- 0 is Y mod 100, !,
                0 is Y mod 400.
leap_year(Y) :- 0 is Y mod 4.

%%%
%%%    Exercism: https://exercism.org/tracks/prolog/exercises/leap
%%%
leap(Y) :-
  Y mod 100 =:= 0,
  Y mod 400 =:= 0.
leap(Y) :-
  Y mod 100 =\= 0,
  Y mod 4 =:= 0.

%%%
%%%    2.11.12
%%%
son_of_zeller(D, M, Y, Z) :- leap_year(Y), !,
                             zeller(D, M, Y // 100, Y mod 100, 1, Z).
son_of_zeller(D, M, Y, Z) :- zeller(D, M, Y // 100, Y mod 100, 0, Z).


%% ?- son_of_zeller(24, 12, 1996, Z).
%% Z = 6.

%% ?- son_of_zeller(16, 5, 1999, Z).
%% Z = 5.

%% ?- son_of_zeller(1, 7, 1996, Z).
%% Z = 0.

%% ?- son_of_zeller(2, 7, 1996, Z).
%% Z = 1.

%% ?- son_of_zeller(3, 7, 1996, Z).
%% Z = 2.
