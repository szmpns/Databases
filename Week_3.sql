-- Ćwiczenia 1

-- 1.Dla każdego zamówienia podaj jego wartość. Posortuj wynik wg wartości zamówień (w malejęcej kolejności)

SELECT OrderID, SUM(Quantity*UnitPrice*(1-Discount)) as Price 
 from [Order Details] 
 GROUP BY OrderID 
 order by Price DESC

-- 2.Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało tylko pierwszych 10 wierszy

select od.orderid, customerid, sum(quantity*unitprice*(1-discount)) as price 
from [order details] od 
join orders o on o.orderid = od.orderid group by od.orderid, customerid order by price desc

-- 3.Podaj  nr zamówienia oraz wartość  zamówienia, dla zamówień, 
-- dla których łączna liczba zamawianych jednostek produktów jest większa niż 250

select OrderID,SUM(Quantity * UnitPrice) as OrderValue from [Order Details] GROUP by OrderID having SUM(Quantity) > 250;

-- 4.Podaj liczbę zamówionych jednostek produktów dla  produktów, dla których productid jest mniejszy niż 3

select SUM(Quantity) as liczba_zamowionych_jednostek from [Order Details] group by ProductID having ProductID < 3

--

joindb

select * from Buyers
select * from Produce
select * from Sales

select buyer_name, s.buyer_id, qty from Buyers as b, Sales as s where s.buyer_id = b.buyer_id;

--

-- Ćwiczenie 2

-- 1.Ilu jest dorosłych czytekników

select COUNT(member_no) from adult;

-- 2.Ile jest dzieci zapisanych do biblioteki

-- 3.Ilu z dorosłych czytelników mieszka w Kaliforni (CA)

-- 4.Dla każdego dorosłego czytelnika podaj liczbę jego dzieci.

select adult_member_no, COUNT(adult_member_no) from juvenile  GROUP by adult_member_no

---

select member.member_no, firstname, lastname, count(*)
from juvenile right join member
on adult_member_no = member.member_no and year(birth_date) < 1998
group by member.member_no, firstname, lastname
order by member.member_no;