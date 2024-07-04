#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch06.pl
%
%   Started:            Mon Sep 16 00:40:48 2019
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
%%    6.8.3
%%
%% merge_([], [], []).
%% merge_(L, [], L) :-
%%     L \= [].
%% merge_([], L, L) :-
%%     L \= [].
%% merge_([H1|T1], [H2|T2], [H1|L]) :-
%%     compare(<, H1, H2),
%%     merge_(T1, [H2|T2], L).
%% merge_([H1|T1], [H2|T2], [H2|L]) :-
%%     compare(<, H2, H1),
%%     merge_([H1|T1], T2, L).
%% merge_([H1|T1], [H1|T2], [H1|L]) :-
%%     merge_([H1|T1], T2, L).
merge_(L, [], L) :- !.
merge_([], L, L) :- !.
merge_([H1|T1], [H2|T2], [H1|L]) :-
    H1 @< H2,
    merge_(T1, [H2|T2], L).
merge_([H1|T1], [H2|T2], [H2|L]) :-
    H2 @=< H1,
    merge_([H1|T1], T2, L).

% ?- merge_([2, 7, 9], [1, 8], L).
% L = [1, 2, 7, 8, 9] ;
% false.

% ?- merge_([2, 7, 9], [], L).
% L = [2, 7, 9] ;
% false.

% ?- merge_([9], [5], L).
% L = [5, 9] ;
% false.

% ?- merge_([a, c], [b, d], L).
% L = [a, b, c, d] ;
% false.

%% mergesort([], []).
%% mergesort([X], [X]).
%% mergesort(L, M) :-
%%     mergesort(L, M, [], []).
%% mergesort([], M, L1, L2) :-
%%     mergesort(L1, M1),
%%     mergesort(L2, M2),
%%     merge_(M1, M2, M).
%% mergesort([H|T], M, L1, L2) :-
%%     mergesort(T, M, L2, [H|L1]).

mergesort([], []).
mergesort([X], [X]).
mergesort(L, M) :-
    partition(L, L1, L2),
    mergesort(L1, M1),
    mergesort(L2, M2),
    merge(M1, M2, M).
partition(L, L1, L2) :-
    partition(L, [], [], L1, L2).
partition([], L1, L2, L1, L2).
partition([H|T], L1, L2, L3, L4) :-
    partition(T, L2, [H|L1], L3, L4).

% ?- mergesort([3, 2, 5, 1], M).
% M = [1, 2, 3, 5] ;
% M = [1, 2, 3, 5] ;
% M = [1, 2, 3, 5] 

% ?- mergesort([3, 2, 3, 5, 1], M).
% M = [1, 2, 3, 3, 5] ;
% M = [1, 2, 3, 3, 5] 

% ?- mergesort([x, a, d], M).
% M = [a, d, x] ;
% M = [a, d, x] ;
% M = [a, d, x] ;
% M = [a, d, x] 

%%    @< compares floats as less than equal integers...
%% ?- mergesort([3, 2, 3.0, 5, 1], M).
%% M = [1, 2, 3.0, 3, 5] 

%% ?- mergesort([3.0, 2, 3, 5, 1], M).
%% M = [1, 2, 3.0, 3, 5] 
