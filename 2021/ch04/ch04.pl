#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Thu Mar 18 21:10:59 2021
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
%%%    4.7.1
%%%    
replicate(0, _, []).
replicate(N, X, [X|T]) :- N > 0,
                          N1 is N - 1,
                          replicate(N1, X, T).

%% ?- replicate(5, a, L).
%% L = [a, a, a, a, a] ;
%% false.

%% ?- replicate(0, a, L).
%% L = [] ;
%% false.

%% ?- replicate(-8, a, L).
%% false.

%% fact(0, 1).
%% fact(N, F) :- N > 0,
%%               N1 is N - 1,
%%               fact(N1, F1),
%%               F is N * F1.

%% ?- fact(0, F).
%% F = 1 ;
%% false.

%% ?- fact(1, F).
%% F = 1 ;
%% false.

%% ?- fact(2, F).
%% F = 2 ;
%% false.

%% ?- fact(4, F).
%% F = 24 ;
%% false.

%% ?- fact(6, F).
%% F = 720 ;
%% false.

fact(N, F) :- N >= 0,
              fact(N, F, 1).
fact(0, F, F).
fact(N, F, F1) :- N > 0,
                  N1 is N - 1,    % SWIPL rewrites as: C is A+ -1 !!
                  F2 is N * F1,
                  fact(N1, F, F2).

%% ?- fact(0, F).
%% F = 1 ;
%% false.

%% ?- fact(1, F).
%% F = 1 ;
%% false.

%% ?- fact(2, F).
%% F = 2 ;
%% false.

%% ?- fact(3, F).
%% F = 6 ;
%% false.

%% ?- fact(4, F).
%% F = 24 ;
%% false.

%% ?- fact(6, F).
%% F = 720 ;
%% false.

%%%
%%%    4.7.3
%%%
penny(1, penny) :- !.
penny(M, pennies) :- M =\= 1.

dime(1, dime) :- !.
dime(M, dimes) :- M =\= 1.

dollar(1, dollar) :- !.
dollar(M, dollars) :- M =\= 1.

make_change(0, []) :- !.
make_change(M, [[M, P]]) :-
    M < 5, !,
    penny(M, P).
make_change(M, [[N, nickel]|T]) :-
    M < 10, !,
    N is M // 5,
    M1 is M rem 5,
    make_change(M1, T).
make_change(M, [[N, D]|T]) :-
    M < 25, !,
    N is M // 10,
    M1 is M rem 10,
    dime(N, D),
    make_change(M1, T).
make_change(M, [[N, quarter]|T]) :-
    M < 50, !,
    N is M // 25,
    M1 is M rem 25,
    make_change(M1, T).
make_change(M, [[N, half_dollar]|T]) :-
    M < 100, !,
    N is M // 50,
    M1 is M rem 50,
    make_change(M1, T).
make_change(M, [[N, D]|T]) :-
    N is M // 100,
    M1 is M rem 100,
    dollar(N, D),
    make_change(M1, T).


%% ?- make_change(0, L).
%% L = [].

%% ?- make_change(1, L).
%% L = [[1, penny]].

%% ?- make_change(4, L).
%% L = [[4, pennies]].

%% ?- make_change(6, L).
%% L = [[1, nickel], [1, penny]].

%% ?- make_change(9, L).
%% L = [[1, nickel], [4, pennies]].

%% ?- make_change(21, L).
%% L = [[2, dimes], [1, penny]].

%% ?- make_change(19, L).
%% L = [[1, dime], [1, nickel], [4, pennies]].

%% ?- make_change(11, L).
%% L = [[1, dime], [1, penny]].

%% ?- make_change(16, L).
%% L = [[1, dime], [1, nickel], [1, penny]].

%% ?- make_change(43, L).
%% L = [[1, quarter], [1, dime], [1, nickel], [3, pennies]].

%% ?- make_change(45, L).
%% L = [[1, quarter], [2, dimes]].

%% ?- make_change(46, L).
%% L = [[1, quarter], [2, dimes], [1, penny]].

%% ?- make_change(37, L).
%% L = [[1, quarter], [1, dime], [2, pennies]].

%% ?- make_change(31, L).
%% L = [[1, quarter], [1, nickel], [1, penny]].

%% ?- make_change(88, L).
%% L = [[1, half_dollar], [1, quarter], [1, dime], [3, pennies]].

%% ?- make_change(99, L).
%% L = [[1, half_dollar], [1, quarter], [2, dimes], [4, pennies]].

