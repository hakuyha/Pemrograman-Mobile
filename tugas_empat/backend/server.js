require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// MySQL Database Connection Pool
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || '',
  database: process.env.DB_NAME || 'db_penyedia_jasa',
  port: Number(process.env.DB_PORT) || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// Helper function to format response items
function formatJasa(row) {
  let keahlianList = [];
  if (typeof row.keahlian === 'string') {
    try {
      keahlianList = JSON.parse(row.keahlian);
    } catch {
      keahlianList = row.keahlian.split(',').map((s) => s.trim());
    }
  } else if (Array.isArray(row.keahlian)) {
    keahlianList = row.keahlian;
  }

  return {
    id: row.id,
    nama: row.nama,
    profesi: row.profesi,
    harga: row.harga,
    bio: row.bio,
    keahlian: keahlianList,
    icon: row.icon,
    created_at: row.created_at,
  };
}

// Health Check Route
app.get('/', (req, res) => {
  res.json({
    status: true,
    message: 'Backend REST API Penyedia Jasa aktif!',
    endpoints: {
      getAll: 'GET /api/penyedia-jasa',
      getById: 'GET /api/penyedia-jasa/:id',
    },
  });
});

// GET /api/penyedia-jasa - Mengambil semua data penyedia jasa
app.get('/api/penyedia-jasa', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM `penyedia_jasa` ORDER BY `id` ASC');
    const data = rows.map(formatJasa);
    res.json({
      status: true,
      message: 'Berhasil mengambil data penyedia jasa',
      total: data.length,
      data: data,
    });
  } catch (error) {
    console.error('Database Error:', error);
    res.status(500).json({
      status: false,
      message: 'Gagal mengambil data dari database',
      error: error.message,
    });
  }
});

// GET /api/penyedia-jasa/:id - Mengambil detail penyedia jasa berdasarkan ID
app.get('/api/penyedia-jasa/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await pool.query('SELECT * FROM `penyedia_jasa` WHERE `id` = ?', [id]);
    if (rows.length === 0) {
      return res.status(404).json({
        status: false,
        message: `Penyedia jasa dengan ID ${id} tidak ditemukan`,
      });
    }

    res.json({
      status: true,
      message: 'Berhasil mengambil detail penyedia jasa',
      data: formatJasa(rows[0]),
    });
  } catch (error) {
    console.error('Database Error:', error);
    res.status(500).json({
      status: false,
      message: 'Gagal mengambil detail dari database',
      error: error.message,
    });
  }
});

// Jalankan Server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`=========================================`);
  console.log(`🚀 Server Backend berjalan di port ${PORT}`);
  console.log(`📡 Local:   http://localhost:${PORT}`);
  console.log(`📱 Android: http://10.0.2.2:${PORT}`);
  console.log(`=========================================`);
});
