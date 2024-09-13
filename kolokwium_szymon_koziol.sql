-- Szymon Kozioł
-- ZESTAW 2

-- ZAD 1 

select m.firstname, m.lastname, a.street, a.city, a.zip, a.[state] ,t.title from member m 
join juvenile j on j.member_no = m.member_no
join adult a on a.member_no = j.adult_member_no
join loan l on l.member_no = m.member_no
join title t on t.title_no = l.title_no
where a.[state] in ('AZ', 'CA')

-- ZAD 2

select p.ProductName, s.CompanyName, cat.CategoryName from Products p 
join Categories cat on cat.CategoryID = p.CategoryID
join Suppliers s on s.SupplierID = p.SupplierID
where cat.CategoryName='Beverages'
and not exists (
    select * from [Order Details] od 
    join Orders o on o.OrderID = od.OrderID
    where o.OrderDate BETWEEN '1997-02-20' and '1997-02-25'
    and p.ProductID = od.ProductID
)
-- --tutaj funkcja pomocnicza do subquery
-- select * from [Order Details] od 
-- join Orders o on o.OrderID = od.OrderID
-- where o.OrderDate BETWEEN '1997-02-20' and '1997-02-25'

-- ZAD 3

select c.CompanyName, COUNT(o.OrderID) as ilosc_zamowien, COALESCE(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) + SUM(o.Freight), 0) as wartosc_obsl_zamowien
from Customers c 
left join Orders o on o.CustomerID = c.CustomerID and YEAR(o.OrderDate)=1997 and MONTH(o.OrderDate)=2
left join [Order Details] od on od.OrderID = o.OrderID
group by c.CompanyName