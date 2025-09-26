# 📦 Inventory & Supplier Management System

A full-stack project using **SQL + Node.js + Express + Vanilla JS**.  
Manages products, suppliers, purchase orders, and stock levels.

---

## 🚀 Features
- SQL schema with triggers & stored procedures.
- REST API in Node.js.
- Responsive frontend with HTML/CSS/JS.
- Auto reorder when stock is low.

---

## 🛠️ Setup
### 1. Database
Run `schema.sql` and `sample_data.sql` in SQL Server.

### 2. Backend
```bash
cd backend
npm install
npm start
```

### 3. Frontend
Open `frontend/index.html` in your browser.

---

## 📊 ER Diagram
Suppliers (1) —— (∞) Products (1) —— (∞) OrderDetails (∞) —— (1) PurchaseOrders
