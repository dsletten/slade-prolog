#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Sun Oct 30 03:06:03 2022
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
no_zeroes([], []).
no_zeroes([0|L], L1) :-
    no_zeroes(L, L1).
no_zeroes([X|L], [X|L1]) :-
    X \= 0,
    no_zeroes(L, L1).

%% ?- no_zeroes([1, 0, 2, 0, 3], L).
%% L = [1, 2, 3] ;
%% false.

%% ?- no_zeroes([a, b, c, d, e], L).
%% L = [a, b, c, d, e].

%% ?- no_zeroes([0, 0, 0], []).
%% true ;
%% false.

collect_numbers(X, L, [X|L]) :-
    number(X).
collect_numbers(X, L, L) :-
    \+number(X).

%% ?- collect_numbers(1, [2, 3, 4, 5], L).
%% L = [1, 2, 3, 4, 5] ;
%% false.

%% ?- collect_numbers(a, [2, 3, 4, 5], L).
%% L = [2, 3, 4, 5].

verb(is).
verb(am).
verb(are).
verb(have).
verb(has).
verb(go).
verb(went).
verb(gone).

verb_find([], []).
verb_find([V|T], [V|T1]) :-
    verb(V),
    verb_find(T, T1).
verb_find([X|T], T1) :-
    \+verb(X),
    verb_find(T, T1).

%% ?- verb_find([tom, went, to, the, store], V).
%% V = [went] ;
%% false.

%% ?- verb_find([tom, went, to, the, store, and, mary, went, to, town], V).
%% V = [went, went] ;
%% false.

%% ?- verb_find([have, you, gone, to, the, store], V).
%% V = [have, gone] ;
%% false.

%%%
%%%    3.14.5
%%%
proper_list([]).
proper_list([_|T]) :- proper_list(T).

%% ?- proper_list(x).
%% false.

%% ?- proper_list(9).
%% false.

%% ?- proper_list([a, b, c]).
%% true.

%% ?- proper_list([a, b|c]).
%% false.

%%%
%%%    3.14.6
%%%

%%%
%%%    D'oh!
%%%    
%% ?- atom([]).
%% false.

%% ?- atomic([]).
%% true.

%%%
%%%    This is wrong!
%%%    
last_atom1([X], X).
last_atom1([_|X], X) :-
    X \= [_|_].
last_atom1([_|[_|X]], Y) :-
    last_atom1(X, Y).

%% ?- last_atom1([a, b], A).
%% false.

%last_atom([X|Y], Y) :- atom(Y).
last_atom2([X|Y], X) :- Y = []. % 甲
last_atom2([X|Y], Y) :- Y \= [_|_].
last_atom2([X|Y], Z) :-
    last_atom2(Y, Z).

last_atom3([_|Y], Y) :- atom(Y).
last_atom3([_|Y], Y) :- number(Y). % Necessary 见 2021
last_atom3([X], X).
last_atom3([_|Y], Z) :-
    last_atom3(Y, Z).

last_atom4([X], X). % Same as 甲 above.
last_atom4([_|Y], Y) :-
    Y \= [_|_],
    Y \= [].
last_atom4([_|Y], Z) :-
    last_atom4(Y, Z).

%% ?- last_atom([a, b, c], A).
%% A = c ;
%% false.

%% ?- last_atom([a, b|c], A).
%% A = c ;
%% false.

%% ?- last_atom([[1,2],[3,4]], A).
%% A = [3, 4] ;      % ???????????????????
%% false.

%% ?- last_atom([1, 2, 3], A).
%% A = 3 ;
%% false.

%% ?- last_atom([1, 2|3], A).
%% A = 3 ;
%% false.

%% (defun last-atom (l)
%%   "Return the last atom in the given list argument."
%%   (cond ((atom l) l)
%% 	((null (cdr l)) (car l))
%% 	(t (last-atom (cdr l)))) )

%%%
%%%    This is closest to the Lisp semantics?
%%%
%% ?- last_atom(3, A).
%% A = 3.

%% ?- last_atom([], A).
%% A = [].

