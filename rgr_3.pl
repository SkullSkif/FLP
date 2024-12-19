
:- dynamic toy/2.

% Инициализация базы данных из файла
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

% Сохранение базы данных в файл
save_database :-
    tell('toys.db'),
    listing(toy/2),
    told.

% Просмотр содержимого базы данных
view_db :-
    writeln('Содержимое базы данных:'),
    forall(toy(Name, Price), format('~w - ~w рублей~n', [Name, Price])).

add_toys :-
    writeln('Введите название и стоимость игрушек (в формате "Название Стоимость"). Для завершения введите "end".'),
    repeat,
    read_line_to_string(user_input, Input),
    (   Input == "end"
    ->  !  % завершает repeat, возвращает в меню
    ;   split_string(Input, " ", "", [NameStr, PriceStr]),
        atom_string(Name, NameStr),
        atom_number(PriceStr, Price),
        assertz(toy(Name, Price)),  % добавление игрушки
        fail  % продолжает цикл
    ).

% Удаление записей
remove_toys :-
    writeln('Введите название игрушек для удаления (в формате "Название1 Название2 ..."). Для завершения введите "end".'),
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

% Выполнение запроса
query_cheapest :-
    findall(Price, toy(_, Price), Prices),
    min_list(Prices, MinPrice),
    MaxPrice is MinPrice + 100,
    writeln('Самые дешевые игрушки:'),
    forall((toy(Name, Price), Price =< MaxPrice, Price >= MinPrice), format('~w - ~w рублей~n', [Name, Price])).

menu :-
    writeln('Главное меню:'),
    writeln('1. Просмотр содержимого базы данных'),
    writeln('2. Добавление новых игрушек'),
    writeln('3. Удаление записей'),
    writeln('4. Поиск самых дешевых игрушек'),
    writeln('5. Выход'),
    read(Choice),
    handle_choice(Choice),
    menu.  % возвращается обратно в меню

handle_choice(1) :- view_db.
handle_choice(2) :- add_toys.
handle_choice(3) :- remove_toys.
handle_choice(4) :- query_cheapest.
handle_choice(5) :- save_database, writeln('Выход из программы.'), halt.
handle_choice(_) :- writeln('Неверный выбор, попробуйте еще раз.'), fail.

% Запуск программы
start :-
    load_database,
    menu.
