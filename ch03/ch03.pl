#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Sun Nov  6 03:26:26 2011
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
%%%    3.14.4
%%%    
remove_zeros([], []).
remove_zeros([0|T], T1) :- remove_zeros(T, T1).
remove_zeros([H|T], [H|T1]) :- H \= 0, remove_zeros(T, T1).

adjoin_number(X, L, [X|L]) :- number(X).
adjoin_number(X, L, L) :- atom(X).
adjoin_number(X, L, L) :- compound(X).
adjoin_number(X, L, L) :- var(X).

verb(is).
verb(am).
verb(are).
verb(have).
verb(has).
verb(go).
verb(went).
verb(gone).

verb_find([], []).
verb_find([H|T], [H|T1]) :- verb(H), verb_find(T, T1).
verb_find([_|T], T1) :- verb_find(T, T1).

