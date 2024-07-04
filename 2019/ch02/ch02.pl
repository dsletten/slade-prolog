#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Fri Aug 16 00:13:32 2019
%   Modifications:
%
%   Purpose:
%   Slade ch. 2 exercises
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

%
%    2.11.2
%    
add2(X, Y) :-
    Y is X + 2.
add5(X, Y) :-
    Y is X + 5.
double(X, Y) :-
    Y is X * 2.
absList([], []).
absList([X|T1], [Y|T2]) :-
    Y is abs(X),
    absList(T1, T2).
%
%    2.11.4
%
zeller(N, M, C, Y, L, Z) :-
    Z is (N + (13 * M - 1) div 5 + Y + Y div 4 + C div 4 - 2 * C - (1 + L) * (M div 11)) mod 7.

% zeller(24, 12, 19, 96, 1, 6).
% zeller(16, 5, 19, 99, 0, 5).
% zeller(1, 7, 19, 96, 1, 0).
% zeller(2, 7, 19, 96, 1, 1).
% zeller(3, 7, 19, 96, 1, 2).

%
%    2.11.7
%
goToMovies(Age, Cash) :- Age < 12, Cash > 3.
goToMovies(Age, Cash) :- Age >= 12, Age < 65, Cash > 7.
goToMovies(Age, Cash) :- Age >= 65, Cash > 4.5.

%
%    2.11.10
%
my_floor(X, F) :-
    X < 0,
    X =:= float_integer_part(X),
    X1 is -X,
    F1 is truncate(X1),
    F is -F1.
my_floor(X, F) :-
    X < 0,
    X =\= float_integer_part(X),
    X1 is -X,
    F1 is truncate(X1),
    F is -F1 - 1.
my_floor(X, F) :-
    X >= 0,
    F is truncate(X).

my_ceiling(X, C) :-
    X1 is -X,
    my_floor(X1, F),
    C is -F.

test_floor([]).
test_floor([X|T]) :-
    my_floor(X, F),
    floor(X, F1),
    F =:= F1,
    test_floor(T).

test_ceiling([]).
test_ceiling([X|T]) :-
    my_ceiling(X, C),
    ceiling(X, C1),
    C =:= C1,
    test_ceiling(T).

%test_floor([3.0, 2.9, 2.1, 0.0, -3.0, -2.9, -2.1]).
%test_ceiling([3.0, 2.9, 2.1, 0.0, -3.0, -2.9, -2.1]).

%
%    2.11.11
%
leapYear(Year) :- Year mod 100 =:= 0, Year mod 400 =:= 0.
leapYear(Year) :- Year mod 4 =:= 0, Year mod 100 =\= 0.


% ?- leapYear(2000).
% true ;
% false.

% ?- leapYear(1900).
% false.

% ?- leapYear(2001).
% false.

% ?- leapYear(2002).
% false.

% ?- leapYear(2003).
% false.

% ?- leapYear(2004).
% true.

% ?- leapYear(2100).
% false.

% ?- leapYear(1600).
% true 

%
%    2.11.12
%
sonOfZeller(N, M, Year, Z) :-
    C is Year div 100,
    Y is Year mod 100,
    leapYear(Y),
    zeller(N, M, C, Y, 1, Z).
sonOfZeller(N, M, Year, Z) :-
    C is Year div 100,
    Y is Year mod 100,
    zeller(N, M, C, Y, 0, Z).


% ?- sonOfZeller(24, 12, 1996, Z).
% Z = 6 ;
% Z = 0.      <------- !

% ?- sonOfZeller(16, 5, 1999, Z).
% Z = 5.

% ?- sonOfZeller(1, 7, 1996, Z).
% Z = 0 ;
% Z = 0.

% ?- sonOfZeller(2, 7, 1996, Z).
% Z = 1 

% ?- sonOfZeller(3, 7, 1996, Z).
% Z = 2 ;
% Z = 2.
