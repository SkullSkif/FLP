
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

reverseLinesOfFile(In, Out) :-
    repeat,
    read_line_to_string(In, S),
    (S == end_of_file, !;
    reverseLinesOfFile(In, Out),
    writeln(Out, S), fail).

print_reverseLinesOfFile :-
    format('~nВведите название входного файла (Файл должен находиться в директории программы и иметь расширение .txt) ~n'), read(I),
    format('~nВведите название выходного файла (Файл будет находиться в директории программы и иметь расширение .txt) ~n'), read(O),
    concat(I, '.txt', Input),
    concat(O, '.txt', Output),
    open(Input, read, In),
    open(Output, write, Out),
    reverseLinesOfFile(In, Out),
    close(In),
    close(Out).

t2 :- print_reverseLinesOfFile.