%% ?- make_change(145, L).
%% L = [[1, dollar], [1, quarter], [2, dimes]].

%% ?- make_change(285, L).
%% L = [[2, dollars], [1, half_dollar], [1, quarter], [1, dime]].

%%%
%%%    4.7.4
%%%    

pluralize([M], 1, M) :- !.
pluralize([M|_], 1, M) :- !.
pluralize([M], _, P) :-
    atom_concat(M, s, P).
pluralize([_, P], _, P).

make_change2(M, L) :-
    make_change(M, [[100, dollar], [50, 'half dollar'], [25, quarter], [10, dime], [5, nickel], [1, penny, pennies]], L).

make_change(0, _, []) :- !.
make_change(M, [[V|C]|T1], [[N, C1]|T2]) :-
    M >= V, !,
    N is M // V,
    M1 is M rem V,
    pluralize(C, N, C1),
    make_change(M1, T1, T2).
make_change(M, [_|T1], T2) :-
    make_change(M, T1, T2).

%% ?- make_change2(0, L).
%% L = [].

%% ?- make_change2(1, L).
%% L = [[1, penny]].

%% ?- make_change2(4, L).
%% L = [[4, pennies]].

%% ?- make_change2(6, L).
%% L = [[1, nickel], [1, penny]].

%% ?- make_change2(9, L).
%% L = [[1, nickel], [4, pennies]].

%% ?- make_change2(21, L).
%% L = [[2, dimes], [1, penny]] ;
%% false.

%% ?- make_change2(19, L).
%% L = [[1, dime], [1, nickel], [4, pennies]].

%% ?- make_change2(11, L).
%% L = [[1, dime], [1, penny]].

%% ?- make_change2(16, L).
%% L = [[1, dime], [1, nickel], [1, penny]].

%% ?- make_change2(43, L).
%% L = [[1, quarter], [1, dime], [1, nickel], [3, pennies]].

%% ?- make_change2(45, L).
%% L = [[1, quarter], [2, dimes]] ;
%% false.

%% ?- make_change2(46, L).
%% L = [[1, quarter], [2, dimes], [1, penny]] ;
%% false.

%% ?- make_change2(37, L).
%% L = [[1, quarter], [1, dime], [2, pennies]].

%% ?- make_change2(31, L).
%% L = [[1, quarter], [1, nickel], [1, penny]].

%% ?- make_change2(88, L).
%% L = [[1, 'half dollar'], [1, quarter], [1, dime], [3, pennies]].

%% ?- make_change2(99, L).
%% L = [[1, 'half dollar'], [1, quarter], [2, dimes], [4, pennies]] ;
%% false.

%% ?- make_change2(145, L).
%% L = [[1, dollar], [1, quarter], [2, dimes]] ;
%% false.

%% ?- make_change2(285, L).
%% L = [[2, dollars], [1, 'half dollar'], [1, quarter], [1, dime]] ;
%% false.

%%%
%%%    4.7.5
%%%
reverse1(L, R) :- revappend(L, [], R).
revappend([], L, L).
revappend([H|T], L2, R) :-
    revappend(T, [H|L2], R).

%%%
%%%    4.7.6
%%%
append1([], L, L).
append1([H|T1], L, [H|T2]) :-
    append1(T1, L, T2).

%%%
%%%    4.7.7
%%%
nth(0, [H|_], H) :- !.
nth(N, [_|T], X) :-
    N1 is N - 1,
    nth(N1, T, X).

%% ?- nth(0, [a, b, c, d], X).
%% X = a.

%% ?- nth(1, [a, b, c, d], X).
%% X = b.

%% ?- nth(2, [a, b, c, d], X).
%% X = c.

%% ?- nth(3, [a, b, c, d], X).
%% X = d.

%% ?- nth(4, [a, b, c, d], X).
%% false.

%%%
%%%    4.7.8
%%%
last1([E], E).
last1([_|T], E) :-
    last1(T, E).

%% ?- last1([a, b, c, d], E).
%% E = d ;
%% false.

%% ?- last1([a], E).
%% E = a ;
%% false.

%% ?- last1([], E).
%% false.

%%%
%%%    4.7.9
%%%    How to do this without cut???
%%%    lists:list_to_set/2
%%%    
remove_duplicates([], []).
remove_duplicates([H|T], L) :-
    member(H, T), !,
    remove_duplicates(T, L).
remove_duplicates([H|T1], [H|T2]) :-
    remove_duplicates(T1, T2).

