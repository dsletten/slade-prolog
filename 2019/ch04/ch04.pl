#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Sun Sep  8 03:20:44 2019
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

roman(i, 1).
roman(v, 5).
roman(x, 10).
roman(l, 50).
roman(c, 100).
roman(d, 500).
roman(m, 1000).

roman_to_decimal([], 0).
roman_to_decimal([R|[]], D) :-
    roman(R, D).
roman_to_decimal([R1, R2|T], D) :-
    roman(R1, D1),
    roman(R2, D2),
    D1 < D2,
    roman_to_decimal([R2|T], D3),
    D is D3 - D1.
roman_to_decimal([R1, R2|T], D) :-
    roman(R1, D1),
    roman(R2, D2),
    D1 >= D2,
    roman_to_decimal([R2|T], D3),
    D is D3 + D1.

% ?- roman_to_decimal([m, c, m, l, x, x, x, i, v], D).
% D = 1984 ;
% false.

% ?- roman_to_decimal([m, m, v, i, i], D).
% D = 2007 ;
% false.

%%
%%    4.7.3
%%
pluralize(1, S, _, S).
pluralize(N, _, P, P) :-
    N =\= 1.

make_change(0, []).
make_change(Money, [[Money, P]]) :-
    Money > 0,
    Money =< 5,
    pluralize(Money, penny, pennies, P).
make_change(Money, [[Nickels, nickel]|L]) :-
    Money > 5,
    Money =< 10,
    Nickels is Money // 5,
    Remainder is Money rem 5,
    make_change(Remainder, L).
make_change(Money, [[Dimes, D]|L]) :-
    Money > 10,
    Money =< 25,
    Dimes is Money // 10,
    Remainder is Money rem 10,
    pluralize(Dimes, dime, dimes, D),
    make_change(Remainder, L).
make_change(Money, [[Quarters, quarter]|L]) :-
    Money > 25,
    Money =< 50,
    Quarters is Money // 25,
    Remainder is Money rem 25,
    make_change(Remainder, L).
make_change(Money, [[HalfDollars, half_dollar]|L]) :-
    Money > 50,
    Money =< 100,
    HalfDollars is Money // 50,
    Remainder is Money rem 50,
    make_change(Remainder, L).
make_change(Money, [[Dollars, D]|L]) :-
    Money > 100,
    Dollars is Money // 100,
    Remainder is Money rem 100,
    pluralize(Dollars, dollar, dollars, D),
    make_change(Remainder, L).

%%
%%    4.7.4
%%
pluralize1(1, S, _, S).
pluralize1(N, _, P, P) :-
    N =\= 1.
pluralize1(1, S, S).
pluralize1(N, P, P1) :-
    N =\= 1,
    atom_concat(P, s, P1).

make_us_change(Money, Change) :-
    UsCurrencyList = [[100, dollar], [50, half_dollar], [25, quarter], [10, dime], [5, nickel], [1, penny, pennies]],
    make_change(Money, UsCurrencyList, Change).
make_change(0, _, []).
make_change(Money, [[Value, Currency]|CurrencyTail], [[M, P]|L]) :-
    Money >= Value,
    M is Money // Value,
    N is Money rem Value,
    pluralize1(M, Currency, P),
    make_change(N, CurrencyTail, L).
make_change(Money, [[Value, Currency, Plural]|CurrencyTail], [[M, P]|L]) :-
    Money >= Value,
    M is Money // Value,
    N is Money rem Value,
    pluralize1(M, Currency, Plural, P),
    make_change(N, CurrencyTail, L).
make_change(Money, [[Value, _]|CurrencyTail], L) :-
    Money < Value,
    make_change(Money, CurrencyTail, L).
make_change(Money, [[Value, _, _]|CurrencyTail], L) :-
    Money < Value,
    make_change(Money, CurrencyTail, L).

%%
%%    4.7.10
%%

credit(X) :-
    number(X),
    X > 0.

debit(X) :-
    number(X),
    X < 0.

interest_rate([X|[]]) :-
    number(X).

