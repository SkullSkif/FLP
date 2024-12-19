:- dynamic toy/2.

% ������������� ���� ������ �� �����
load_database :-
    exists_file('toys.db'),
    retractall(toy(_, _)),
    see('toys.db'),
    read_toys,
    seen.

read_toys :-
    read(Toy),
    ( Toy == end_of_file ->
        true
    ;
        assertz(Toy),
        read_toys
    ).

% ���������� ���� ������ � ����
save_database :-
    tell('toys.db'),
    listing(toy/2),
    told.

% �������� ����������� ���� ������
view_db :-
    writeln('���������� ���� ������:'),
    forall(toy(Name, Price), format('~w - ~w ������~n', [Name, Price])).

add_toys :-
    writeln('������� �������� � ��������� ������� (� ������� "�������� ���������"). ��� ���������� ������� "end".'),
    repeat,
    read_line_to_string(user_input, Input),
    (   Input == "end"
    ->  !  % ��������� repeat, ���������� � ����
    ;   split_string(Input, " ", "", [NameStr, PriceStr]),
        atom_string(Name, NameStr),
        atom_number(PriceStr, Price),
        assertz(toy(Name, Price)),  % ���������� �������
        fail  % ���������� ����
    ).

% �������� �������
remove_toys :-
    writeln('������� �������� ������� ��� �������� (� ������� "��������1 ��������2 ..."). ��� ���������� ������� "end".'),
    repeat,
    read_line_to_string(user_input, Input),
    ( Input == "end" -> !
    ; split_string(Input, " ", "", Names),
      forall(member(NameStr, Names),
        ( atom_string(Name, NameStr),
          retractall(toy(Name, _))
        )
      ),
      fail
    ).

% ���������� �������
query_cheapest :-
    findall(Price, toy(_, Price), Prices),
    min_list(Prices, MinPrice),
    MaxPrice is MinPrice + 100,
    writeln('����� ������� �������:'),
    forall((toy(Name, Price), Price =< MaxPrice, Price >= MinPrice), format('~w - ~w ������~n', [Name, Price])).

menu :-
    writeln('������� ����:'),
    writeln('1. �������� ����������� ���� ������'),
    writeln('2. ���������� ����� �������'),
    writeln('3. �������� �������'),
    writeln('4. ����� ����� ������� �������'),
    writeln('5. �����'),
    read(Choice),
    handle_choice(Choice),
    menu.  % ������������ ������� � ����

handle_choice(1) :- view_db.
handle_choice(2) :- add_toys.
handle_choice(3) :- remove_toys.
handle_choice(4) :- query_cheapest.
handle_choice(5) :- save_database, writeln('����� �� ���������.'), halt.
handle_choice(_) :- writeln('�������� �����, ���������� ��� ���.'), fail.

% ������ ���������
start :-
    load_database,
    menu.

