-- Ćwiczenia

-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
select p.ProductName, p.UnitPrice, s.Address, s.City, s.Region, s.PostalCode, s.Country from Products p join Suppliers s on s.SupplierID = p.SupplierID 
where p.UnitPrice > 20.00 and p.UnitPrice < 30.00
-- 2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
select p.ProductName, p.UnitsInStock from Products p join Suppliers s on s.SupplierID = p.SupplierID where s.CompanyName='Tokyo Traders'
-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
select c.CompanyName, c.Address, c.City, c.Region, c.PostalCode, c.Country from Customers c
left join Orders o on o.CustomerID = c.CustomerID and YEAR(o.OrderDate)=1997 where o.OrderID is null 
-- 4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie  ma w magazynie.
select s.CompanyName, s.Phone from Suppliers s join Products p on p.SupplierID = s.SupplierID where p.UnitsInStock = 0
-- 5. Wybierz zamówienia złożone w marcu 1997. Dla każdego takiego zamówienia wyświetl jego numer, datę złożenia zamówienia oraz nazwę i numer telefonu klienta
select o.OrderID, o.OrderDate, c.CompanyName, c.Phone from Orders o join Customers c on c.CustomerID = o.CustomerID where YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=3

-- Ćwiczenia c.d.

-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko i data urodzenia dziecka.
select m.firstname, m.lastname, j.birth_date from juvenile j left join member m on m.member_no = j.member_no
-- 2. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
select distinct t.title from loan l join title t on t.title_no = l.title_no order by t.title

select distinct t.title from copy c join title t on t.title_no = c.title_no where c.on_loan='Y' order by t.title
-- 3. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’.
-- Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
select lh.in_date, DATEDIFF(day, lh.out_date, lh.in_date) as ile_dni_byla_przetrzymywana, lh.fine_paid from loanhist lh 
join title t on t.title_no = lh.title_no where t.title='Tao Teh King' and lh.fine_paid is not NULL
-- 4. Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
select i.isbn from reservation r join item i on i.isbn = r.isbn join member m on m.member_no = r.member_no
where m.lastname='Graff' and m.middleinitial='A' and m.firstname='Stephen'

-- Ćwiczenia

-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, 
-- dla każdego produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
select p.ProductName, p.UnitPrice, s.Address, s.City, s.Region, s.PostalCode, s.Country from Products p 
join Suppliers s on s.SupplierID = p.SupplierID join Categories c on c.CategoryID = p.CategoryID
where c.CategoryName='Meat/Poultry' and p.UnitPrice > 20.00 and p.UnitPrice < 30.00
-- 2. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
select p.ProductName, p.UnitPrice, s.CompanyName from Products p 
join Categories c on c.CategoryID = p.CategoryID join Suppliers s on s.SupplierID = p.SupplierID
where c.CategoryName='Confections'
-- 3. Dla każdego klienta podaj liczbę złożonych przez niego zamówień. Zbiór wynikowy powinien zawierać nazwę klienta, oraz liczbę zamówień
select c.CompanyName,  COUNT(o.OrderID) as liczba_zamowien from Customers c left join Orders o on c.CustomerID = o.CustomerID
group by c.CompanyName
-- 4. Dla każdego klienta podaj liczbę złożonych przez niego zamówień w marcu 1997r
select c.CompanyName, COUNT(o.OrderID) as liczba_zamowien_w_marcu_1997 from Customers c 
left join Orders o on o.CustomerID = c.CustomerID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=3
group by c.CompanyName

-- Ćwiczenia c.d.

-- 1. Który ze spedytorów był najaktywniejszy w 1997 roku, podaj nazwę tego spedytora
select top 1 s.CompanyName from Shippers s left join Orders o on s.ShipperID = o.ShipVia and YEAR(o.ShippedDate)=1997
group by s.CompanyName order by COUNT(o.OrderID) desc 
-- 2. Dla każdego zamówienia podaj wartość zamówionych produktów. 
-- Zbiór wynikowy powinien zawierać nr zamówienia, datę zamówienia, nazwę klienta oraz wartość zamówionych produktów
select o.OrderID, o.OrderDate, SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) as wartosc_porduktow, c.CompanyName from Orders o 
left join [Order Details] od on od.OrderID = o.OrderID join Customers c on c.CustomerID = o.CustomerID
group by o.OrderID, o.OrderDate, c.CompanyName order by o.OrderID
-- 3. Dla każdego zamówienia podaj jego pełną wartość (wliczając opłatę za przesyłkę). 
-- Zbiór wynikowy powinien zawierać nr zamówienia, datę zamówienia, nazwę klienta oraz pełną wartość zamówienia
select o.OrderID, o.OrderDate, c.CompanyName, SUM(od.Quantity*od.UnitPrice*(1-Discount)) + o.Freight as pelna_suma from Orders o 
left join [Order Details] od on od.OrderID = o.OrderID join Shippers s on s.ShipperID = o.ShipVia join Customers c on c.CustomerID = o.CustomerID
group by o.OrderID, o.OrderDate, c.CompanyName, o.Freight order by o.OrderID

-- Ćwiczenia c.d.

-- 1. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty  z kategorii ‘Confections’
select distinct c.CompanyName, c.Phone from Customers c 
join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on od.OrderID = o.OrderID join Products p on p.ProductID = od.ProductID join Categories cat 
on cat.CategoryID = p.CategoryID where cat.CategoryName='Confections'
-- 2. Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii ‘Confections’
select c.CompanyName, c.Phone from Customers c
where not exists (
    select * from Orders o join [Order Details] od on od.OrderID = o.OrderID join Products p on p.ProductID = od.ProductID join Categories cat 
    on cat.CategoryID = p.CategoryID
    where o.CustomerID = c.CustomerID
    and cat.CategoryName='Confections'
)
-- 3. Wybierz nazwy i numery telefonów klientów, którzy w 1997r nie kupowali produktów z kategorii ‘Confections’
select c.CompanyName, c.Phone from Customers c 
where not exists (
    select * from Orders o join [Order Details] od on od.OrderID = o.OrderID join Products p on p.ProductID = od.ProductID join Categories cat on cat.CategoryID = p.CategoryID
    where c.CustomerID = o.CustomerID and YEAR(o.OrderDate)=1997 and cat.CategoryName='Confections'
)

-- Ćwiczenia c.d.

-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). 
-- Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
select m.member_no, m.firstname, m.lastname, j.birth_date, a.street, a.city, a.[state] from juvenile j 
left join member m on m.member_no = j.member_no join adult a on a.member_no = j.adult_member_no
-- 2. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). 
-- Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.
select m.member_no, m.firstname, m.lastname, a.street, a.city, a.[state], p.firstname as parent_name, p.lastname as parent_lastname from juvenile j 
join member m on m.member_no = j.member_no join adult a on a.member_no = j.adult_member_no
join member p on p.member_no = j.adult_member_no
