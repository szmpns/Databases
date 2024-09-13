-- zad 1)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Za datę obsłużenia
-- zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać nazwę
-- klienta, imię i nazwisko pracownika oraz liczbę obsłużonych zamówień. (baza
-- northwind)

-- zad 2)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
-- obsłużonych przez każdego pracownika w lutym 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień. (baza northwind)

select e.FirstName, e.LastName, COALESCE(COUNT(o.OrderID), 0) as liczba_obsl, COALESCE(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)), 0) as laczna_wartosc from Employees e 
left join Orders o on e.EmployeeID = o.EmployeeID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=2 left join [Order Details] od on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

--JAKO SUMA

select e.FirstName, e.LastName, COALESCE(COUNT(o.OrderID), 0) as liczba_obsl, COALESCE(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) + SUM(o.Freight), 0) as laczna_wartosc from Employees e 
left join Orders o on e.EmployeeID = o.EmployeeID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=2 left join [Order Details] od on od.OrderID = o.OrderID
group by e.FirstName, e.LastName 

-- zad 3)
-- Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14'
-- zwróciły do biblioteki książkę o tytule 'Walking'. Zbiór wynikowy powinien zawierać
-- imię i nazwisko oraz dane adresowe dziecka. (baza library)

select m.firstname, m.lastname, a.street, a.city, a.[state], a.zip from member m 
join juvenile j on j.member_no = m.member_no join adult a on a.member_no = j.adult_member_no 
join loanhist lh on lh.member_no = m.member_no join title t on t.title_no = lh.title_no
where t.title='Walking' and YEAR(lh.in_date)=2001 and MONTH(lh.in_date)=12 and DAY(lh.in_date)=14

-- zad 1)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (bez opłaty za przesyłkę)
-- obsłużonych przez każdego pracownika w marcu 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień, oraz datę najpóźniejszego zamówienia
-- (w badanym okresie). (baza northwind)

select e.FirstName, e.LastName, COALESCE(COUNT(o.OrderID), 0) as ilosc_obsl, COALESCE(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)), 0) as wartosc_obsl,
MAX(o.OrderDate) as najp
from Employees e 
left join Orders o on o.EmployeeID = e.EmployeeID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=3 
join [Order Details] od on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

-- zad 2)
-- Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14' nie
-- zwróciły do biblioteki książki o tytule 'Walking'. Zbiór wynikowy powinien zawierać
-- imię i nazwisko oraz dane adresowe dziecka. (baza library)

select distinct m.firstname, m.lastname, a.street, a.city, a.[state], a.zip from member m 
join juvenile j on j.member_no = m.member_no join adult a on a.member_no = j.adult_member_no  join loanhist lh on lh.member_no = m.member_no 
join title t on t.title_no = lh.title_no 
where YEAR(lh.in_date)=2001 and MONTH(lh.in_date)=12 and DAY(lh.in_date)=14 and t.title not like 'Walking'

--to wyzej lepsze ma distinct

select m.firstname, m.lastname, a.street, a.city, a.[state], a.zip from member m 
join juvenile j on j.member_no = m.member_no join adult a on a.member_no = j.adult_member_no join loanhist lh on lh.member_no = m.member_no 
join title t on t.title_no = lh.title_no
where YEAR(lh.in_date)=2001 and MONTH(lh.in_date)=12 and DAY(lh.in_date)=14 and t.title not like 'Walking'

-- zad 3)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Zbiór wynikowy
-- powinien zawierać nazwę klienta, imię i nazwisko pracownika oraz liczbę
-- obsłużonych zamówień. (baza northwind)

SELECT 
    c.CompanyName AS NazwaKlienta,
    e.FirstName AS ImiePracownika,
    e.LastName AS NazwiskoPracownika,
    COUNT(o.OrderID) AS LiczbaZamowien
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    Employees e ON o.EmployeeID = e.EmployeeID
WHERE 
    YEAR(o.OrderDate) = 1997
