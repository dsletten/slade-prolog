#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08.pl
%
%   Started:            Tue Sep 17 00:07:01 2019
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

%%
%%    8.7.6
%%

power([], [[]]).
power([H|T], P) :-
    power(T, P1),
    layer_elt(H, P1, P).

layer_elt(X, L, L2) :-
    layer_elt(X, L, L2, L).
layer_elt(_, [], L, L).
layer_elt(X, [H|T], [[X|H]|L2], L) :-
    layer_elt(X, T, L2, L).


% ?- power([], P).
% P = [[]].

% ?- power([a], P).
% P = [[a], []] ;
% false.

% ?- power([a, b], P).
% P = [[a, b], [a], [b], []] ;
% false.

% ?- power([a, b, c], P).
% P = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []] ;
% false.

% ?- power([a, b, c, d], P).
% P = [[a, b, c, d], [a, b, c], [a, b, d], [a, b], [a, c, d], [a, c], [a, d], [a], [...|...]|...] ;
% false.

% ?- power([b, c, d], P).
% P = [[b, c, d], [b, c], [b, d], [b], [c, d], [c], [d], []] ;
% false.
