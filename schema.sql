-- Database schema
CREATE DATABASE InventoryManagement;
USE InventoryManagement;

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100),
    Phone NVARCHAR(20)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,
    ProductName NVARCHAR(100) NOT NULL,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    QuantityInStock INT DEFAULT 0,
    ReorderLevel INT DEFAULT 10
);

CREATE TABLE PurchaseOrders (
    OrderID INT PRIMARY KEY IDENTITY,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    OrderDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY,
    OrderID INT FOREIGN KEY REFERENCES PurchaseOrders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    QuantityOrdered INT
);

-- Stored procedure: create order
CREATE PROCEDURE sp_CreatePurchaseOrder
    @SupplierID INT
AS
BEGIN
    INSERT INTO PurchaseOrders (SupplierID) VALUES (@SupplierID);
END;

-- Stored procedure: update stock
CREATE PROCEDURE sp_UpdateStock
    @ProductID INT,
    @QuantityReceived INT
AS
BEGIN
    UPDATE Products
    SET QuantityInStock = QuantityInStock + @QuantityReceived
    WHERE ProductID = @ProductID;
END;

-- Trigger: auto reorder if below threshold
CREATE TRIGGER trg_AutoReorder
ON Products
AFTER UPDATE
AS
BEGIN
    DECLARE @ProductID INT, @SupplierID INT, @Quantity INT;
    SELECT @ProductID = INSERTED.ProductID,
           @SupplierID = INSERTED.SupplierID,
           @Quantity = INSERTED.QuantityInStock
    FROM INSERTED;

    IF @Quantity < (SELECT ReorderLevel FROM Products WHERE ProductID = @ProductID)
    BEGIN
        EXEC sp_CreatePurchaseOrder @SupplierID;
    END
END;