GROUP BY 
    c.CompanyName,
    e.FirstName,
    e.LastName,
    c.CustomerID
HAVING 
    COUNT(o.OrderID) = (
        SELECT 
            MAX(zamowienia)
        FROM (
            SELECT 
                COUNT(OrderID) AS zamowienia
            FROM 
                Orders
            WHERE 
                CustomerID = c.CustomerID
                AND YEAR(OrderDate) = 1997
            GROUP BY 
                EmployeeID
        ) AS subquery
    )

-- zad 1)
-- Podaj tytuły książek zarezerwowanych przez dorosłych członków biblioteki
-- mieszkających w Arizonie (AZ). Zbiór wynikowy powinien zawierać imię i nazwisko
-- członka biblioteki, jego adres oraz tytuł zarezerwowanej książki. Jeśli jakaś osoba
-- dorosła mieszkająca w Arizonie nie ma zarezerwowanej żadnej książki to też
-- powinna znaleźć się na liście, a w polu przeznaczonym na tytuł książki powinien
-- pojawić się napis BRAK. (baza library)

select COUNT(*) from adult where [state]='AZ'

select m.firstname, m.lastname, a.street, a.city, a.[state], COALESCE(t.title, 'BRAK') from adult a 
left join reservation r on r.member_no = a.member_no join member m on m.member_no = a.member_no left join item i on i.isbn = r.isbn left join title t on t.title_no = i.title_no
where a.[state]='AZ'

-- zad 2)
-- Pokaż nazwy produktów, kategorii 'Beverages' które nie były kupowane w okresie
-- od '1997.02.20' do '1997.02.25' Dla każdego takiego produktu podaj jego nazwę,
-- nazwę dostawcy (supplier), oraz nazwę kategorii. Zbiór wynikowy powinien
-- zawierać nazwę produktu, nazwę dostawcy oraz nazwę kategorii. (baza northwind)

select distinct p.ProductName, s.CompanyName, c.CategoryName from Products p 
left join [Order Details] od on od.ProductID = p.ProductID 
left join Orders o on o.OrderID = od.OrderID and o.OrderDate BETWEEN '1997-02-20' and '1997-02-25'join Suppliers s on s.SupplierID = p.SupplierID
join Categories c on c.CategoryID = p.CategoryID
where o.OrderID is NULL and c.CategoryName='Beverages'

-- zad 3)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
-- złożonych przez każdego klienta w lutym 1997. Jeśli klient nie złożył w tym okresie
-- żadnego zamówienia, to też powinien pojawić się na liście (liczba złożonych
-- zamówień oraz ich wartość jest w takim przypadku równa 0). Zbiór wynikowy
-- powinien zawierać: nazwę klienta, liczbę obsłużonych zamówień, oraz wartość
-- złożonych zamówień. (baza northwind)

select c.CompanyName, COUNT(o.OrderID) as liczba_zam, COALESCE(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) + SUM(o.Freight), 0) from Customers c 
left join Orders o on o.CustomerID = c.CustomerID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=2 
left join [Order Details] od on od.OrderID = o.OrderID
group by c.CompanyName

--to na gorze jest dobrze

select COUNT(*) from Customers

select c.CompanyName, COALESCE(COUNT(o.OrderID), 0) as liczba_zamowien, COALESCE(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) + SUM(o.Freight), 0) as wartosc_zam from Customers c 
left join Orders o on o.CustomerID = c.CustomerID left join [Order Details] od on od.OrderID = o.OrderID
group by c.CompanyName

-- zad 1)
-- Dla każdego pracownika podaj nazwę klienta, dla którego dany pracownik w 1997r
-- obsłużył najwięcej zamówień, podaj także liczbę tych zamówień (jeśli jest kilku
-- takich klientów to wystarczy podać nazwę jednego nich). Za datę obsłużenia
-- zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać imię i
-- nazwisko pracownika, nazwę klienta, oraz liczbę obsłużonych zamówień. (baza
-- northwind)

