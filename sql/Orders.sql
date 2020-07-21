set nocount on

select
  convert(char(24), o.ObjectId, 2) [_id.$oid],
  o.OrderDate [date],
  o.Freight [freight],
  o.RequiredDate [requiredDate],
  o.ShipName [ship.name],
  o.ShippedDate [ship.date],
  o.ShipAddress [ship.address.street],
  o.ShipCity [ship.address.city],
  o.ShipRegion [ship.address.region],
  o.ShipCountry [ship.address.country],
  o.ShipPostalCode [ship.address.zip],
  convert(char(24), c.ObjectId, 2) [customer._id.$oid],
  c.[CompanyName] [customer.name],
  c.[ContactName] [customer.contact.name],
  c.[ContactTitle] [customer.contact.title],
  c.[Phone] [customer.contact.phone],
  c.[Fax] [customer.contact.fax],
  c.[Address] [customer.address.street],
  c.[City] [customer.address.city],
  c.[Region] [customer.address.region],
  c.[Country] [customer.address.country],
  c.[PostalCode] [customer.address.zip],
  (select 
        od.Quantity quantity,
        od.UnitPrice unitPrice,
        od.Discount discount,
        convert(char(24), p.ObjectId, 2) [product._id.$oid],
        p.ProductName [product.name],
        convert(char(24), cat.ObjectId, 2) [product.category._id.$oid],
        cat.CategoryName [product.category.name]
      from [dbo].[Order Details] od
          join [dbo].[Products] p on od.ProductID = p.[ProductID]
          left join [dbo].[Categories] cat on p.CategoryID = cat.CategoryID
        where o.OrderID = od.OrderID
      for json path
  ) [items]
 
    from [dbo].[Orders] o
    left join [dbo].[Customers] c on o.CustomerID = c.CustomerID
    order by o.OrderID
  for json path
