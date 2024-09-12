-- Ćwiczenia 1

-- 1. Dla każdego zamówienia podaj jego wartość. Posortuj wynik wg wartości zamówień (w malejęcej kolejności)
select OrderID, SUM(UnitPrice*Quantity*(1-Discount)) as wartosc from [Order Details] group by OrderID ORDER by wartosc desc 
-- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało tylko pierwszych 10 wierszy
select top 10 OrderID, SUM(UnitPrice*Quantity*(1-Discount)) as wartosc from [Order Details] group by OrderID order by wartosc desc 
-- 3. Podaj  nr zamówienia oraz wartość  zamówienia, dla zamówień, dla których łączna liczba zamawianych jednostek produktów jest większa niż 250
select OrderID, SUM(UnitPrice*[Quantity]*(1-Discount)) as wartosc from [Order Details] group by OrderID having SUM(Quantity) > 250
-- 4. Podaj liczbę zamówionych jednostek produktów dla  produktów, dla których productid jest mniejszy niż 3
select ProductID, SUM(Quantity) as liczba_zamowionych from [Order Details] where ProductID < 3 group by ProductID

-- Ćwiczenie 2

-- 1. Ilu jest dorosłych czytekników
select COUNT(member_no) as liczba_czytelnikow from adult
select COUNT(distinct member_no) as liczba_czytelnikow from adult
-- 2. Ile jest dzieci zapisanych do biblioteki
select COUNT(distinct member_no) as liczba_dzieci from juvenile
-- 3. Ilu z dorosłych czytelników mieszka w Kaliforni (CA)
select COUNT(distinct member_no) as czytelnicy_z_CA from adult where [state]='CA'
-- 4. Dla każdego dorosłego czytelnika podaj liczbę jego dzieci.
select adult_member_no, COUNT(distinct member_no) as liczba_dzieci from juvenile GROUP by adult_member_no
SELECT m.member_no AS adult_member_no, m.firstname, m.lastname, COUNT(DISTINCT j.member_no) AS liczba_dzieci
FROM member m
LEFT JOIN juvenile j ON m.member_no = j.adult_member_no
GROUP BY m.member_no, m.firstname, m.lastname;
-- 5. Dla każdego dorosłego czytelnika podaj liczbę jego dzieci urodzonych przed 1998r
select adult_member_no, COUNT(distinct member_no) as liczba_dzieci_orzed_1998 from juvenile where YEAR(birth_date) < 1998 group by adult_member_no order by adult_member_no

-- Ćwiczenie 3

-- 1. Dla każdego czytelnika podaj liczbę zarezerwowanych przez niego książek
select member_no, COUNT(log_date) as liczba_zarezerwowanych_ksiazek from reservation group by member_no order by member_no

select m.member_no, COUNT(log_date) as liczba_zarezerwowanych_ksiazek 
from member m left join reservation r on r.member_no = m. member_no group by m.member_no order by m.member_no
-- 2. Dla każdego czytelnika podaj liczbę wypożyczonych przez niego książek
select member_no, COUNT(out_date) as liczba_wypozyczonych_ksiazek from loan group by member_no order by member_no

select m.member_no, m.firstname, m.lastname, COUNT(l.out_date) as liczba_wypozyczonych_ksiazek from member m 
left join loan l on l.member_no = m.member_no group by m.member_no, m.firstname, m.lastname order by m.member_no
-- 3. Dla każdego czytelnika podaj liczbę książek zwróconych przez niego w 2001r.
select m.member_no, m.firstname, m.lastname, COUNT(lh.in_date) as liczba_zwroconych_w_2001 from member m
left join loanhist lh on lh.member_no = m.member_no and YEAR(lh.in_date)=2001 group by m.member_no, m.firstname, m.lastname order by m.member_no
-- 4. Dla każdego czytelnika podaj sumę kar jakie zapłacił w 2001r
select m.member_no, m.firstname, m.lastname, SUM(lh.fine_paid) as zaplacone_kary from member m
left join loanhist lh on lh.member_no = m.member_no and YEAR(lh.in_date)=2001 group by m.member_no, m.firstname, m.lastname order by m.member_no

