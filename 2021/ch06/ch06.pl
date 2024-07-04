#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch06.pl
%
%   Started:            Fri Apr  9 02:23:53 2021
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
%%%   6.8.2
%%%   
lastchar(S, C) :-
    atom_chars(S, L),
    last_(L, C).

last_([C], C).
last_([_|T], C) :-
    last_(T, C).

capitalize(S1, S2) :-
    atom_chars(S1, [C0|Cs]),
    upcase_atom(C0, C1),
    atomic_list_concat([C1|Cs], S2). 

%% string_equalp(S1, S2) :-
%%     atom_chars(S1, L1),
%%     atom_chars(S2, L2),
%%     equalp(L1, L2).

%% equalp([], []).
%% equalp([H1|T1], [H2|T2]) :-
%%     downcase_atom(H1, H1a),
%%     downcase_atom(H2, H2a),
%%     H1a = H2a,
%%     equalp(T1, T2).

string_equalp(S1, S2) :-
    downcase_atom(S1, L1),
    downcase_atom(S2, L2),
    L1 = L2.

string_lessp(S1, S2) :-
    downcase_atom(S1, L1),
    downcase_atom(S2, L2),
    L1 @< L2.


%%%
%%%    6.8.3
%%%    

%% merge([], [], []).

%% split(Xs, Ys, Zs) :-
%%     split(Xs, Ys, Zs, [], []).
%% split([], Ys, Zs, Ys, Ys).
%% split([X|Xs], Ys, Zs, AccY, AccZ) :-
%%     split(Xs, Zs, Ys, AccZ, [X|AccY]).

split([], [], []) :- !.
split([X], [X], []) :- !.
split([X|Xs], [X|Ys], Zs) :-
    split(Xs, Zs, Ys).

inorder(X, Y) :-
    number(X),
    number(Y), !,
    X =< Y.
inorder(X, Y) :-
    X @=< Y.

merge([], L, L) :- !.
merge(L, [], L) :- !.
merge([H1|T1], [H2|T2], [H1|T3]) :-
    inorder(H1, H2), !,
    merge(T1, [H2|T2], T3).
merge([H1|T1], [H2|T2], [H2|T3]) :-
    merge([H1|T1], T2, T3).

merge_sort([], []) :- !.
merge_sort([X], [X]) :- !.
merge_sort(L, S) :-
    split(L, L1, L2),
    merge_sort(L1, S1),
    merge_sort(L2, S2),
    merge(S1, S2, S).

%%%
%%%    6.8.5
%%%
string_reverse(S, R) :-
    atom_chars(S, L),
    reverse(L, L1),
    atomic_list_concat(L1, R).

%%%
%%%    6.8.6
%%%
string_insert(S, C, I, R) :-
    atom_chars(S, L),
    insert(L, I, C, L1),
    atomic_list_concat(L1, R).

insert(L, 0, C, [C|L]).
insert([H|T], I, C, [H|L]) :-
    I > 0,
    I1 is I - 1,
    insert(T, I1, C, L).

%% ?- insert([1, 2, 3, 4], 0, x, L).
%% L = [x, 1, 2, 3, 4] ;
%% false.

%% ?- insert([1, 2, 3, 4], 1, x, L).
%% L = [1, x, 2, 3, 4] ;
%% false.

%% ?- insert([1, 2, 3, 4], 2, x, L).
%% L = [1, 2, x, 3, 4] ;
%% false.

%% ?- insert([1, 2, 3, 4], 4, x, L).
%% L = [1, 2, 3, 4, x].

%% ?- insert([1, 2, 3, 4], 5, x, L).
%% false.

%% ?- string_insert(hello, 'X', 0, S).
%% S = 'Xhello' ;
%% false.

%% ?- string_insert(hello, 'X', 1, S).
%% S = hXello ;
%% false.

%% ?- string_insert(hello, 'X', 4, S).
%% S = hellXo ;
%% false.

%% ?- string_insert(hello, 'X', 5, S).
%% S = helloX.

%% ?- string_insert(hello, 'X', 6, S).
%% false.

string_swap(S, I, I, S).
string_swap(S, I, J, R) :-
    I < J,
    atom_chars(S, L),
    swap(L, I, J, L1, CI, CJ),
    atomic_list_concat(L1, R).
string_swap(S, I, J, R) :-
    I > J,
    atom_chars(S, L),
    swap(L, J, I, L1, CI, CJ),
    atomic_list_concat(L1, R).

swap([H|T], 0, J, [CJ|L], H, CJ) :-
    J1 is J - 1,
    swap(T, J1, L, H, CJ).
swap([H|T], I, J, [H|L], CI, CJ) :-
    I > 0,
    I1 is I - 1,
    J1 is J - 1,
    swap(T, I1, J1, L, CI, CJ).
swap([H|T], 0, [CI|T], CI, H).
swap([H|T], J, [H|L], CI, CJ) :-
    J > 0,
    J1 is J - 1,
    swap(T, J1, L, CI, CJ).

%delete_char(L, [], L).
%delete_char(H, [_|T], L) :-
delete_char(S, D) :-
    atom_chars(S, L),
    append(H, [_|T], L),
    append(H, T, L1),
    atomic_list_concat(L1, D).

string_delete(S, D) :-
    delete_char(S, D),
    word(D).
