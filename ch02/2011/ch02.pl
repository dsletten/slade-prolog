#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Sun Oct 30 02:45:31 2011
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




%% (defun zeller (n m c y l)
%%   (mod (+ n
%%           (cl:floor (1- (* 13 m)) 5)
%%           y
%%           (cl:floor y 4)
%%           (cl:floor c 4)
%%           (* -2 c)
%%           (* -1 (1+ l) (cl:floor m 11)))
%%        7))

zeller(N, M, C, Y, L, Z) :-
    Z is (N + floor((13 * M - 1) rdiv 5) + Y + floor(Y rdiv 4) + floor(C rdiv 4) - 2 * C - (L + 1) * floor(M rdiv 11)) mod 7.


%% ?- zeller(1, 7, 19, 96, 1, Z).
%% Z = 0.

%% ?- zeller(11, 7, 20, 1, 0, Z).
%% Z = 2.

%% ?- zeller(16, 5, 19, 99, 0, Z).
%% Z = 5.

%% ?- zeller(24, 12, 19, 96, 1, Z).
%% Z = 6.
