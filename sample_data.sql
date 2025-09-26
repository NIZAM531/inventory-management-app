USE InventoryManagement;

INSERT INTO Suppliers (SupplierName, ContactEmail, Phone)
VALUES ('ABC Supplies', 'abc@supplies.com', '1234567890'),
       ('Global Traders', 'global@traders.com', '9876543210');

INSERT INTO Products (ProductName, SupplierID, QuantityInStock, ReorderLevel)
VALUES ('Laptop', 1, 15, 5),
       ('Mouse', 1, 8, 10),
       ('Keyboard', 2, 20, 5);
