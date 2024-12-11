lab_one:- writeln("введите диапозон"), read(X), read(Y), NX is X - 1, all_non_odd(NX, Y).

all_non_odd(X, X).

all_non_odd(X, Y):-
    Y mod 2 =\= 0,
    writeln(Y),
    Y1 is Y - 1,
    all_non_odd(X, Y1).

all_non_odd(X, Y):-
    Y mod 2 =:= 0,
    Y1 is Y - 1,
    all_non_odd(X, Y1).

lab_two:- repeat, writeln("введите число"), read(C), C >= 0, !, fib(C, Y), writeln(Y), fail.

fib(X, F):- X < 0, fail.
fib(0, F):- F is 1, !.
fib(1, F):- F is 1, !.
fib(X, F):- X > 1, X1 is X - 1, X2 is X - 2, fib(X1, F1), fib(X2, F2), F is F1 + F2.

% [3,7,1,-3,5,8,0,9,2].

lab_three:- writeln("введите список:"), read(S),
writeln("введите первое число:"), read(F),
writeln("введите второе число:"), read(C),
splitter(S, F, C, V, G, A), writeln(V), writeln(G), writeln(A).

splitter([G|T], A, B, [G|T1], O2, O3):-G < A, splitter(T, A, B, T1, O2, O3).
splitter([G|T], A, B, O1, [G|T2], O3):-G >= A, G < B, splitter(T, A, B, O1, T2, O3).
splitter([G|T], A, B, O1, O2, [G|T3]):-G >= B, splitter(T, A, B, O1, O2, T3).
splitter([], _, _, [], [], []).

lab_four:-
	writeln('Введите список: '), read(L),
	repeating_num(L, L_new, _),
	writeln('Результат: '), writeln(L_new).

repeating_num([], [], 0) :- !.

repeating_num([H | T], L_res, Max) :- 
	delete(T, H, L_temp),
	length([H | T], LenL),
	length(L_temp, LenL_temp),
	Max_temp is LenL - LenL_temp,
	repeating_num(L_temp, L_new, Max_compare),
	(Max_temp > Max_compare -> % if
		(L_res = [H], Max is Max_temp);  % true
		(Max is Max_compare,
		(Max_temp =:= Max_compare ->  % false
			L_res = [H | L_new]; 
			L_res = L_new))
	).