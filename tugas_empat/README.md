# Aplikasi Penyedia Jasa & Layanan Digital

Aplikasi mobile berbasis Flutter yang menampilkan data penyedia jasa secara dinamis dari database MySQL melalui REST API berbasis Node.js & Express.

---

## Daftar Isi
- [Prasyarat Sistem](#prasyarat-sistem)
- [Struktur Direktori](#struktur-direktori)
- [Setup Database MySQL](#setup-database-mysql)
- [Menjalankan Server Backend](#menjalankan-server-backend)
- [Menjalankan Aplikasi Flutter](#menjalankan-aplikasi-flutter)
- [Konfigurasi Host URL](#konfigurasi-host-url)
- [Dokumentasi API](#dokumentasi-api)

---

## Prasyarat Sistem

Sebelum memulai, pastikan perangkat telah terpasang:
- **MySQL Server** (melalui XAMPP, Laragon, atau MySQL Server standalone)
- **Node.js** (v18.x atau lebih baru) dan npm
- **Flutter SDK** (v3.13.x atau lebih baru)
- **Android Studio / Android Emulator** atau perangkat fisik untuk pengujian

---

## Struktur Direktori

```text
tugas_empat/
├── backend/
│   ├── .env
│   ├── .env.example
│   ├── package.json
│   └── server.js
├── lib/
│   └── main.dart
├── android/
├── database.sql
├── pubspec.yaml
└── README.md
```

---

## Setup Database MySQL

File skema dan data awal database tersedia pada file `database.sql`.

### Cara 1: Menggunakan phpMyAdmin (GUI)
1. Aktifkan modul **Apache** dan **MySQL** pada XAMPP / Laragon.
2. Buka browser dan masuk ke `http://localhost/phpmyadmin`.
3. Buat database baru dengan nama `db_penyedia_jasa`.
4. Pilih database `db_penyedia_jasa`, lalu buka menu **Import**.
5. Unggah file `database.sql` yang berada di direktori proyek ini.
6. Klik tombol **Import** (atau **Go**) untuk mengeksekusi skrip SQL.

### Cara 2: Menggunakan Command Line (Terminal)
Jalankan perintah berikut di terminal:

```bash
# Buat database jika belum ada
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS db_penyedia_jasa;"

# Import file SQL ke database
mysql -u root -p db_penyedia_jasa < database.sql
```
*Catatan: Pada instalasi default XAMPP/Laragon, user `root` tidak memiliki password (cukup tekan Enter saat diminta password).*

---

## Menjalankan Server Backend

Server REST API dibangun menggunakan Express.js dan modul `mysql2`.

1. Masuk ke direktori `backend`:
   ```bash
   cd backend
   ```

2. Pasang dependensi proyek:
   ```bash
   npm install
   ```

3. Periksa konfigurasi pada file `.env` dan sesuaikan kredensial MySQL jika diperlukan:
   ```env
   PORT=3000
   DB_HOST=localhost
   DB_USER=root
   DB_PASS=
   DB_NAME=db_penyedia_jasa
   DB_PORT=3306
   ```

4. Jalankan server:
   ```bash
   npm start
   ```
   Server akan berjalan di `http://localhost:3000` (atau `http://10.0.2.2:3000` dari emulator Android).

5. Verifikasi pengujian:
   Buka `http://localhost:3000/api/penyedia-jasa` di browser untuk memastikan data berhasil diambil dari database.

---

## Menjalankan Aplikasi Flutter

1. Kembali ke direktori utama proyek dan unduh seluruh dependensi:
   ```bash
   flutter pub get
   ```

2. Pastikan emulator Android telah aktif atau perangkat fisik telah terhubung dalam mode debugging USB.

3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

---

## Konfigurasi Host URL

Pengaturan URL endpoint dikelola secara terpusat pada class `AppConfig` di file `lib/main.dart`:

| Lingkungan Pengujian | URL Host | Keterangan |
| :--- | :--- | :--- |
| **Android Emulator** | `http://10.0.2.2:3000` | IP loopback khusus Android Emulator untuk mengakses localhost PC. |
| **Flutter Web / Desktop** | `http://localhost:3000` | Mengakses langsung port lokal mesin host. |
| **Perangkat Fisik (Real Device)** | `http://<IP_LAN_PC>:3000` | PC dan smartphone harus dalam jaringan Wi-Fi yang sama (contoh: `http://192.168.1.10:3000`). |

---

## Dokumentasi API

### 1. Ambil Semua Penyedia Jasa
- **Method:** `GET`
- **Endpoint:** `/api/penyedia-jasa`
- **Response Format:** `application/json`

**Contoh Response:**
```json
{
  "status": true,
  "message": "Berhasil mengambil data penyedia jasa",
  "total": 3,
  "data": [
    {
      "id": 1,
      "nama": "Harun Yahya",
      "profesi": "Mobile App Developer (Flutter)",
      "harga": "Rp 3.500.000 / proyek",
      "bio": "Spesialis pembuatan aplikasi mobile Android & iOS menggunakan Flutter. Berpengalaman dalam integrasi REST API, database lokal, dan publikasi aplikasi.",
      "keahlian": [
        "Flutter & Dart",
        "Integrasi API",
        "Firebase Setup"
      ],
      "icon": "developer_mode",
      "created_at": "2026-09-13T09:00:00.000Z"
    }
  ]
}
```

### 2. Ambil Detail Penyedia Jasa
- **Method:** `GET`
- **Endpoint:** `/api/penyedia-jasa/:id`
- **Contoh Permintaan:** `GET /api/penyedia-jasa/1`
