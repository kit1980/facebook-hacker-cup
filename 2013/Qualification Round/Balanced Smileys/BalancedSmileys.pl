% Facebook Hacker Cup
% Qualification Round 2013
% Balanced Smileys
% https://www.facebook.com/hackercup/problems.php?pid=403525256396727&round=185564241586420
%
% Straightforward DCG-based solution in B-Prolog.
%
% Author: Sergey Dymchenko <http://sdymchenko.com>
%
% B-Prolog 8.1 - http://www.probp.com/
% Usage:
% bp -g "cl('BalancedSmileys.pl'),main,halt" -l | tail -n +5 < in-file > out-file

:- table_all.

symbol --> " " | ":" | [C], {C >= 0'a, C =< 0'z}.

balanced --> "" | symbol | ":)" | ":(" 
                | "(", balanced, ")" 
                | balanced, balanced.

do_case(Case_num, S) :-
    ( balanced(S, []) -> Result = "YES" ; Result = "NO" ),
    format("Case #~w: ~s\n", [Case_num, Result]).

main :-
    readLine(Tstr_), append(Tstr, [10], Tstr_), number_codes(T, Tstr),
    foreach(Case_num in 1..T, [S_, S], (
                readLine(S_),
                append(S, [10], S_), % strip nl (ASCII 10),
                do_case(Case_num, S)
           )).