-- zad 2)
-- Wyświetl numery zamówień złożonych w od marca do maja 1997, które były
-- przewożone przez firmę 'United Package' i nie zawierały produktów z kategorii
-- "confections". (baza northwind)

select o.OrderID from Orders o join Shippers s on s.ShipperID = o.ShipVia
where o.OrderDate BETWEEN '1997-03-01' and '1997-05-31' and s.CompanyName='United Package'
and 
not exists (
    select * from [Order Details] od join Products p on p.ProductID = od.ProductID join Categories cat on cat.CategoryID = p.CategoryID
    where cat.CategoryName='Confections' and o.OrderID = od.OrderID
)


-- zad 3)
-- Podaj tytuły książek wypożyczonych (aktualnie) przez dzieci mieszkające w Arizonie
-- (AZ). Zbiór wynikowy powinien zawierać imię i nazwisko członka biblioteki
-- (dziecka), jego adres oraz tytuł wypożyczonej książki. Jeśli jakieś dziecko
-- mieszkająca w Arizonie nie ma wypożyczonej żadnej książki to też powinno znaleźć
-- się na liście, a w polu przeznaczonym na tytuł książki powinien pojawić się napis
-- BRAK. (baza library)

select m.firstname, m.lastname, a.street, a.city, a.zip, t.title from member m 
join juvenile j on j.member_no = m.member_no join adult a on a.member_no = j.adult_member_no and a.[state]='AZ' left join loan l on l.member_no = m.member_no
left join title t on l.title_no = t.title_no

-- zad 1)
-- Podaj nazwy produktów które w marcu 1997 nie były kupowane przez klientów z
-- Francji. Dla każdego takiego produktu podaj jego nazwę, nazwę kategorii do której
-- należy ten produkt oraz jego cenę.

select p.ProductName, c.CategoryName, p.UnitPrice from Products p join Categories c on c.CategoryID = p.CategoryID
where not exists(
    select * from [Order Details] od join Orders o on od.OrderID = o.OrderID join Customers cus on cus.CustomerID = o.CustomerID
    where o.OrderDate BETWEEN '1997-03-01' and '1997-03-31' and cus.Country='France'
    and p.ProductID = od.ProductID
)

select * from [Order Details] od join Orders o on od.OrderID = o.OrderID join Customers cus on cus.CustomerID = o.CustomerID
where o.OrderDate BETWEEN '1997-03-01' and '1997-03-31' and cus.Country='France'

-- zad 2)
-- Napisz polecenie które wyświetla imiona i nazwiska dorosłych członków biblioteki,
-- mieszkających w Arizonie (AZ) lub Kalifornii (CA), których wszystkie dzieci są
-- urodzone przed '2000-10-14'

select m.firstname, m.lastname from adult a join member m on m.member_no = a.member_no where (a.[state]='CA' or a.[state]='AZ')
and not exists (
    select * from juvenile j where j.birth_date >= '2000-10-14' and j.adult_member_no = a.member_no
)


select * from juvenile j where j.birth_date >= '2000-10-14'

-- zad 3)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Zbiór wynikowy
-- powinien zawierać nazwę klienta, imię i nazwisko pracownika oraz liczbę
-- obsłużonych zamówień. (baza northwind)

-- pt godz 15.00
-- zad 1)
-- Dla każdego produktu z kategorii 'confections' podaj wartość przychodu za ten
-- produkt w marcu 1997 (wartość sprzedaży tego produktu bez opłaty za przesyłkę).
-- Jeśli dany produkt (należący do kategorii 'confections') nie był sprzedawany w tym
-- okresie to też powinien pojawić się na liście (wartość sprzedaży w takim przypadku
-- jest równa 0) (baza northwind)

