#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Wed Aug 28 21:04:14 2019
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

%
%    3.14.4
%
no_zeros([], []).
no_zeros([0|T1], T2) :-
    no_zeros(T1, T2).
no_zeros([H|T1], [H|T2]) :-
    H \= 0,
    no_zeros(T1, T2).

% ?- no_zeros([1, 0, 2, 0, 3], L).
% L = [1, 2, 3] ;
% false.

% ?- no_zeros([a, b, c, d, e], L).
% L = [a, b, c, d, e].

collect_numbers(Obj, L, [Obj|L]) :-
    number(Obj).
collect_numbers(_, L, L).

%
%    3.14.7
%
% pairlis([], [], []).
% pairlis([K|Keys], [V|Vals], [[K, V]|Pairs]) :-
%     pairlis(Keys, Vals, Pairs).


% ?- pairlis([a, b, c], [1, 2, 3], P).
% P = [[a, 1], [b, 2], [c, 3]].

pairlis(Keys, Vals, Pairs) :-
    pairlis(Keys, Vals, Pairs, []).
pairlis([], [], P, P).
pairlis([K|Keys], [V|Vals], P, Acc) :-
    pairlis(Keys, Vals, P, [[K, V]|Acc]).



