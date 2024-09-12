-- Ćwiczenia

-- 1.Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy

select ProductName, UnitPrice, Suppliers.Address, Suppliers.City, Suppliers.Country 
from Products 
join Suppliers ON Products.SupplierID = Suppliers.SupplierID 
where Products.UnitPrice between 20.00 and 30.00

-- 2.Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’

select ProductName, UnitsInStock from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID where Suppliers.CompanyName like '%Tokyo%'

-- 3.Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe

select Customers.Address, Customers.City, Customers.Country 
from Customers left join Orders ON Orders.CustomerID = Customers.CustomerID and YEAR(Orders.OrderDate) = 1997 where Orders.OrderID is null;

-- 4.Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie  ma w magazynie.

select Suppliers.CompanyName, Suppliers.Phone from Products join Suppliers on Suppliers.SupplierID = Products.SupplierID where Products.UnitsInStock = 0;

-- 5.Wybierz zamówienia złożone w marcu 1997. Dla każdego takiego zamówienia wyświetl jego numer, datę złożenia zamówienia oraz nazwę i numer telefonu klienta

select Orders.OrderID, Orders.OrderDate, Customers.CompanyName, Customers.Phone
from Orders join Customers on Orders.CustomerID = Customers.CustomerID where YEAR(Orders.OrderDate) = 1997 and MONTH(Orders.OrderDate) = 3;

-- Ćwiczenia c.d.

-- 1.Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). 
-- Interesuje nas imię, nazwisko i data urodzenia dziecka.

SELECT member.firstname, member.lastname, juvenile.birth_date from juvenile join member on member.member_no = juvenile.member_no;

-- 2.Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek

select title.title from copy join title on title.title_no = copy.title_no where copy.on_loan = 'Y' group by title.title;

-- 3.Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’.  
-- Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę

select loanhist.in_date, DATEDIFF(DAY, loanhist.out_date, loanhist.in_date) as dayssss, loanhist.fine_paid 
from loanhist join title on title.title_no = loanhist.title_no where title.title like '%Tao%' and loanhist.fine_paid is not NULL