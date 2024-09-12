-- Ćwiczenie

-- 1. Podaj liczbę produktów o cenach mniejszych niż 10 lub większych niż 20
select COUNT(*) as liczba_poruktow from Products where UnitPrice < 10 OR UnitPrice > 20
-- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20
select MAX(UnitPrice) as maksymalna_cena from Products where UnitPrice < 20
-- 3. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
select MAX(UnitPrice) as max, MIN(UnitPrice) as min, AVG(UnitPrice) as avg from Products where QuantityPerUnit like '%bottle%'
-- 4. Wypisz informację o wszystkich produktach o cenie powyżej średniej
select * from Products where UnitPrice > (select AVG(UnitPrice) from Products)
-- 5. Podaj sumę/wartość zamówienia o numerze 10250
select SUM(UnitPrice*Quantity*(1-Discount)) as suma_za_zamownienie from [Order Details] where OrderID=10250

-- Ćwiczenia

-- 1. Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
select OrderID, MAX(UnitPrice) as max from [Order Details] group by OrderID
-- 2. Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice) DESC 
-- 3. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
select OrderID, MAX(UnitPrice) as max, MIN(UnitPrice) as min from [Order Details] GROUP by OrderID 
-- 4. Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
select ShipVia, COUNT(*) as liczba_zamowien from Orders group by ShipVia
-- 5. Który ze spedytorów był najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia, COUNT(*) AS shipped_in_1997 
FROM Orders 
WHERE YEAR(ShippedDate) = 1997 
GROUP BY ShipVia
ORDER BY COUNT(*) DESC;

-- Ćwiczenia

-- 1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
select OrderID, COUNT(ProductID) as rozne_pozycje from [Order Details] group by OrderID having COUNT(ProductID) > 5
-- 2. Wyświetl  klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień 
-- (wyniki posortuj malejąco wg  łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
select CustomerID, COUNT(ShippedDate) as liczba_zamowien, SUM(Freight) as suma
from Orders where YEAR(ShippedDate)=1998 group by CustomerID having COUNT(ShippedDate) > 8 order by SUM(Freight) desc 
