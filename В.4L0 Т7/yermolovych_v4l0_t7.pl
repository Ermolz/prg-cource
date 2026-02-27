% ПІБ: Yermolovych Zakhar Maksymovych
:- set_prolog_flag(double_quotes, string).

% 1. Перетворити список у список позицій (з 0) від'ємних елементів.

% z101(++List, --Positions)
z101(List, Positions) :- z101_(List, 0, Positions).

% z101_(++List, ++Index, --Positions)
z101_([], _Index, []).
z101_([H|T], Index, Positions) :-
    NextIndex is Index + 1,
    (   number(H),
        H < 0
    ->  Positions = [Index|Rest],
        z101_(T, NextIndex, Rest)
    ;   Positions = Rest,
        z101_(T, NextIndex, Rest)
    ).

/** <examples>
?- z101([-1,2,-3,2,3,-2], R).
R = [0, 2, 5].
true.

?- z101([-1,-2,-3,-2,-3,-2], R).
R = [0, 1, 2, 3, 4, 5].
true.

?- z101([1,2,3,2,3,2], R).
R = [].
true.
*/


% 2. Замінити всі входження заданого елемента на символ change_done.

% z102(++Elem, +ListIn, --ListOut)
z102(_Elem, [], []).
z102(Elem, [H|T], [R|RT]) :-
    (   H == Elem
    ->  R = change_done
    ;   R = H
    ),
    z102(Elem, T, RT).

/** <examples>
?- z102(2, [-1,2,-3,2,3,-2], R).
R = [-1, change_done, -3, change_done, 3, -2].
true.

?- z102(a, [a,b,a,c], R).
R = [change_done, b, change_done, c].
true.
*/


% 3. Перетворити список арабських чисел (1..90) у список римських.
%    Результат у зворотньому порядку (як у тесті).

% z103(++Numbers, --Romans)
z103(Numbers, Romans) :- z103_(Numbers, [], Romans).

% z103_(++Numbers, +Acc, --Romans)
z103_([], Acc, Acc).
z103_([N|T], Acc, Romans) :-
    roman_1_90(N, Roman),
    z103_(T, [Roman|Acc], Romans).

% roman_1_90(++N, --Roman)
roman_1_90(N, Roman) :-
    integer(N),
    N >= 1,
    N =< 90,
    Tens is (N // 10) * 10,
    Ones is N mod 10,
    tens_roman(Tens, RTens),
    ones_roman(Ones, ROnes),
    string_concat(RTens, ROnes, Roman).

% tens_roman(++Tens, --RomanTens)
tens_roman(0,  "").
tens_roman(10, "X").
tens_roman(20, "XX").
tens_roman(30, "XXX").
tens_roman(40, "XL").
tens_roman(50, "L").
tens_roman(60, "LX").
tens_roman(70, "LXX").
tens_roman(80, "LXXX").
tens_roman(90, "XC").

% ones_roman(++Ones, --RomanOnes)
ones_roman(0, "").
ones_roman(1, "I").
ones_roman(2, "II").
ones_roman(3, "III").
ones_roman(4, "IV").
ones_roman(5, "V").
ones_roman(6, "VI").
ones_roman(7, "VII").
ones_roman(8, "VIII").
ones_roman(9, "IX").

/** <examples>
?- z103([1,12,15,52], Result).
Result = ["LII", "XV", "XII", "I"].
true.

?- z103([9,10,11,90], R).
R = ["XC", "XI", "X", "IX"].
true.
*/


% 4. Циклічний зсув на 1: праворуч та ліворуч.

% z104_shift_right(+List, -Shifted)
z104_shift_right([], []).
z104_shift_right(List, Shifted) :-
    List = [_|_],
    append(Init, [Last], List),
    Shifted = [Last|Init].

% z104_shift_left(+List, -Shifted)
z104_shift_left([], []).
z104_shift_left([H|T], Shifted) :-
    append(T, [H], Shifted).

/** <examples>
?- z104_shift_right([a,b,c,d,e], R).
R = [e, a, b, c, d].
true.

?- z104_shift_left([a,b,c,d,e], R).
R = [b, c, d, e, a].
true.

?- z104_shift_right([], R).
R = [].
true.
*/


% 5. Множення матриці (список списків) на вектор.

% z105_mat_vec_mul(++Matrix, ++Vector, --Result)
z105_mat_vec_mul([], _Vector, []).
z105_mat_vec_mul([Row|Rows], Vector, [Val|Vals]) :-
    dot_product(Row, Vector, Val),
    z105_mat_vec_mul(Rows, Vector, Vals).

% dot_product(++Row, ++Vector, --Value)
dot_product(Row, Vector, Value) :- dot_product_(Row, Vector, 0, Value).

% dot_product_(++Row, ++Vector, ++Acc, --Value)
dot_product_([], [], Acc, Acc).
dot_product_([A|As], [B|Bs], Acc, Value) :-
    Acc1 is Acc + A * B,
    dot_product_(As, Bs, Acc1, Value).

/** <examples>
?- z105_mat_vec_mul([[1,2,3],[4,5,6]], [10,20,30], R).
R = [140, 320].
true.

?- z105_mat_vec_mul([], [1,2], R).
R = [].
true.
*/