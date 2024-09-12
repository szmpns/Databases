-- Ćwiczenie 1

-- 1. Napisz polecenie select  za pomocą którego uzyskasz identyfikator/numer tytułu oraz tytuł książki
select title_no, title from title
-- 2. Napisz polecenie, które wybiera tytuł o numerze/identyfikatorze 10
select title from title where title_no=10
-- 3. Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tyułu)  i autora dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen
select title_no, author from title where author in ('Charles Dickens', 'Jane Austen')

-- Ćwiczenie 2

-- 1. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich  książek, których tytuły zawierających słowo 'adventure'
select title_no, title from title where title like '%adventure%'
-- 2. Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę dla wszystkich książek, tore zostały zwrócone w listopadzie 2001
select member_no, fine_paid from loanhist where YEAR(in_date)=2001 and MONTH(in_date)=11
-- 3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
select distinct city, [state] from adult
-- 4. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
select title from title group by title

-- Ćwiczenie 3

-- Napisz polecenie, które:

-- 1. wybiera numer członka biblioteki (member_no), isbn książki (isbn) 
-- i wartość naliczonej kary (fine_assessed) z tablicy loanhist  dla wszystkich wypożyczeń/zwrotów, dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed)
select distinct member_no, isbn, fine_assessed from loanhist where fine_assessed is not NULL 
-- 2. stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
select fine_assessed*2 as podwojna_wartosc, fine_assessed from loanhist where fine_assessed is not NULL
-- 3. stwórz alias double_fine dla tej kolumny (zmień nazwą kolumny na double_fine)
select fine_assessed*2 as double_fine, fine_assessed from loanhist where fine_assessed is not NULL
-- 4. stwórz kolumnę o nazwie diff, zawierającą różnicę wartości w kolumnach double_fine i fine_assessed jest większa niż 3
select (2*fine_assessed - fine_assessed) as diff from loanhist where (2*fine_assessed - fine_assessed) > 3

-- Ćwiczenie 4

-- Napisz polecenie, które

-- 1. generuje pojedynczą kolumnę, która zawiera kolumny: 
-- firstname (imię członka biblioteki), 
-- middleinitial (inicjał drugiego imienia) i lastname (nazwisko) z tablicy member dla wszystkich członków biblioteki, którzy nazywają się Anderson
select CONCAT(firstname, ' ', middleinitial, ' ', lastname) as imie_inicjaldr_nazwisko from member where lastname='Anderson'
-- 2. nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla kolumny)
select CONCAT(firstname, ' ', middleinitial, ' ', lastname) as email_name from member where lastname='Anderson'
-- 3. zmodyfikuj polecenie, tak by zwróciło 'listę proponowanych loginów e-mail'
--   utworzonych przez połączenie imienia członka biblioteki, z inicjałem drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko małymi małymi literami).
select LOWER(CONCAT(firstname,middleinitial,LEFT(lastname, 2),'@library.com')) as email_name from member
-- 5. wykorzystaj operator (+) do połączenia napisów.

SELECT LOWER(firstname + middleinitial + SUBSTRING(lastname, 1, 2) + '@library.com') AS email_name
FROM member;

-- Ćwiczenie 5
-- Napisz polecenie, które wybiera title i title_no z tablicy title.
-- wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie poniżej:
-- The title is: Poems, title number 7
-- czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu o wyrażenie, które łączy 4 elementy:
-- stała znakowa ‘The title is:’
-- wartość kolumny  title
-- stała znakowa ‘title number’
-- wartość kolumny title_no

select ('The title is: ' + title + ', title number: ' + STR(title_no)) from title

SELECT 'The title is: ' + title + ', title number: ' + CAST(title_no AS VARCHAR) AS formatted_title
FROM title;
