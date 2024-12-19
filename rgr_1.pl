del([], _, []).

del([H|T], H, Res) :-
    !,
    del(T, H, Res).

del([H|T], X, [H|Res]) :-
    del(T, X, Res).

rgr1:-
    writeln("Введите список "), read(List),
    writeln("Введите удаляемый элемент "), read(D),
	del(List, D, List_new), writeln("Результат "),writeln(List_new).