select p.ProductName, COALESCE(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)), 0) as wartosc from Products p 
left join [Order Details] od on od.ProductID = p.ProductID left join Orders o on o.OrderID = od.OrderID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=3
join Categories cat on cat.CategoryID = p.CategoryID
where cat.CategoryName='Confections'
group by p.ProductName


-- zad 2)
-- Podaj tytuły książek, które nie są aktualnie zarezerwowane przez dzieci mieszkające
-- w Arizonie (AZ). (baza library)

select distinct t.title from title t join item i on i.title_no = t.title_no
where i.isbn not in (
    select r.isbn from reservation r join member m on m.member_no = r.member_no join juvenile j on j.member_no = m.member_no join adult a on a.member_no = j.adult_member_no
    where a.[state]='AZ'
)

-- zad 3)
-- Dla każdego przewoźnika podaj nazwę produktu z kategorii 'Seafood', który ten
-- przewoźnik przewoził najczęściej w kwietniu 1997. Podaj też informację ile razy
-- dany przewoźnik przewoził ten produkt w tym okresie (jeśli takich produktów jest
-- więcej to wystarczy podać nazwę jednego z nich). Zbiór wynikowy powinien
-- zawierać nazwę przewoźnika, nazwę produktu oraz informację ile razy dany produkt
-- był przewożony (baza northwind)

select top 1 with ties s.CompanyName, p.ProductName, COUNT(o.ShippedDate) from Shippers s 
left join Orders o on o.ShipVia = s.ShipperID and YEAR(o.ShippedDate)=1997 and MONTH(o.ShippedDate)=4 join [Order Details] od on od.OrderID = o.OrderID join Products p on p.ProductID = od.ProductID
join Categories cat on cat.CategoryID = p.CategoryID where cat.CategoryName='Seafood'
group by s.CompanyName, p.ProductName
order by RANK() OVER (PARTITION BY s.CompanyName ORDER BY COUNT(*) DESC);

--zad_1

select m.firstname, m.lastname from member m 
join juvenile j on j.member_no = m.member_no 
join adult a on a.member_no = j.adult_member_no
join loanhist lh on lh.member_no = m.member_no and YEAR(lh.in_date)=2001 and MONTH(lh.in_date)=12 and DAY(lh.in_date)=14
join title t on t.title_no = lh.title_no
where t.title='walking'

-- Pokaż nazwy produktów, które nie by z kategorii 'Beverages' które nie były kupowane w
-- okresie od '1997.02.20' do '1997.02.25'. Dla każdego takiego produktu podaj jego nazwę,
-- nazwę dostawcy (supplier), oraz nazwę kategorii.

-- Zbiór wynikowy powinien zawierać nazwę produktu, nazwę dostawcy oraz nazwę kategorii

select p.ProductName, s.CompanyName, cat.CategoryName from Products p 
join Categories cat on p.CategoryID = cat.CategoryID 
left join Suppliers s on s.SupplierID = p.SupplierID
where cat.CategoryName='Beverages' and not exists (
    select * from [Order Details] od join Orders o on od.OrderID = o.OrderID and o.OrderDate BETWEEN '1997-02-20' and '1997-02-25' and p.ProductID = od.ProductID
)

-- Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę) obsłużonych
-- przez każdego pracownika w lutym 1997. Za datę obsłużenia zamówienia należy uznać datę
-- jego złożenia (orderdate). Jeśli pracownik nie obsłużył w tym okresie żadnego zamówienia, to
-- też powinien pojawić się na liście (liczba obsłużonych zamówień oraz ich wartość jest w takim
-- przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień

select e.FirstName, e.LastName, COUNT(o.OrderID) as liczba_obsluzonych, COALESCE(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) + SUM(distinct o.Freight), 0) as wartosc_zamowien
from Employees e 
left join Orders o on o.EmployeeID = e.EmployeeID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=2
left join [Order Details] od on od.OrderID = o.OrderID
group by e.FirstName, e.LastName
