const express = require("express");
const sql = require("mssql");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

const dbConfig = {
  user: "YOUR_DB_USER",
  password: "YOUR_DB_PASS",
  server: "localhost",
  database: "InventoryManagement",
  options: { trustServerCertificate: true }
};

let pool;
sql.connect(dbConfig).then(p => (pool = p)).catch(err => console.log(err));

// Routes
app.get("/suppliers", async (req, res) => {
  const result = await pool.request().query("SELECT * FROM Suppliers");
  res.json(result.recordset);
});

app.get("/products", async (req, res) => {
  const result = await pool.request().query("SELECT * FROM Products");
  res.json(result.recordset);
});

app.post("/purchaseorders", async (req, res) => {
  const { SupplierID } = req.body;
  await pool.request().input("SupplierID", sql.Int, SupplierID).execute("sp_CreatePurchaseOrder");
  res.json({ message: "Purchase order created" });
});

app.post("/products/:id/receive", async (req, res) => {
  const { id } = req.params;
  const { QuantityReceived } = req.body;
  await pool.request()
    .input("ProductID", sql.Int, id)
    .input("QuantityReceived", sql.Int, QuantityReceived)
    .execute("sp_UpdateStock");
  res.json({ message: "Stock updated" });
});

const PORT = 4000;
app.listen(PORT, () => console.log(`✅ API running at http://localhost:${PORT}`));
