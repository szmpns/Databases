-- Ćwiczenie 

-- 1. Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)
select SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) + o.Freight as suma_za_10250 from Orders o join [Order Details] od on od.OrderID = o.OrderID where o.OrderID=10250
group by o.Freight
-- 2. Podaj łączną wartość każdego zamówienia (uwzględnij cenę za przesyłkę)
select o.OrderID, SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) + o.Freight as wartosc_zamowienia from Orders o join [Order Details] od on od.OrderID = o.OrderID
group by o.OrderID, o.Freight
-- 3. Dla każdego produktu podaj maksymalną wartość zakupu tego produktu
select p.ProductID, p.ProductName, MAX(od.UnitPrice*od.Quantity*(1-od.Discount)) as maxi from Products p join [Order Details] od on od.ProductID = p.ProductID
group by p.ProductID, p.ProductName order by p.ProductID
-- 4. Dla każdego produktu podaj maksymalną wartość zakupu tego produktu w 1997r
select p.ProductID, p.ProductName, MAX(od.Quantity*od.UnitPrice*(1-od.Discount)) as max_in_1997 from Products p 
join [Order Details] od on od.ProductID = p.ProductID join Orders o on o.OrderID = od.OrderID where YEAR(o.OrderDate)=1997
group by p.ProductID, p.ProductName

-- Ćwiczenie 2

-- 1. Dla każdego klienta podaj łączną wartość jego zamówień (bez opłaty za przesyłkę) z 1996r
select c.CustomerID, c.CompanyName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) as suma_z_1996 from Customers c 
join Orders o on o.CustomerID = c.CustomerID join [Order Details] od on od.OrderID = o.OrderID where YEAR(o.OrderDate)=1996
group by c.CustomerID, c.CompanyName
-- 2. Dla każdego klienta podaj łączną wartość jego zamówień (uwzględnij opłatę za przesyłkę) z 1996r
select c.CustomerID, c.CompanyName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) + SUM(o.Freight) suma_z_1996 from Customers c 
join Orders o on o.CustomerID = c.CustomerID join [Order Details] od on od.OrderID = o.OrderID where YEAR(o.OrderDate)=1996
group by c.CustomerID, c.CompanyName
-- 3. Dla każdego klienta podaj maksymalną wartość zamówienia złożonego przez tego klienta w 1997r
select c.CustomerID, c.CompanyName, MAX(od.UnitPrice*od.Quantity*(1-Discount)) as max_in_1997 from Customers c 
join Orders o on o.CustomerID = c.CustomerID join [Order Details] od on od.OrderID = o.OrderID where YEAR(o.OrderDate)=1997
group by c.CustomerID, c.CompanyName

SELECT 
    c.CustomerID, 
    c.CompanyName, 
    MAX(TotalOrderValue) AS MaxOrderValueIn1997
FROM 
    Customers c 
JOIN 
    (SELECT 
         o.CustomerID, 
         o.OrderID, 
         SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalOrderValue
     FROM 
         Orders o 
     JOIN 
         [Order Details] od ON o.OrderID = od.OrderID
     WHERE 
         YEAR(o.OrderDate) = 1997
     GROUP BY 
         o.CustomerID, o.OrderID
    ) AS Subquery
ON 
    c.CustomerID = Subquery.CustomerID
GROUP BY 
    c.CustomerID, c.CompanyName;
    