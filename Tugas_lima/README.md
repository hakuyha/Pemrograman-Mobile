# Dokumentasi Proyek

Panduan singkat setup project, menjalankan server lokal, dan import database MySQL.

---

## 1. Setup Project

1. Pastikan **Flutter SDK** telah terpasang di sistem.
2. Buka terminal di direktori proyek dan unduh dependensi:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi Flutter:
   ```bash
   flutter run
   ```

---

## 2. Menjalankan Server Lokal

Untuk menjalankan server backend lokal (misal: REST API berbasis Node.js/Express):

1. Pastikan runtime **Node.js** dan package manager **npm** sudah terpasang.
2. Jalankan perintah instalasi dependensi server:
   ```bash
   npm install
   ```
3. Jalankan server lokal:
   ```bash
   npm start
   ```
   *Server default berjalan di `http://localhost:3000` (atau `http://10.0.2.2:3000` untuk Android Emulator).*

---

## 3. Import Database MySQL

### Opsi A: Melalui phpMyAdmin (GUI)
1. Buka XAMPP / Laragon dan aktifkan service **MySQL**.
2. Buka browser menuju `http://localhost/phpmyadmin`.
3. Buat database baru (contoh: `db_penyedia_jasa`).
4. Masuk ke database tersebut, pilih tab **Import**.
5. Pilih file SQL skema database (contoh: `database.sql`), lalu klik tombol **Import** / **Go**.

### Opsi B: Melalui Terminal (CLI)
Jalankan perintah berikut pada terminal/command prompt:

```bash
# 1. Buat database baru
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS db_penyedia_jasa;"

# 2. Import file database
mysql -u root -p db_penyedia_jasa < database.sql
```
