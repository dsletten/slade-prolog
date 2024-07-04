#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               roman.pl
%
%   Started:            Mon Mar 22 01:45:52 2021
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
%   Notes: This passes the exhaustive check from 2024: 1-3999
%
%%

roman([i|T]) :- i1(T).
roman([v|T]) :- v2(T).
roman([x|T]) :- x2(T).
roman([l|T]) :- l2(T).
roman([c|T]) :- c2(T).
roman([d|T]) :- d2(T).
roman([m|T]) :- m2(T).

i1([]).
i1([i|T]) :- i2(T).
i1([v|T]) :- v1(T).
i1([x|T]) :- x1(T).

i2([]).
i2([i|T]) :- i3(T).

i3([]).

i4([]).
i4([i|T]) :- i2(T).

v1([]).

v2([]).
v2([i|T]) :- i4(T).

x1([]).

x2([]).
x2([i|T]) :- i1(T).
x2([v|T]) :- v2(T).
x2([x|T]) :- x3(T).
x2([l|T]) :- l1(T).
x2([c|T]) :- c1(T).

x3([]).
x3([i|T]) :- i1(T).
x3([v|T]) :- v2(T).
x3([x|T]) :- x4(T).

x4([]).
x4([i|T]) :- i1(T).
x4([v|T]) :- v2(T).

l1([]).
l1([i|T]) :- i1(T).
l1([v|T]) :- v2(T).

l2([]).
l2([i|T]) :- i1(T).
l2([v|T]) :- v2(T).
l2([x|T]) :- x2(T).

c1([]).
c1([i|T]) :- i1(T).
c1([v|T]) :- v2(T).

c2([]).
c2([i|T]) :- i1(T).
c2([v|T]) :- v2(T).
c2([x|T]) :- x2(T).
c2([l|T]) :- l2(T).
c2([c|T]) :- c3(T).
c2([d|T]) :- d1(T).
c2([m|T]) :- m1(T).

c3([]).
c3([i|T]) :- i1(T).
c3([v|T]) :- v2(T).
c3([x|T]) :- x2(T).
c3([l|T]) :- l2(T).
c3([c|T]) :- c4(T).

c4([]).
c4([i|T]) :- i1(T).
c4([v|T]) :- v2(T).
c4([x|T]) :- x2(T).
c4([l|T]) :- l2(T).

d1([]).
d1([i|T]) :- i1(T).
d1([v|T]) :- v2(T).
d1([x|T]) :- x2(T).
d1([l|T]) :- l2(T).

d2([]).
d2([i|T]) :- i1(T).
d2([v|T]) :- v2(T).
d2([x|T]) :- x2(T).
d2([l|T]) :- l2(T).
d2([c|T]) :- c2(T).

m1([]).
m1([i|T]) :- i1(T).
m1([v|T]) :- v2(T).
m1([x|T]) :- x2(T).
m1([l|T]) :- l2(T).

m2([]).
m2([i|T]) :- i1(T).
m2([v|T]) :- v2(T).
m2([x|T]) :- x2(T).
m2([l|T]) :- l2(T).
m2([c|T]) :- c2(T).
m2([d|T]) :- d2(T).
m2([m|T]) :- m3(T).

m3([]).
m3([i|T]) :- i1(T).
m3([v|T]) :- v2(T).
m3([x|T]) :- x2(T).
m3([l|T]) :- l2(T).
m3([c|T]) :- c2(T).
m3([d|T]) :- d2(T).
m3([m|T]) :- m4(T).

m4([]).
m4([i|T]) :- i1(T).
m4([v|T]) :- v2(T).
m4([x|T]) :- x2(T).
m4([l|T]) :- l2(T).
m4([c|T]) :- c2(T).
m4([d|T]) :- d2(T).


roman_list([]).
roman_list([R|Rs]) :-
    roman(R),
    roman_list(Rs).



%% ?- roman([m, m, c, m, i, x]).
%% true ;
%% false.