last_atom5(X, X) :- atom(X).
last_atom5(X, X) :- number(X).
last_atom5([X|[]], X).
last_atom5([_|Y], X) :-
    last_atom5(Y, X).

last_atom6(X, X) :- \+compound(X).
last_atom6([X|[]], X) :- !.
last_atom6([_|Y], X) :-
    last_atom6(Y, X).

%% ?- last_atom6([a, b, foo(g)], A).
%% A = foo(g).

%% ?- last_atom6([a, b|foo(g)], A).    % ??????????
%% false.

last_atom6a(X, X) :- \+compound(X).
last_atom6a(X, X) :-
    compound(X),
    \+functor(X, '[|]', _).
last_atom6a([X|[]], X) :- !.
last_atom6a([_|Y], X) :-
    last_atom6a(Y, X).

%% (defun last-atom (l)
%%   (cond ((null (cdr l)) (if (atom (car l))
%%                             (car l)
%%                             (last-atom (car l))))
%%         ((atom (cdr l)) (cdr l))
%%         (t (last-atom (cdr l)))) )

%% (deftest test-last-atom ()
%%   (check
%%    (equal (last-atom '(a b c)) 'c)
%%    (equal (last-atom '(1 2 . 3)) 3)
%%    (equal (last-atom '(a b c (d e))) 'e)))




%% (defun last-atom (obj)
%%   (cond ((atom obj) obj)
%%;;         ((atom (cdr obj)) (or (last-atom (cdr obj)) ; NIL pun
%%         ((atom (cdr obj)) (or (cdr obj) ; NIL pun
%%                               (last-atom (car obj))))
%%         (t (last-atom (cdr obj)))) )

%% (deftest test-last-atom ()
%%   (check
%%    (equal (last-atom '(a b c)) 'C)
%%    (equal (last-atom '(a b . c)) 'C)
%%    (equal (last-atom '(a b (c))) 'C)
%%    (equal (last-atom '(a b ((c)))) 'C)))

last_atom7(X, X) :- \+compound(X).
last_atom7([_|Y], X) :-
    \+compound(Y),
    last_atom7(Y, X),
    X \= [].
last_atom7([X|Y], Z) :-
    \+compound(Y),
    last_atom7(Y, []),
    last_atom7(X, Z).
last_atom7([_|Y], X) :-
    last_atom7(Y, X).

last_atom7a(X, X) :- \+compound(X).
last_atom7a([_|X], X) :-
    \+compound(X),
    last_atom7a(Y, X),
    X \= [].
last_atom7a([X|Y], Z) :-
    \+compound(Y),
    last_atom7a(Y, []),
    last_atom7a(X, Z).
last_atom7a([_|Y], X) :-
    last_atom7a(Y, X).

%%%
%%%    3.14.7
%%%
pairlis([], _, []) :- !.
pairlis(_, [], []).
pairlis([X|Xs], [Y|Ys], [[X, Y]|T]) :- % or [[X|Y]|T]
    pairlis(Xs, Ys, T).

%% ?- pairlis([a, b, c], [1, 2, 3], P).
%% P = [[a, 1], [b, 2], [c, 3]].

%% ?- pairlis([a, b, c], [1, 2], P).
%% P = [[a, 1], [b, 2]] ;
%% false.

%% ?- pairlis([a, b], [1, 2, 3], P).
%% P = [[a, 1], [b, 2]].

pairlis2019(Keys, Vals, Pairs) :-
    pairlis2019(Keys, Vals, Pairs, []).
pairlis2019([], [], P, P).
pairlis2019([K|Keys], [V|Vals], P, Acc) :-
    pairlis2019(Keys, Vals, P, [[K, V]|Acc]).

%% ?- pairlis2019([a, b, c], [1, 2, 3], P).
%% P = [[c, 3], [b, 2], [a, 1]].

%%%
%%%    3.14.8
%%%
make_person(Name,
            Age,
            Weight,
            Sex,
            Children,
            [[name, Name], [age, Age], [weight, Weight], [sex, Sex], [children, Children]]).
person_name([[_, Name], _, _, _, _], Name).
person_age([_, [_, Age], _, _, _], Age).
person_weight([_, _, [_, Weight], _, _], Weight).
person_sex([_, _, _, [_, Sex], _], Sex).
person_children([_, _, _, _, [_, Children]], Children).

%% ?- make_person(joe, 35, 150, male, [irving, mabel], P), person_age(P, N).
%% P = [[name, joe], [age, 35], [weight, 150], [sex, male], [children, [irving, mabel]]],
%% N = 35.

%% ?- make_person(joe, 35, 150, male, [irving, mabel], P), person_weight(P, N).
%% P = [[name, joe], [age, 35], [weight, 150], [sex, male], [children, [irving, mabel]]],
%% N = 150.

%% ?- make_person(joe, 35, 150, male, [irving, mabel], P), person_children(P, N).
%% P = [[name, joe], [age, 35], [weight, 150], [sex, male], [children, [irving, mabel]]],
%% N = [irving, mabel].

%make_person_structure(Name, Age, Weight, Sex, Children, person(name(Name), age(Age), weight(Weight), sex(Sex), children(Children))).
make_person_structure(Name,
                      Age,
                      Weight,
                      Sex,
                      Children,
                      person(name(Name), age(Age), weight(Weight), sex(Sex), C)) :-
    C =.. [children|Children].
person_structure_name(person(name(Name), _, _, _, _), Name).
person_structure_age(person(_, age(Age), _, _, _), Age).
person_structure_weight(person(_, _, weight(Weight), _, _), Weight).
person_structure_sex(person(_, _, _, sex(Sex), _), Sex).
%person_structure_children(person(_, _, _, _, children(Children)), Children).
person_structure_children(person(_, _, _, _, C), Children) :-
    C =.. [children|Children].

%% ?- make_person_structure(joe, 35, 150, male, [irving, mabel], P), person_structure_children(P, C).
%% P = person(name(joe), age(35), weight(150), sex(male), children(irving, mabel)),
%% C = [irving, mabel].

%%%
%%%    3.14.11
%%%
zeller(N, M, C, Y, L, Z) :-
    Z is (N + (13 * M - 1) div 5 + Y + Y div 4 + C div 4 - 2 * C - (1 + L) * (M div 11)) mod 7.

leap_year(Y) :- Y mod 400 =:= 0.
leap_year(Y) :- Y mod 100 =\= 0, Y mod 4 =:= 0.

son_of_zeller(D, M, Y, Z) :-
    leap_year(Y),
    zeller(D, M, Y // 100, Y mod 100, 1, Z).
son_of_zeller(D, M, Y, Z) :-
    \+leap_year(Y),
    zeller(D, M, Y // 100, Y mod 100, 0, Z).

% (loop for day across time:day-names for i from 7 do (format t "day(~D, ~A).~%" (mod (1+ i) 7) (string-downcase day)))

day(1, monday).
day(2, tuesday).
day(3, wednesday).
day(4, thursday).
day(5, friday).
day(6, saturday).
day(0, sunday).

% (loop for month across time:month-names for i from 10 do (format t "month(~D, ~A).~%" (1+ (mod i 12)) (string-downcase month)))

month(11, january).
month(12, february).
month(1, march).
month(2, april).
month(3, may).
month(4, june).
month(5, july).
month(6, august).
month(7, september).
month(8, october).
month(9, november).
month(10, december).

daughter_of_zeller(M, D, Y, Day) :-
    month(Month, M),
    son_of_zeller(D, Month, Y, Z),
    day(Z, Day).

%% ?- daughter_of_zeller(september, 1, 1996, Z).
%% Z = sunday ;
%% false.

%% ?- daughter_of_zeller(december, 22, 2022, Z).
%% Z = thursday.

%% ?- daughter_of_zeller(december, 23, 2022, Z).
%% Z = friday.

%% ?- daughter_of_zeller(december, 24, 2022, Z).
%% Z = saturday.

%% ?- daughter_of_zeller(december, 31, 2022, Z).
%% Z = saturday.

%% ?- daughter_of_zeller(february, 24, 1996, Z).
%% Z = saturday ;
%% false.

%% ?- daughter_of_zeller(july, 16, 1999, Z).
%% Z = friday.