%% ?- remove_duplicates([a, b, c, d, a, b, f, g], L).
%% L = [c, d, a, b, f, g].

%% ?- remove_duplicates([a, b, c, d, [a, b], f, g], L).
%% L = [a, b, c, d, [a, b], f, g].

%%%
%%%    4.7.10
%%%
credit(X) :-
    number(X),
    X > 0.

debit(X) :-
    number(X),
    X < 0.

interest_rate([X]) :-
    number(X).

rate([X], X).

check_book(B, [], B).
check_book(B, [T1|Ts], B1) :-
    credit(T1),
    B2 is B + T1,
    check_book(B2, Ts, B1).
check_book(B, [T1|Ts], B1) :-
    debit(T1),
    B2 is B + T1,
    check_book(B2, Ts, B1).
check_book(B, [T1|Ts], B1) :-
    interest_rate(T1),
    rate(T1, R),
    B2 is B * R,
    check_book(B2, Ts, B1).


%% ?- check_book(100, [100, 50, -75], B).
%% B = 175 ;
%% false.

%% ?- check_book(100, [-17.50, -1.73, -7.5], B).
%% B = 73.27 ;
%% false.

%% ?- check_book(100, [100, 50, -50, [1.1]], B).
%% B = 220.00000000000003 ;
%% false.

%% ?- check_book(100, [[1.1], 100, 50, -50, [1.1]], B).
%% B = 231.00000000000003 ;
%% false.

%%%
%%%    4.7.11
%%%
below_minimum_balance(B) :- B < 500.
penalty(0.1).

now_account(B, [], B).
now_account(B, [T1|Ts], B1) :-
    credit(T1),
    B2 is B + T1,
    now_account(B2, Ts, B1).
now_account(B, [T1|Ts], B1) :-
    debit(T1),
    below_minimum_balance(B), !,
    penalty(P),
    B2 is B + T1 - P,
    now_account(B2, Ts, B1).
now_account(B, [T1|Ts], B1) :-
    debit(T1),
    B2 is B + T1,
    now_account(B2, Ts, B1).
now_account(B, [T1|Ts], B1) :-
    interest_rate(T1),
    below_minimum_balance(B), !,
    now_account(B, Ts, B1).
now_account(B, [T1|Ts], B1) :-
    interest_rate(T1),
    rate(T1, R),
    B2 is B * R,
    now_account(B2, Ts, B1).

%% ?- now_account(100, [100, 50, -50, [1.1]], B).
%% B = 199.9 ;
%% false.

%% ?- now_account(500, [100, 50, -50, [1.1]], B).
%% B = 660.0 ;
%% false.

%%%
%%%    4.7.12
%%%
match([], []).
match([P|Ps], [P|L]) :-
    match(Ps, L).
match([?|Ps], L) :-
    match(Ps, L).
match([?|Ps], [_|L]) :-
    match([?|Ps], L).

match2([], []).
match2([?|Ps], L) :-
    match2(Ps, L).
match2([?|Ps], [_|L]) :-
    match2([?|Ps], L).
match2([P|Ps], [P|L]) :-
    P \= ?,
    match2(Ps, L).

%%%
%%%    This corresponds to match2/2
%%%    
%% (defun matchp-prolog (pattern target)
%%   (cond ((endp pattern) (endp target))
%%         ((and (wildp (first pattern)) (matchp-prolog (rest pattern) target)))
%%         ((and (wildp (first pattern)) (consp target) (matchp-prolog pattern (rest target))))
%%         ((and (consp target) 
%%               (eq (first pattern) (first target)) 
%%               (matchp-prolog (rest pattern) (rest target))))
%%         (t nil)))

%%%    3 primary cases:
%%%    1. PATTERN is empty. Match simply depends on whether or not TARGET is empty too.
%%%    2. [PATTERN is not empty] - First element of PATTERN is a wild card.
%%%       a. Wild card matches 0 elements. Check rest of PATTERN (TARGET may or may not be empty. Irrelevant here.)
%%%       b. Wild card matches 1+ elements. (TARGET is not empty). Continue checking PATTERN against rest of TARGET.
%%%    3. [PATTERN is not empty. First element is literal.] - TARGET must not be empty, and its first element must
%%%       match the first element of PATTERN. Continue checking rest of each.
%%%    4. No match otherwise.
%%%    