%% ?- roman([m, m, m, d, c, c, c, x, x, x, i]).
%% true ;
%% false.

%% ?- roman([m, m, d, c, c, x, c, i, x]).
%% true ;
%% false.

%% ?- roman([m, m, m, c, m, l, x, i, i]).
%% true ;
%% false.

%% ?- roman([m, c, c, c, x, x, v]).
%% true ;
%% false.

%% ?- roman([m, m, x, v, i]).
%% true ;
%% false.

%% ?- roman([v, i]).
%% true ;
%% false.

%% ?- roman([m, m, m, i, i, i]).
%% true ;
%% false.

%% ?- roman([m, m, c, c, c, x, l, v, i, i, i]).
%% true ;
%% false.

%% ?- roman([m, m, c, x, l, v, i, i, i]).
%% true ;
%% false.

%% ?- roman([m, d, l, x, x, i, v]).
%% true ;
%% false.

%% ?- roman([m, m, c, c, x, l, v]).
%% true ;
%% false.

%% ?- roman([m, m, m, c, c, c, l, v]).
%% true ;
%% false.

%% ?- roman([m, m, m, c, d, x, x, i, v]).
%% true ;
%% false.

%% ?- roman([m, m, l, x, v]).
%% true ;
%% false.

%% ?- roman([m, m, d, c, c, x, c, i, i]).
%% true ;
%% false.

%% ?- roman([m, d, c, c, l, x, v]).
%% true ;
%% false.

%% ?- roman([m, m, m, c, m, x, x, x]).
%% true ;
%% false.

%% ?- roman([m, m, d, c, c, c, x, i]).
%% true ;
%% false.

%% ?- roman([m, c, l, x, x, x, v, i]).
%% true ;
%% false.

%% ?- roman([c, c, l, x, x, i, v]).
%% true ;
%% false.

%% ?- roman([c, l, x, x, x]).
%% true ;
%% false.

%% ?- roman([c, c, c, x, i, i]).
%% true ;
%% false.

%% ?- roman([c, l, x, x, i]).
%% true ;
%% false.

%% ?- roman([l, x, x, x, i, i, i]).
%% true ;
%% false.

%% ?- roman([x, x, v]).
%% true ;
%% false.

%% ?- roman([x, c]).
%% true ;
%% false.

%% ?- roman([x, c, i, i, i]).
%% true ;
%% false.

%% ?- roman([c, c, c, x, v, i]).
%% true ;
%% false.

%% ?- roman([c, c, c, x, c, v, i, i, i]).
%% true ;
%% false.

%% ?- roman([l]).
%% true ;
%% false.

%% ?- roman([c, c, c, l, x, x, i, x]).
%% true ;
%% false.

%% ?- roman([c, l, x, x, v]).
%% true ;
%% false.

%% ?- roman([v, i, i, i]).
%% true ;
%% false.

%% ?- roman([c, c, c, l, x, i, i]).
%% true ;
%% false.

%% ?- roman([c, l, x, x, i, v]).
%% true ;
%% false.

%% ?- roman([c, c, c, x, c, i, i, i]).
%% true ;
%% false.

%% ?- roman([c, c, c, x, x, x, i, i, i]).
%% true ;
%% false.

%% ?- roman([c, l, x, x, x, v, i, i]).
%% true ;
%% false.

%% ?- roman([c, x, l, i, v]).
%% true ;
%% false.





%% ?- roman([x, X, Y]).
%% X = Y, Y = i ;
%% X = i,
%% Y = v ;
%% X = i,
%% Y = x ;
%% X = v,
%% Y = i ;
%% X = x,
%% Y = i ;
%% X = x,
%% Y = v ;
%% X = Y, Y = x ;
%% X = l,
%% Y = i ;
%% X = l,
%% Y = v ;
%% X = c,
%% Y = i ;
%% X = c,
%% Y = v ;
%% false.
