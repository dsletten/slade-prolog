#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               spell-correct.pl
%
%   Started:            Sun Mar  1 05:15:43 2020
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

correct(commuter).
correct(computer).
correct(computation).
correct(computing).
correct(compute).
correct(computers).
correct(snuggle).

%% string_swap(S0, I, J, S1) :-
%%     I < J,
%%     atom_chars(S, Cs),
%%     swap_before(Cs, I, J, Before, Ci, Between, Cj, After),
%%     append([Before, [Cj], Between, [Ci], After], S1s),
%%     atomic_list_concat(S1s, S1).

string_swap(S0, I, J, S1) :-
    I < J,
    I1 is I + 1,
    J1 is J + 1,
    atom_chars(S0, Cs),
    char_at(Cs, I, Ci),
    char_at(Cs, J, Cj),
    substring(Cs, 0, I, Before),
    substring(Cs, I1, J, Between),
    substring(Cs, J1, After),
    append([Before, [Cj], Between, [Ci], After], C1s),
    atomic_list_concat(C1s, S1).


%% ?- string_swap('hello there', 3, 5, S).
%% S = 'hel olthere' ;
%% false.

%% ?- string_swap('hello there', 5, 9, S).
%% S = 'hellorthe e' 

swap_before([C|Cs], 0, J, Before, C, Between, Cj, After) :-
    swap_after(Cs, J, Before, C, Between, Cj, After).
