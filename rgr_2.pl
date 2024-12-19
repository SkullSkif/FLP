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

rgr2 :- print_reverseLinesOfFile.
