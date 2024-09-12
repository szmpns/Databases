-- Ćwiczenie 1

-- 1. Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)

SELECT 
    o.OrderID,
    SUM((od.UnitPrice * od.Quantity) + o.Freight) AS TotalOrderValue
FROM 
    Orders o
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
WHERE 
    o.OrderID = 10250
GROUP BY 
    o.OrderID, o.Freight;

-- 2. Podaj łączną wartość każdego zamówienia (uwzględnij cenę za przesyłkę)

select Orders.OrderID, SUM([Order Details].Quantity * [Order Details].UnitPrice + Freight) as TOTAL_PRICE from Orders
join [Order Details] on Orders.OrderID = [Order Details].[OrderID]
GROUP by Orders.OrderID

-- 3. Dla każdego produktu podaj maksymalną wartość zakupu tego produktu

-- hackerrank

SELECT 
    [Order Details].ProductID,
    MAX([Order Details].Quantity * [Order Details].UnitPrice) AS MaxPurchaseValue
FROM 
    [Order Details]
GROUP BY 
    [Order Details].ProductID;

-- 4. Dla każdego produktu podaj maksymalną wartość zakupu tego produktu w 1997r

select [Order Details].ProductID, MAX([Order Details].Quantity * [Order Details].UnitPrice) as MAX_IN_1997 from Orders join [Order Details] on [Order Details].OrderID = Orders.OrderID
where YEAR(Orders.OrderDate)=1997
GROUP by [Order Details].ProductID

-- Ćwiczenie 2

-- 1. Dla każdego klienta podaj łączną wartość jego zamówień (bez opłaty za przesyłkę) z 1996r

select Customers.CustomerID, SUM([Order Details].Quantity * [Order Details].UnitPrice) as SUM_FROM_1996 from Customers 
join Orders on Orders.CustomerID = Customers.CustomerID
join [Order Details] on [Order Details].OrderID = Orders.OrderID
where YEAR(Orders.ShippedDate)=1996
group by Customers.CustomerID

-- 2. Dla każdego klienta podaj łączną wartość jego zamówień (uwzględnij opłatę za przesyłkę) z 1996r

select Customers.CustomerID, SUM([Order Details].Quantity * [Order Details].UnitPrice) as SUM_FROM_1996 from Customers 
join Orders on Orders.CustomerID = Customers.CustomerID
join [Order Details] on [Order Details].OrderID = Orders.OrderID
where YEAR(Orders.ShippedDate)=1996
group by Customers.CustomerID

-- 3. Dla każdego klienta podaj maksymalną wartość zamówienia złożonego przez tego klienta w 1997r

select customers.CustomerID, MAX([Order Details].Quantity * [Order Details].UnitPrice) from Customers 
join Orders on Orders.CustomerID = Customers.CustomerID
join [Order Details] on [Order Details].OrderID = Orders.OrderID
where YEAR(Orders.ShippedDate)=1997
group by Customers.CustomerID