%swap_before([C|Cs], I, J, 
swap_after([C|Cs], 0, Before, Ci, Between, C, Cs).    

char_at([C|_], 0, C).
char_at([_|Cs], I, C) :-
    I > 0,
    I1 is I - 1,
    char_at(Cs, I1, C).



%% ?- char_at([a, b, c, d], 0, C).
%% C = a ;
%% false.

%% ?- char_at([a, b, c, d], 1, C).
%% C = b ;
%% false.

%% ?- char_at([a, b, c, d], 2, C).
%% C = c ;
%% false.

%% ?- char_at([a, b, c, d], 3, C).
%% C = d ;
%% false.

%% ?- char_at([a, b, c, d], 4, C).
%% false.


%    Extract all chars after J
substring(S, 0, S).
substring([_|Cs], J, S) :-
    J > 0,
    J1 is J - 1,
    substring(Cs, J1, S).


%% ?- substring([a, b, c, d], 1, S).
%% S = [b, c, d] ;
%% false.

%% ?- substring([a, b, c, d], 2, S).
%% S = [c, d] ;
%% false.

%% ?- substring([a, b, c, d], 3, S).
%% S = [d] ;
%% false.

%% ?- substring([a, b, c, d], 4, S).
%% S = [].



%    Extract all letters between bounding indices I, J: I <= ch < J
substring(S0, I, J, S1) :-
    substring(S0, I, J, [], S1).
substring([_|Cs], I, J, S1, S2) :-
    I > 0,
    I1 is I - 1,
    J1 is J - 1,
    substring(Cs, I1, J1, S1, S2).
substring(_, _, 0, S1, S2) :-
    reverse(S1, S2).
substring([C|Cs], 0, J, S1, S2) :-
    J > 0,
    J1 is J - 1,
    substring(Cs, 0, J1, [C|S1], S2).


%% ?- substring([a, b, c, d], 1, 2, S).
%% S = [b] ;
%% false.

%% ?- substring([a, b, c, d], 1, 3, S).
%% S = [b, c] ;
%% false.

%% ?- substring([a, b, c, d], 0, 3, S).
%% S = [a, b, c] ;
%% false.

%% ?- substring([a, b, c, d], 0, 4, S).
%% S = [a, b, c, d].

string_remove(S, I, S1) :-
    atom_chars(S, Cs),
    string_remove(Cs, I, [], C1s),
    reverse(C1s, C2s),
    atomic_list_concat(C2s, S1).
string_remove([], _, S, S).
string_remove([_|Cs], 0, S0, S1) :-
    string_remove(Cs, -1, S0, S1).
string_remove([C|Cs], I, S0, S1) :-
    I1 is I - 1,
    string_remove(Cs, I1, [C|S0], S1).



check_transposition(S, S1) :-
    atom_length(S, L),
    check_transposition(S, L, S1).
check_transposition(S, I, S1) :-
    I > 0,
    J is I - 1,
    string_swap(S, J, I, S1),
    correct(S1).
check_transposition(S, I, S1) :-
    I > 0,
    I1 is I - 1,
    check_transposition(S, I1, S1).
%% (defun check-transposition (s i)
%%   (if (zerop i)
%%       nil
%%       (or (check-word (string-swap s i (1- i)))
%%           (check-transposition s (1- i)))) )

check_deletion(S, S1) :-
    atom_length(S, L),
    L1 is L - 1,
    check_deletion(S, L1, S1).
check_deletion(S, I, S1) :-
    I > 0,
    string_remove(S, I, S1),
    correct(S1).
check_deletion(S, I, S1) :-
    I > 0,
    I1 is I - 1,
    check_deletion(S, I1, S1).

%% (defun check-deletion (s i)
%%   (if (zerop i)
%%       nil
%%       (let ((new-word (concatenate 'string (subseq s 0 (1- i)) (subseq s i))))
%%         (or (check-word new-word)
%%             (check-deletion s (1- i)))) ))

string_insert(Cs, 0, C0, [C0|Cs]).
string_insert([C|Cs], I, C0, [C|S]) :-
    I > 0,
    I1 is I - 1,
    string_insert(Cs, I1, C0, S).

%% ?- atom_chars('hello', H), string_insert(H, 0, 'X', S).
%% H = [h, e, l, l, o],
%% S = ['X', h, e, l, l, o] ;
%% false.

%% ?- atom_chars('hello', H), string_insert(H, 1, 'X', S).
%% H = [h, e, l, l, o],
%% S = [h, 'X', e, l, l, o] ;
%% false.

%% ?- atom_chars('hello', H), string_insert(H, 4, 'X', S).
%% H = [h, e, l, l, o],
%% S = [h, e, l, l, 'X', o] ;
%% false.

%% ?- atom_chars('hello', H), string_insert(H, 5, 'X', S).
%% H = [h, e, l, l, o],
%% S = [h, e, l, l, o, 'X'].

%% ?- atom_chars('hello', H), string_insert(H, 6, 'X', S).
%% false.

check_double(S, S1) :-
    atom_length(S, L),
    atom_chars(S, Cs),
    check_double(Cs, L, S1).
check_double(Cs, I, S1) :-
    I >= 0,
    char_at(Cs, I, C),
    string_insert(Cs, I, C, C1s),
    atomic_list_concat(C1s, S1),
    correct(S1).
check_double(Cs, I, S) :-
    I > 0,
    I1 is I - 1,
    check_double(Cs, I1, S).

%% (defun check-double (s i)
%%   (if (minusp i)
%%       nil
%%       (or (check-word (string-insert s (char s i) i))
%%           (check-double s (1- i)))) )

%% (defun string-insert (s ch i) ; !!
%%   (concatenate 'string (subseq s 0 i) (string ch) (subseq s i)))

%% (deftest test-string-insert ()
%%   (check
%%    (string= (string-insert "hello" #\X 0) "Xhello")
%%    (string= (string-insert "hello" #\X 1) "hXello")
%%    (string= (string-insert "hello" #\X 4) "hellXo")
%%    (string= (string-insert "hello" #\X 5) "helloX")))



%% (defun tag-word (word)
%%   (setf (get word 'isa-word) t))

%% ;; (defvar *dictionary* '(commuter computer computation computing compute computers))
%% ;; (dolist (word *dictionary*)
%% ;;   (tag-word word))

%% (defvar *dictionary* (make-hash-table :test #'equalp))
%% (when (zerop (hash-table-count *dictionary*))
%%   (dolist (word (read-file "/Users/dsletten/lisp/books/Slade/ch06/wordlists/words.big"))
%%     (if (gethash word *dictionary*)
%%         (format t "Already encountered: ~A~%" word)
%%         (setf (gethash word *dictionary*) t))))

%% (defun spell-match (word)
%%   (if (symbolp word)
%%       (find-match (symbol-name word))
%%       (find-match word)))

%% (defun find-match (word)
%%   (let ((length (length word)))
%%     (cond ((zerop length) nil)
%%           ((check-word word))
%%           ((check-deletion word length))
%%           ((check-transposition word (1- length)))
%%           ((check-double word (1- length)))
%%           ((check-insertion word length))
%%           (t nil))))

%% ;; (defun check-word (word)
%% ;;   (let ((symbol (find-symbol (string-upcase word))))
%% ;;     (cond ((null symbol) nil)
%% ;;           ((get symbol 'isa-word) word)
%% ;;           (t nil))))

%% (defun check-word (word)
%%   (if (gethash word *dictionary*)
%%       word
%%       nil))

%% (defun string-swap (s i j)
%%   (let ((result (copy-seq s)))
%%     (rotatef (char result i) (char result j))
%%     result))

%% (deftest test-string-swap ()
%%   (check
%%    (string= (string-swap "hello there" 3 5) "hel olthere")
%%    (string= (string-swap "hello there" 5 9) "hellorthe e")))


%% (defun check-insertion (s i)
%%   (if (minusp i)
%%       nil
%%       (or (insert s i #\A)
%%           (check-insertion s (1- i)))) )

%% (defun insert (s i ch) ; !!
%%   (if (char-greaterp ch #\Z)
%%       nil
%%       (or (check-word (string-insert s ch i))
%%           (insert s i (next-char ch)))) )

%% (defun next-char (ch)
%%   (code-char (1+ (char-code ch))))