rate(I, R) :-
    interest_rate(I),
    I = [R].

check_book(B, [], B).
check_book(B, [T|Ts], B2) :-
    credit(T),
    B1 is B + T,
    check_book(B1, Ts, B2).
check_book(B, [T|Ts], B2) :-
    debit(T),
    B1 is B + T,
    check_book(B1, Ts, B2).
check_book(B, [T|Ts], B2) :-
    interest_rate(T),
    rate(T, R),
    B1 is B * R,
    check_book(B1, Ts, B2).

% ?- check_book(100, [100, 50, -75], B).
% B = 175 ;
% false.

% ?- check_book(100, [-17.5, -1.73, -7.5], B).
% B = 73.27 ;
% false.

% ?- check_book(100, [100, 50, -50, [1.1]], B).
% B = 220.00000000000003 ;
% false.

% ?- check_book(100, [[1.1], 100, 50, -50, [1.1]], B).
% B = 231.00000000000003 ;
% false.

%%
%%    4.7.11
%%
now_account_minimum(500).
penalty(0.1).

now_account(B, [], B).
now_account(B, [T|Ts], B2) :-
    credit(T),
    B1 is B + T,
    now_account(B1, Ts, B2).
now_account(B, [T|Ts], B2) :-
    debit(T),
    now_account_minimum(Min),
    B < Min,
    penalty(P),
    B1 is B + T - P,
    now_account(B1, Ts, B2).
now_account(B, [T|Ts], B2) :-
    debit(T),
    now_account_minimum(Min),
    B >= Min,
    B1 is B + T,
    now_account(B1, Ts, B2).
now_account(B, [T|Ts], B2) :-
    interest_rate(T),
    now_account_minimum(Min),
    B < Min,
    now_account(B, Ts, B2).
now_account(B, [T|Ts], B2) :-
    interest_rate(T),
    now_account_minimum(Min),
    B >= Min,
    rate(T, R),
    B1 is B * R,
    now_account(B1, Ts, B2).

% ?- now_account(100, [100, 50, -50, [1.1]], B).
% B = 199.9 ;
% false.

% ?- now_account(500, [100, 50, -50, [1.1]], B).
% B = 660.0 ;
% false.

%%
%%    4.7.12
%%