%%%
%%%    A Lispier version of match2/2
%%%    The chief difference is that it is more natural in Prolog to define separate clauses -> separate COND clauses:
%%%    p :- q.
%%%    p :- r.
%%%
%%%    (cond ((and p q))
%%%          ((and p r)) ...)
%%%
%%%    Whereas Lisp is more likely to combine COND clauses:
%%%    (cond (p (or q r)) ...)
%%%    vs.
%%%    p :- q; r.
%%%    

%% (defun matchp-prolog (pattern target)
%%   (cond ((endp pattern) (endp target))
%%         ((wildp (first pattern))
%%          (or (matchp-prolog (rest pattern) target)
%%              (and (consp target) (matchp-prolog pattern (rest target)))) )
%%         ((consp target)
%%          (and (eq (first pattern) (first target)) 
%%               (matchp-prolog (rest pattern) (rest target))))
%%         (t nil)))



%% ?- match([a, b, c], [a, b, c]).
%% true ;
%% false.

%% ?- match([a, b, c], [a, b, c, d]).
%% false.

%% ?- match([a, b, c, d], [a, b, c]).
%% false.

%% ?- match([a, ?], [a, b, c]).
%% true ;
%% false.

%% ?- match([a, ?], [a]).
%% true ;
%% false.

%% ?- match([a, ?, b], [a, b, c, d, b]).
%% true ;
%% false.

%% ?- match([a, ?, b], [a, b, c, d, e]).
%% false.

%% ?- match([?, b, ?], [a, b, c, d, e]).
%% true ;
%% false.

%% ?- match([?], [a, b, c]).
%% true ;
%% false.

%% ?- match([?], []).
%% true ;
%% false.

%% ?- match([?, ?], []).
%% true ;
%% false.

%%%
%%%    4.7.13
%%%    Tree!!!!
%% count_occurrences(X, L, N) :-
%%     count_occurrences(X, L, N, 0).
%% count_occurrences(_, [], N, N).
%% count_occurrences(X, [X|T], N, Acc) :-
%%     Acc1 is Acc + 1,
%%     count_occurrences(X, T, N, Acc1).
%% count_occurrences(X, [Y|T], N, Acc) :-
%%     X \= Y,
%%     count_occurrences(X, T, N, Acc).

count_occurrences(_, [], 0).
count_occurrences(X, X, 1).
count_occurrences(X, Y, 0) :-
    X \= Y,
    Y \= [],
    Y \= [_|_].
count_occurrences(X, [H|T], C) :-
    count_occurrences(X, H, C1),
    count_occurrences(X, T, C2),
    C is C1 + C2.

%% ?- count_occurrences(a, [a, [[a, b]], d, c, [a]], N).
%% N = 3 ;
%% false.

%% ?- count_occurrences(z, [a, [[a, b]], d, c, [a]], N).
%% N = 0 ;
%% false.

%%%
%%%    4.7.14
%%%
%% Messy...
%% tree_add(_, [], []) :- !.
%% tree_add(X, T, Y) :-
%%     T \= [_|_],
%%     Y is X + T.
%% tree_add(X, [H|T1], [Y|T2]) :-
%% %    H \= [_|_],
%%     tree_add(X, H, Y),
%%     tree_add(X, T1, T2).
%% %% tree_add(X, [[H|T]|T1], [[Y|Z]|T2]) :-
%% %%     tree_add(X, H, Y),
%% %%     tree_add(X, T, Z),
%% %%     tree_add(X, T1, T2).

tree_add(_, [], []) :- !.
tree_add(X, [Y|T1], [Z|T2]) :-
    !,
    tree_add(X, Y, Z),
    tree_add(X, T1, T2).
tree_add(X, Y, Z) :- Z is X + Y.

%% ?- tree_add(2, [5, 4, 3, 2, 1], L).
%% L = [7, 6, 5, 4, 3] ;
%% false.

%% ?- tree_add(3, [1, 2, [3, [4, [5], 6], [7]], 8, [9]], L).
%% L = [4, 5, [6, [7, [8], 9], [10]], 11, [12]] ;
%% false.

%% ?- tree_add(5, [[[[[1]]]]], L).
%% L = [[[[[6]]]]] ;
%% false.


%%%
%%%    4.7.15
%%%
tree_average(L, Avg) :-
    tree_average(L, Sum, Count, 0, 0),
    Avg is Sum / Count.

tree_average([], Sum, Count, Sum, Count) :- !.
tree_average([H|T], Sum, Count, S, C) :-
    !,
    tree_average(H, S1, C1, S, C),
    tree_average(T, Sum, Count, S1, C1).
tree_average(X, Sum, Count, S, C) :-
    Sum is S + X,
    Count is C + 1.