select m.member_no, m.firstname, m.lastname, ISNULL(SUM(lh.fine_paid), 0.00) as zaplacone_kary from member m
left join loanhist lh on lh.member_no = m.member_no and YEAR(lh.in_date)=2001 group by m.member_no, m.firstname, m.lastname order by m.member_no
-- 5. Ile książek wypożyczono w maju 2001
select COUNT(out_date) as liczba_wypozyczen_w_maju_2001 from loanhist where YEAR(out_date)=2001 and MONTH(out_date)=5
select  COUNT(out_date) as liczba_wypozyczen_w_maju_2002 from loanhist where YEAR(out_date)=2002 and MONTH(out_date)=5
-- 6. Na jak długo średnio były wypożyczane książki w maju 2002
select AVG(DATEDIFF(DAY, out_date, in_date)) as na_jak_dlugo_byly_wyp_ksiazki_w_maju_2002_w_dniach from loanhist where YEAR(out_date)=2002 and MONTH(out_date)=5 

-- Ćwiczenie 4

-- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień w 1997r
select EmployeeID, COUNT(*) as liczba_obslugiwanych_zamowien from Orders where YEAR(OrderDate)=1997 group by EmployeeID

select e.EmployeeID, e.LastName, e.FirstName ,COUNT(*) as liczba_obslugiwanych_zamowien from Employees e
left join Orders o on o.EmployeeID = e.EmployeeID where YEAR(o.OrderDate)=1997 group by e.EmployeeID, e.LastName, e.FirstName
-- 2. Dla każdego pracownika podaj ilu klientów (różnych klientów) obsługiwał ten pracownik w 1997r
select EmployeeID, COUNT(distinct CustomerID) as ilu_roznych_klientow from Orders where YEAR(OrderDate)=1997 group by EmployeeID

select e.EmployeeID, e.LastName, e.FirstName, COUNT(distinct o.CustomerID) as ilu_roznych_klientow from Employees e
left join Orders o on o.EmployeeID = e.EmployeeID where YEAR(OrderDate)=1997 group by e.EmployeeID, e.LastName, e.FirstName
-- 3. Dla każdego spedytora/przewoźnika podaj łączną wartość "opłat za przesyłkę" dla przewożonych przez niego zamówień
select ShipVia, SUM(Freight) as suma_oplat_za_przesylke from Orders group by ShipVia order by ShipVia

select s.ShipperID, s.CompanyName ,SUM(o.Freight) as suma_oplat_za_przesylke from Shippers s
left join Orders o on o.ShipVia = s.ShipperID group by s.ShipperID, s.CompanyName order by s.ShipperID
-- 4. Dla każdego spedytora/przewoźnika podaj łączną wartość "opłat za przesyłkę" przewożonych przez niego zamówień w latach od 1996 do 1997
select ShipVia, SUM(Freight) as wartosc_oplat_za_przesylke from Orders where YEAR(ShippedDate)>=1996 and YEAR(ShippedDate)<=1997 group by ShipVia

select o.ShipVia, s.CompanyName, SUM(o.Freight) as wartosc_oplat_za_przesylke from Shippers s 
left join Orders o on o.ShipVia = s.ShipperID where YEAR(o.ShippedDate)>=1996 and YEAR(o.ShippedDate)<=1997 group by o.ShipVia, s.CompanyName order by o.ShipVia

-- Ćwiczenie 5

-- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata
select EmployeeID, YEAR(OrderDate) as lata, COUNT(OrderID) as ilosc_obslugiwanych_zamowien from Orders group by cube (EmployeeID, YEAR(OrderDate)) order by EmployeeID
-- 2. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata i miesiące.
select EmployeeID, YEAR(OrderDate) as lata, MONTH(OrderDate) as miesiac, COUNT(OrderID) as ilosc_obslugiwanych_zamowien from Orders
group by cube (EmployeeID, YEAR(OrderDate), MONTH(OrderDate)) order by EmployeeID