%%
%%   5 cases:
%%   1. PATTERN is '()
%%   2. PATTERN has wild first elt.
%%      2a. INPUT is '(). (Any remaining elts in PATTERN must be wild for match to succeed, i.e.,
%%          eventually case 1. Otherwise, eventually case 3.)
%%      2b. 1+ elts in INPUT match wildcard . Try to match wildcard against elts of INPUT.
%%      2c. 0 elts in INPUT match wildcard. Try to match rest of PATTERN.
%%   The remaining cases invovle a PATTERN with a literal first elt.
%%   3. PATTERN is neither empty nor has a wild first elt. An empty INPUT list has nothing to
%%      match the first elt of PATTERN, thus the match fails. This case would be eliminated by
%%      case 4. except in the pathological case where pattern contains NIL (the empty list)
%%      as an elt. We must distinguish an empty INPUT rather than match (FIRST '()) w/
%%      (FIRST '(() ...)).
%%   Neither PATTERN nor INPUT is empty below.
%%   4. PATTERN has literal first elt that matches first elt of INPUT. Keep checking.
%%   5. PATTERN has literal first elt that does not match first elt of INPUT. Fail.
%%
%%   Note: 2a. must be handled independently of 2c., otherwise
%%         2a. will mistakenly fall through to 2b. and into an
%%         infinite loop.
%%
%%         Specifically, (match? '(*wild* a) '()) must fail at 2a. not allowed to reach 2b.
%%
wildcard(wild).

match([], []).
match([W|T], []) :-
    wildcard(W),
    match(T, []).
match([W|T], [_|I]) :-
    wildcard(W),
    match([W|T], I).
match([W|T], I) :-
    wildcard(W),
    I \= [],
    match(T, I).
match([X|T1], [X|T2]) :-
    wildcard(W),
    W \= X,
    match(T1, T2).

%%
%%    Master test suite. Culled from all implementations (190824)
%%    

% match([a, b, c], [a, b, c]).
% match([a, b, c], [a, b, c, d]). % Fail
% match([a, b, c, d], [a, b, c]). % Fail
% match([a, wild], [a, b, c]).
% match([a, wild], [a]).
% match([a, wild, b], [a, b, c, d, b]).
% match([a, wild, b], [a, b, c, d, e]). % Fail
% match([wild, b, wild], [a, b, c, d, e]).
% match([wild], [a, b, c]).
% match([a, b, wild, c, d], [a, b, c, d]).
% match([a, b, []], [a, b]). % Fail
% match([wild], []).
% match([wild, wild], []).
% match([i, do, not, like, wild, coach, because, he, wild, all, of, the, time, which, is, wild],
%       [i, do, not, like, my, crazy, coach, because, he, likes, to, tell, bad, jokes, all, of, the, time, which, is, very, annoying, to, me]).
% match([wild, a, wild], [b, c, a, d]).
% %%    Interesting results!
% match([a, b, wild, c, d, wild], [a, b, c, d, c, d, c, d]).
% match([wild, a, wild, a], [a, a, a, a, a, a, a]).
% match([wild, a, wild, a, wild], [a, a, a, a, a, a, a, b, c, d]).

%%
%%    4.7.13
%%
count_occurrences(_, [], 0).
count_occurrences(X, X, 1).
count_occurrences(X, Y, 0) :-
    X \= Y,
    Y \= [],
    Y \= [_|_].
count_occurrences(X, [H|T], N) :-
    count_occurrences(X, H, N1),
    count_occurrences(X, T, N2),
    N is N1 + N2.

% ?- count_occurrences(a, [a, [[a, b]], d, c, [a]], N).
% N = 3 ;
% false.

% ?- count_occurrences(z, [a, [[a, b]], d, c, [a]], N).
% N = 0 ;
% false.

%%
%%    4.7.14
%%
%%    This is different than Slade's exercise!
%%    
tree_sum(L, S) :-
    tree_sum(L, S, 0).
tree_sum([], S, S).
tree_sum(X, S, S1) :-
    number(X),
    S is S1 + X.
tree_sum([H|T], S, S1) :-
    tree_sum(H, S2, S1),
    tree_sum(T, S, S2).

% ?- tree_sum([5, 4, 3, 2, 1], S).
% S = 15 ;
% false.

% ?- tree_sum([1, 2, [3, [4, [5], 6], [7]], 8, [9]], S).
% S = 45 ;
% false.

% ?- tree_sum([[[[[1]]]]], S).
% S = 1 ;
% false.

tree_addition([], _, []).
tree_addition(X, N, S) :-
    number(X),
    S is X + N.
tree_addition([H|T], N, [H1|T1]) :-
    tree_addition(H, N, H1),
    tree_addition(T, N, T1).

% ?- tree_addition([5, 4, 3, 2, 1], 2, L).
% L = [7, 6, 5, 4, 3] ;
% false.

% ?- tree_addition([1, 2, [3, [4, [5], 6], [7]], 8, [9]], 3, L).
% L = [4, 5, [6, [7, [8], 9], [10]], 11, [12]] ;
% false.

% ?- tree_addition([[[[[1]]]]], 5, L).
% L = [[[[[6]]]]] ;
% false.

%%
%%    4.7.15
%%
tree_average([], 0).
tree_average(L, A) :-
    tree_average(L, S, C, 0, 0),
    A is S / C.
tree_average([], S, C, S, C).
tree_average(X, S, C, S1, C1) :-
    number(X),
    S is S1 + X,
    C is C1 + 1.
tree_average([H|T], S, C, S1, C1) :-
    tree_average(H, S2, C2, S1, C1),
    tree_average(T, S, C, S2, C2).

% ?- tree_average([1, 2, [3, [4, [5], 6], [7]], 8, [9]], A).
% A = 5 ;
% false.

% ?- tree_average([[[[[1]]]]], A).
% A = 1 ;
% false.
