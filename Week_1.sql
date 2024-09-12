
-- WYKŁAD:

-- I
-- Wybór kolumn - ćwiczenia

-- 1. Wybierz nazwy i adresy wszystkich klientów

select ContactName, Address, City, Region, PostalCode, Country from Customers;

-- 2. Wybierz nazwiska i numery telefonów pracowników

select LastName, HomePhone from Employees;

-- 3. Wybierz nazwy i ceny produktów

select ProductName, UnitPrice from Products;

-- 4. Pokaż wszystkie kategorie produktów (nazwy i opisy)

select * from Products;

-- 5. Pokaż nazwy i adresy stron www dostawców

select CompanyName, Address, City, Region, PostalCode, Country from Suppliers;

-- II
-- Wybór wierszy — ćwiczenia

-- 1. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie

select CompanyName, Address from Customers where City='London';

-- 2. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w
-- Hiszpanii

select CompanyName, Address from Customers where Country='France' or Country='Spain'
select CompanyName, Address from Customers where Country in ('France', 'Spain');

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00

SELECT ProductName, UnitPrice from Products where UnitPrice between 20.00 and 30.00;

-- 4. Wybierz nazwy i ceny produktów z kategorii 'Meat/Poultry'

select ProductName, UnitPrice from Products where CategoryID = (
    select CategoryID from Categories where CategoryName='Meat/Poultry'
);

-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych
-- przez firmę ‘Tokyo Tradersʼ

select ProductName, UnitsInStock from Products where SupplierID = (
    select SupplierID from Suppliers where CompanyName='Tokyo Traders'
);

-- 6. Wybierz nazwy produktów których nie ma w magazynie

select ProductName from Products where UnitsInStock = 0;

-- III
-- Porównywanie napisów — ćwiczenia

-- 1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottleʼ)

select * from Products where QuantityPerUnit like '%bottle%';

-- 2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na
-- literę z zakresu od B do L

select Title from Employees where LastName like '[b-l]%';

-- 3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na
-- literę B lub L

select Title from Employees where LastName like 'b%' or LastName like 'l%';

-- 4. Znajdź nazwy kategorii, które w opisie zawierają przecinek

select CategoryName from Categories where [Description] like '%,%';

-- 5. Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo 'Store'

select CompanyName from Customers where CompanyName like '%store%';

-- IV
-- Zakres wartości — ćwiczenia

-- 1. Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20

select * from Products where UnitPrice <=10 or UnitPrice >= 20;

-- 2. Wybierz zamówienia złożone w 1997 roku

select * from Orders where OrderDate like '%1997%';

select * from Orders where YEAR(OrderDate) = 1997;

-- 3. Wybierz zamówienia złożone w latach: 1997 do 1998

select * from Orders where YEAR(OrderDate) = 1997 or YEAR(OrderDate) = 1998;

-- V
-- Ćwiczenie

-- 1. Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer
-- klienta dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy
-- jest Argentyna

select OrderID, OrderDate, CustomerID from Orders where ShippedDate is NULL and ShipCountry = 'Argentina';

-- VI
-- ORDER BY — ćwiczenia

-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach
-- danego kraju nazwy firm posortuj alfabetycznie

select CompanyName, Country from Customers order by Country, CompanyName;

-- 2. Wybierz nazwy i kraje wszystkich klientów mających siedziby we Francji lub w
-- Hiszpanii, wyniki posortuj według kraju, w ramach danego kraju nazwy firm posortuj
-- alfabetycznie

select CompanyName, Country from Customers where Country in ('Spain', 'France') order by Country, CompanyName;

-- 3. Wybierz zamówienia złożone w 1997 r. Wynik po sortuj malejąco wg numeru
-- miesiąca, a w ramach danego miesiąca rosnąco według ceny za przesyłkę

select * from Orders where YEAR(OrderDate) = 1997 order by MONTH(OrderDate) desc, Freight;

-- VII
-- Ćwiczenie

-- 1. Napisz polecenie, które oblicza wartość każdej pozycji zamówienia o numerze 10250

select UnitPrice*Quantity-Discount from [Order Details] where [OrderID] = (
    select OrderID from Orders where OrderID = 10250
);

-- jeśli chodzi o sumę

select SUM(UnitPrice*Quantity-Discount) from [Order Details] where [OrderID] = (
    select OrderID from Orders where OrderID = 10250
);

-- 2. Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę
-- zawierającą nr telefonu i nr faksu w formacie (numer telefonu i faksu mają być
-- oddzielone przecinkiem)

select Phone + ',' + Fax as 'Phone, Fax' from Suppliers;
