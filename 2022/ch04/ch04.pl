#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Sun Jan  1 14:33:08 2023
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

:- module(ch04, []).

%%%
%%%    4.7.1
%%%    
replicate(_, 0, []).
replicate(X, N, [X|T]) :-
    N > 0,
    N1 is N - 1,
    replicate(X, N1, T).

factorial(0, 1).
factorial(N, F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

%%%
%%%    4.7.2
%%%
roman(i, 1).
roman(v, 5).
roman(x, 10).
roman(l, 50).
roman(c, 100).
roman(d, 500).
roman(m, 1000).

roman_to_decimal([], 0).
roman_to_decimal([R1,R2|T], D) :-
    roman(R1, D1),
    roman(R2, D2),
    D1 < D2,
    roman_to_decimal([R2|T], D3),
    D is D3 - D1.
roman_to_decimal([R], D) :-
    roman(R, D).
roman_to_decimal([R1,R2|T], D) :-
    roman(R1, D1),
    roman(R2, D2),
    D1 >= D2,
    roman_to_decimal([R2|T], D3),
    D is D3 + D1.
    
%%
%%    This does not handle subtraction...
%%    
roman_to_decimal2(R, D) :-
%    roman_to_decimal2(R, D, [[i, 1], [v, 5], [x, 10], [l, 50], [c, 100], [d, 500], [m, 1000]], 0).
    roman_to_decimal2(R, D, [[m, 1000], [d, 500], [c, 100], [l, 50], [x, 10], [v, 5], [i, 1]], 0).
roman_to_decimal2([], D, _, D).
roman_to_decimal2([R|Rs], D, [[R, X]|T], Acc) :-
    Acc1 is Acc + X,
    roman_to_decimal2(Rs, D, [[R, X]|T], Acc1).
roman_to_decimal2([R|Rs], D, [[_, _]|T], Acc) :-
    roman_to_decimal2([R|Rs], D, T, Acc).


%%
%%    Does `List` start with `Target`? If so, `Follow` is the tail after the match.
%%    
prefix([], L, L).
prefix([H|T1], [H|T2], F) :-
    prefix(T1, T2, F).

%% ?- ch04:prefix([], [g, t, c, a, t], F).
%% F = [g, t, c, a, t].

%% ?- ch04:prefix([g, t, c], [g, t, c, a, t], F).
%% F = [a, t].

%% ?- ch04:prefix([g, t, c, a, t], [g, t, c, a, t], F).
%% F = [].

%% ?- ch04:prefix([g, t, c], [a, g, g, t, c], F).
%% false.

(((m) 1000 3 t)
 ((c m) 900 1 nil)
 ((d) 500 1 nil)
 ((c d) 400 1 nil)
 ((c) 100 3 t)
 ((x c) 90 1 nil)
 ((l) 50 1 nil)
 ((x l) 40 1 nil)
 ((x) 10 3 t)
 ((i x) 9 1 nil)
 ((v) 5 1 nil)
 ((i v) 4 1 nil)
 ((i) 1 3 t))

(defun roman->arabic (roman)
  (labels ((roman->arabic-aux (roman num-list)
             (cond ((endp roman) 0)
                   ((endp num-list) nil) ; Error if we get here
                   (t (destructuring-bind ((target value count allow-next-p) &rest tail) num-list
                        (multiple-value-bind (match rest) (starts-with target roman)
                          (if match
                              (if (= count 1)
                                  (if allow-next-p
                                      (+ value (roman->arabic-aux rest tail))
                                      (+ value (roman->arabic-aux rest (rest tail))))
                                  (+ value (roman->arabic-aux rest (cons (list target value (1- count) allow-next-p) tail))))
                              (roman->arabic-aux roman tail)))) ))))
    (handler-case (roman->arabic-aux roman roman-numerals-3)
      (simple-type-error (e) (format t "Invalid roman numeral: ~A~%" roman)))) )
