# Erlang - Lekcja 1
2025y. Franciszek Kaniewski, UMK

## 1. Zalety erlanga
- Filozofia <b>Let is crash</b>
- Skalowalność
- Prostota dystybucji
- Responsywność
- <b>Hot code swapping</b>
- <b>Eliksir</b>

[Więcej tutaj 😀](https://favtutor.com/articles/whatsapp-discord-and-the-secret-to-handling-millions-of-concurrent-users/)

## 2. Shell
W Erlangu REPL(Read–Eval–Print Loop) nazywa się powłoką Erlanga i uruchamia się ją komendą:
```
erl
```
przykład:
```
1> 2 + 3.
5
2> lists:reverse([1,2,3]).
[3,2,1]
```
### Najważniejsze polecenia w powłoce
`q().` - Wyjście z powłoki  
`help().` - Lista komend    
`h()` - Wyświetla ostatnie 20 poleceń z konsoli   
`c(Module).` - Kompiluje moduł Module.erl w bieżącym katalogu   
`l(Module).` - Przeładowuje moduł   
`f().` - Czyści wszystkie zmienne z powłoki    
`f(x).` - Czyści tylko zmienną X    
`i().` - Listuje działające procesy    
`regs().` - Listuje zarejestrowane procesy  
`halt().` - Twarde wyjście bez cleanup  

### Flagi uruchomieniowe powłoki
`erl -s Module Function` - Uruchamia funkcję po starcie 
`erl -pa Path` - Dodaje ścieżkę do kodu (np. /ebin)     
`erl -noshell` - Uruchamia bez interaktywnej powłoki    
`erl -detached` - Uruchamia w tle jak usługę    
`erl -name node@host` - Włącza tryb rozproszony (nazwa węzła)   

## 3. Zmienne
 - Single assigment
 ```
 A = 20.

 A = 10. % **exception error: no match of right hand side value 10
 A = A + 1. % **exception error: no match of right hand side value 21
 ```
 - Integers:    
    - `10 ` 
    - `-234  `  
	- `16#AB10F`    
	- `2#110111010`     
	- `$A`  - Kod ASCII
- Floats
	 - `17.368`
	 - `-56.654` 
	 - `12.34E-10.`
 ```
1> 10 / 3.
3.3333333333333335

2> 10 dim 3.
3

3> 10 rem 3.
1
 ```
## Atom
Atom to etykieta lub symbol – coś, co nazywa rzecz, stan lub typ, ale nie przechowuje danych jak string czy liczba, tylko adres.     
Jest niezmienny i unikalny w całym programie.   
Można go używać do oznaczania statusów, typów wiadomości, kluczy w mapach.  
Coś jak Enum.       

Deklaracja:
```
1> ok.
ok

2> start_with_a_lower_case_letter.
start_with_a_lower_case_letter

3> 'Mój Atom! !#@$%^ \n' %Jeśli chcemy zacząć z wielkiej litery i/lub mieć znaki speclane/białe.
'Mój Atom! !#@$%^ \n'
```

## Tuples
Krotka(Tuple) to zbiór elementów umieszczonych razem w jednym obiekcie.     
Elementy mogą być różnych typów (liczby, stringi, atomy, listy, krotki).    
Krotki mają stałą długość i są indeksowane od 1.    

```
T1 = {1, 2, 3}.               % tylko liczby
T2 = {ok, 42, "hello"}.       % atom + liczba + string
T3 = {{1,2}, [3,4], "Erlang"}. % krotka zawiera listę i inną krotkę
```
Wyciąganie danych z Tuples  

- funkcja element:
```
1> Student1 = {student, 1, "Jan", "Kowalski", 4.5, [4,4,4,5,5,5]}.
{student,1,"Jan","Kowalski",4.5,[4,4,4,5,5,5]}

2> element(1, Student1).
student

3> element(4, Student1).
"Kowalski"
```

 - przypisanie do zmiennych:
```
{DataTypeAtom,Id,Name,Surrname,AVG,Marks} = Student1. % DataTypeAtom = student, Id = 1, Name = "Jan", itd...
{student,1,"Jan","Kowalski",4.5,[4,4,4,5,5,5]}

{student,_,_,_,_,Student1Marks} = Student1. % Student1Marks = [4,4,4,5,5,5]
{student,1,"Jan","Kowalski",4.5,[4,4,4,5,5,5]}
```

## Listy
Lista w Erlangu to uporządkowana kolekcja elementów dowolnego typu, zapisana w nawiasach kwadratowych [], w której elementy można łatwo dodawać na początek i przetwarzać za pomocą pattern matchingu.		

Mogą przechowywać dowolne typy danych.  
Mogą być puste: [].  
Mają łatwy dostęp do pierwszego elementu (Head) i reszty (Tail) – dzięki pattern matchingowi.  

```
1> [1,2,3,4,5].
[1,2,3,4,5]

2> [{person, "Jan","Kowalski"},{person, "Kamil","Kowalski"}, 3, atom].
[{person, "Jan","Kowalski"},{person, "Kamil","Kowalski"}, 3, atom]
```

Wyciąganie danych z Listy

```
1> List = [1,2,3,4].
[1,2,3,4]

2> [Head | Tail] = List. % Head = 1, Tail = [2,3,4]
[1,2,3,4]

3> [One, Two, Tree, Four | R] = List. %  One = 1, Two = 2, Tree = 3, Four = 4, R = []                         
[1,2,3,4]

3> [A, _, _, B | C] = List. %  One = 1, B = 4, C = []                        
[1,2,3,4]
```

Jak tego nie robić:
```
1> List[1] % ERROR
2> element(1,List) % ERROR
```

W erlangu nie ma typu string
```
1> "abc" = [97,98,99].
"abc"
```

Łączenie list:
```
1> [1,2,3,4] ++ [5,6,7,8].
[1,2,3,4,5,6,7,8]

2> "ala " ++ "ma " ++ "kota".
"ala ma kota"
```

Porównywanie list:
```
1> [1,2,3,4] = [1,2,3,4]. % OK
[1,2,3,4]

2> [{person, "Jan", "Kowalski"},2,3,4] = [{person, "Jan", "Kowalski"},2,3,4]. % OK
[{person,"Jan","Kowalski"},2,3,4]

3> "abc" = [97,98,99]. % OK
"abc"

4> [2,3,4,1] = [1,2,3,4]. % ERROR
** exception error: no match of right hand side value [1,2,3,4]
```

## Mapy
Mapy w Erlangu to struktura danych przechowująca pary klucz–wartość, podobnie jak słownik w Pythonie czy obiekt w JavaScript.
Służą do przechowywania danych uporządkowanych według nazwy klucza.

```
1> Student1 = #{name => "Jan", surname => "Kowalski", age => 12}.
#{name => "Jan",surname => "Kowalski",age => 12}

2> Student2 = #{[1,2,3] => "Jan", {20,"Surname"} => "Kowalski", atom => 21}.
#{atom => 21,{20,"Surname"} => "Kowalski",[1,2,3] => "Jan"}
```
Wartości i klucze mogą być dowolnego typu.

Pobieranie wartości z mapy
```
1> maps:get(name, Student1).
"Jan"
```

Zmiana mapy:
```
1> NewStudent1 = Student1#{marks => [4,2,3]}.
#{name => "Jan",surname => "Kowalski",age => 12, marks => [4,2,3]}

2> NewStudent2 = Student1#{marks => [5,5,5]}.
#{name => "Jan",surname => "Kowalski",age => 12, marks => [5,5,5]}
```

# Funkcje 4
Wbudowane Funckje (BIFs):  
- `date()  `
- `time()`  
- `length([1,2,3,4,5])`  
- `size({a,b,c})`  
- `atom_to_list(an_atom)`  
- `list_to_tuple([1,2,3,4])`  
- `integer_to_list(2234)`  
- `tuple_to_list({})`  

```
1> fn() -> "Hello World!".
ok

2> add(A,B) -> A+B.
ok
```

## Moduły / Pliki BEAM
Funkcie wygodnie pisać w plikach .erl któr za pomocą `c(FILE.erl)` można skompilować do pliku BEAM

1. Erlang kompiluje plik to .beam  

2. Podczas wywołania funkcji `hello:sayHello().` VM szuka modułu `hello` z funkcją `sayHello()` <br>
jeśli istnieje taka potrzeba Erlang może wymieniać moduły na żywo bez zatrzymywania programu.  

3. Każdy moduł działa w procesach Erlanga.  
Każdy proces ma własny stos i stertę – nie ma wspólnej pamięci.  
To oznacza, że moduły są bezpieczne współbieżnie.  

Wbudowane Moduły i ich przydatne funkcje:
1. erlang
 - `spawn/1`, `spawn/3` - Tworzy nowy proces `erlang:spawn(fun() -> io:format("Hi") end).`
 - `self/0`	Zwraca PID bieżącego procesu	`erlang:self().`
 - `send/2` (!)	Wysyła wiadomość do procesu	`Pid ! {hello, world}.`
 - `now/0` /system_time/0 Pobiera aktualny czas	`erlang:system_time().`
 - `tuple_size/1` Zwraca długość tuple `erlang:tuple_size({a,b,c}).`
2. io
- `io:format/2` Wyświetla sformatowany tekst `io:format("Hello ~p~n", [42]).`
- `io:puts/1` Wyświetla tekst z nową linią `io:puts("Hello World").`
- `io:get_line/1` Pobiera linię od użytkownika `io:get_line("Enter your name: ").`
3. lists
- `lists:map/2` Funkcja mapująca `lists:map(fun(X) -> X*2 end, [1,2,3]). → [2,4,6]`
- `lists:filter/2` Filtruje listę wg predykatu `lists:filter(fun(X) -> X > 2 end, [1,2,3,4]). → [3,4]`
- `lists:reverse/1` Odwraca listę `lists:reverse([1,2,3]). → [3,2,1]`
- `lists:foldl/3` Fold (redukcja) od lewej `lists:foldl(fun(X,Acc)->X+Acc end,0,[1,2,3]). → 6`
4. string
- `string:to_upper/1` Zamienia na wielkie litery `string:to_upper("hello"). → "HELLO"`
- `string:to_lower/1` Zamienia na małe litery `string:to_lower("HELLO"). → "hello"`
- `string:split/2` Dzieli string wg separatora `string:split("a,b,c", ","). → ["a","b","c"]`
5. maps
- `maps:get/2` Pobiera wartość po kluczu `maps:get(key, #{key => 42}). → 42`
- `maps:put/3` Dodaje/aktualizuje wpis `maps:put(age, 25, #{name => "Alice"}). → #{name => "Alice", age => 25}`
- `maps:remove/2` Usuwa klucz `maps:remove(name, #{name => "Alice", age => 25}). → #{age => 25}`
6. timer
- `timer:sleep/1` Zatrzymuje proces na milisekundy `timer:sleep(1000).`
- `timer:tc/1` Mierzy czas wykonania funkcji `timer:tc(fun() -> lists:sum([1,2,3]) end).`
7. os
- `os:type/0` Typ systemu OS `os:type(). → {unix, linux}`
- `os:getenv/1` Pobiera zmienną środowiskową `os:getenv("HOME").`

Tworzenie modułow:  
Moduły można tworzyć w plikach .erl

hello.erl :
```
-module(hello).
-export([start/0]).

sayHello() -> 
    io:format("Hello world!~n").
```

kompilacja modułu
```
c(hello)
```

wykonanie funkci sayHello
```
1> hello:sayHello().
Hello world!
ok
```

Możemy zdefiniować jak funkcja ma się zachować dla poszczegółnych argumentów (Po dajemy ";"!)
```
-module(calculator).
-export([myDiv/2]).

myDiv(N,0) -> io:format("Nie dziel przez 0! Błąd:~B/0~n", [N]);
myDiv(N,M) -> N/M.
```

### Funkcje prywatne

```
-module(hello).
-export([visitUser/0]).

visitUser() ->
    io:format("Podaj imię: "),
    UserInput = io:get_line(""),
    UserName = string:trim(UserInput),
    sayHello(UserName).

sayHello(Name) ->
    io:format("Hello ~s!~n", [Name]).
```

```
1> hello:visitUser().
Jan
Hello Jan!
ok

2> hello:sayHello("Jan").
** exception error: undefined function hello:sayHello/1
```

# If i Case
Case i if działają podobie do innych języków programowania

If:
```
if
    Condition 1 ->
        Action 1;
    Condition 2 ->
        Action 2;
    Condition 3 ->
        Action 3;
    Condition 4 ->
        Action 4
end
```
```
if
    A == 5 ->
        io:format("A == 5~n", []),
        a_equals_5;
    B == 6 ->
        io:format("B == 6~n", []),
        b_equals_6;
    A == 2, B == 3 ->                      %That is A equals 2 and B equals 3
        io:format("A == 2, B == 3~n", []),
        a_equals_2_b_equals_3;
    A == 1 ; B == 7 ->                     %That is A equals 1 or B equals 7
        io:format("A == 1 ; B == 7~n", []),
        a_equals_1_or_b_equals_7
end.
```

Case:
```
case Number of
    0 -> "zero";
    1 -> "jeden";
    _ -> "inna_liczba"
end
```

Porównania:
```
	number(X)	- X is a number
	integer(X)	- X is an integer
	float(X)	- X is a float
	atom(X)		- X is an atom
	tuple(X)	- X is a tuple
	list(X)		- X is a list
	
	length(X) == 3	- X is a list of length 3
	size(X) == 2	- X is a tuple of size 2.
	
	X > Y + Z	- X is > Y + Z
	X == Y		- X is equal to Y
    X /= Y		- X is not equal to Y
	X =:= Y		- X is exactly equal to Y
	            (i.e. 1 == 1.0 succeeds but 1 =:= 1.0 fails)
```

### Ćwiczenia
1. Napisz moduł kalkulatora z funkacjami, add/2, subtract/2, multiply/2, divide/2.
2. Napisz moduł z funkcją Fibonacci-ego.
3. Napisz moduł z funkcją sumującą wszystkie elementy listy.
4. Napisz moduł z funkcja która przyjmie miesiąc i rok i powie ile dni ma dany miesiąc. (Lata przestępne to takie które są podzielne przez 4 i nie dzielą się na 100 z wyjątkiem takich które dzielą się przez 400).

# 5 Procesy
Procesy w Erlangu to lekkie, współbieżne jednostki wykonawcze, które są podstawą programowania równoległego i odpornego na błędy w tym języku. Każdy proces posiada własną pamięć i kolejkę wiadomości, dzięki czemu nie współdzieli stanu z innymi procesami. Komunikacja między procesami odbywa się asynchronicznie poprzez wysyłanie i odbieranie wiadomości (ang. message passing).

Procesy w Erlangu:
- są bardzo lekkie – można uruchomić ich setki tysięcy,
- są niezależne – awaria jednego nie zatrzymuje reszty,
- komunikują się tylko przez wysyłanie wiadomości,

```
-module(simple_process).
-export([start/0, worker/0]).

start() ->
    Pid = spawn(simple_process, worker, []),
    Pid ! {self(), "Hello from main process"},
    receive
        {Pid, Reply} ->
            io:format("Otrzymano odpowiedź: ~p~n", [Reply])
    end.

worker() ->
    receive
        {Sender, Message} ->
            io:format("Worker otrzymał: ~p~n", [Message]),
            Sender ! {self(), "Dzięki za wiadomość!"}
    end.
```

```
    receive
        ...
    end.
```
program oczekuje na wiadomość  
`Pid ! {self(), "Hello from main process"},` - self() wysyła wiadomość asynchronicznie do Pid.
