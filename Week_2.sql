--getdate cast

-- I

-- 1.Napisz polecenie select  za pomocą którego uzyskasz identyfikator/numer tytułu oraz tytuł książki

select title_no, title from title;

-- 2.Napisz polecenie, które wybiera tytuł o numerze/identyfikatorze 10

select title from title where title_no=10;

-- 3.Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tyułu) 
-- i autora dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen

select title_no, author from title where author in ('Charles Dickens', 'Jane Austen');

-- II

-- 1.Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich  książek, 
-- których tytuły zawierających słowo 'adventure'

select title_no, title from title where title like '%adventure%';

-- 2.Napisz polecenie, które wybiera numer czytelnika oraz zapłaconą karę dla wszystkich książek, 
-- które zostały zwrócone w listopadzie 2001

select title_no, SUM(fine_paid) as total_fine_paid from loanhist where MONTH(in_date)=11 and YEAR(in_date)=2001 group by title_no having SUM(fine_paid) is not null order by title_no;

-- 3.Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.

select city, [state] from adult group by city, [state] order by city, [state];

-- 4.Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.

select title from title order by title;

-- WYKŁAD 

-- Ćwiczenie

-- 1.Podaj liczbę produktów o cenach mniejszych niż 10 lub większych niż 20

select count(*) from Products where UnitPrice < 10 or UnitPrice > 20;

-- 2.Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20

select MAX(UnitPrice) from Products where UnitPrice < 20;

-- 3.Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)

select MAX(UnitPrice) as max, MIN(UnitPrice) as min, AVG(UnitPrice) as avg from Products where QuantityPerUnit like '%bottle%';

-- 4.Wypisz informację o wszystkich produktach o cenie powyżej średniej

select * from Products where UnitPrice > (select AVG(UnitPrice) from Products);

-- 5.Podaj sumę/wartość zamówienia o numerze 10250

select SUM(UnitPrice * Quantity) as wartosc_zamowienia_1025 from [Order Details] where OrderID=10250;

select (UnitPrice * Quantity) as wartosc_zamowienia_1025 from [Order Details] where OrderID=10250;