# Analisis Data Ojek Online Menggunakan SQL

## 1. Deskripsi Proyek

Proyek ini merupakan latihan pengolahan dan analisis data operasional layanan ojek online menggunakan MySQL. Analisis mencakup pemeriksaan kualitas data, pembersihan data pelanggan dan pengemudi, analisis perjalanan, identifikasi pola transaksi anomali, serta pembuatan *views* untuk mendukung analisis berulang.

## 2. Tujuan Proyek

- Mengidentifikasi data kosong dan atribut yang tidak lengkap.
- Membersihkan dan menstandarkan email serta status pengemudi.
- Memvalidasi format email menggunakan regular expression.
- Menganalisis jumlah perjalanan, jarak, durasi, dan tarif berdasarkan pengemudi.
- Mengidentifikasi pengemudi yang memenuhi kriteria awal anomali perjalanan.
- Membuat SQL views untuk menyajikan ringkasan operasional dan hasil deteksi anomali.

## 3. Tugas dan Ruang Lingkup Pengerjaan

### 3.1 Pemeriksaan Kualitas Data

Menghitung jumlah data pada setiap tabel serta mengidentifikasi nilai kosong pada tabel pesanan, pembayaran, pelanggan, dan pengemudi. Pemeriksaan ini menjadi dasar untuk menentukan kebutuhan pembersihan data.

### 3.2 Pembersihan dan Validasi Data

Mengisi email yang kosong menggunakan format standar berbasis ID, menormalisasi status pengemudi yang kosong atau bernilai `Unknown` menjadi `Inactive`, serta memvalidasi format email menggunakan regular expression.

### 3.3 Analisis Operasional Pengemudi

Menghitung jumlah perjalanan dan rata-rata jarak perjalanan untuk setiap pengemudi. Hasil analisis digunakan untuk memahami variasi aktivitas operasional.

### 3.4 Deteksi Anomali Berpotensi Fraud

Mengidentifikasi pengemudi yang memiliki lebih dari 50 perjalanan dan rata-rata jarak perjalanan di bawah 2 km. Pengemudi yang memenuhi kedua kondisi ditandai untuk pemeriksaan lebih lanjut.

Kriteria tersebut merupakan aturan deteksi awal, bukan bukti bahwa kecurangan benar-benar terjadi.

### 3.5 Pembuatan SQL Views

Membuat empat views untuk menyajikan:
- Aktivitas dan rentang tanggal perjalanan pengemudi.
- Statistik jarak perjalanan.
- Ringkasan tarif perjalanan.
- Hasil klasifikasi anomali berdasarkan kriteria yang ditentukan.

## 4. Struktur Database

| Tabel | Fungsi |
|---|---|
| `ojek_orders` | Data pesanan dan perjalanan |
| `ojek_drivers` | Informasi pengemudi |
| `ojek_payments` | Informasi pembayaran |
| `ojek_customers` | Informasi pelanggan |

Relasi utama menghubungkan pesanan dengan pengemudi melalui `id_driver`. Struktur dan tipe data setiap tabel perlu diverifikasi menggunakan skema database sumber.

## 5. Struktur Repository

```text
ojek-data-quality-fraud-analysis/
├── README.md
└── sql/
    ├── 01_data_quality_checks.sql
    ├── 02_data_cleaning_validation.sql
    ├── 03_driver_operational_analysis.sql
    ├── 04_fraud_detection.sql
    └── 05_analytical_views.sql
```

## 6. Teknologi dan Teknik

**Teknologi:** MySQL, SQL

**Teknik:** Data Quality Checks, Data Cleaning, Regular Expressions, Conditional Logic (`CASE`), Aggregation, `JOIN`, `GROUP BY`, `HAVING`, SQL Views, dan Anomaly Detection.

## 7. Cara Menjalankan Proyek

1. Siapkan database `ojek_db` dan empat tabel sumber beserta datanya.
2. Jalankan `01_data_quality_checks.sql` untuk memeriksa kondisi awal dataset.
3. Buat cadangan data, kemudian jalankan `02_data_cleaning_validation.sql`.
4. Jalankan `03_driver_operational_analysis.sql` untuk menganalisis aktivitas pengemudi.
5. Jalankan `04_fraud_detection.sql` untuk mengidentifikasi pola anomali.
6. Jalankan `05_analytical_views.sql` untuk membuat dan memverifikasi views.

Jalankan file secara berurutan dan sesuaikan nama kolom dengan skema sumber apabila diperlukan. Proses pembersihan mengubah data secara langsung, sehingga disarankan menggunakan salinan database untuk pengujian.

## 8. Hasil yang Diharapkan

Proyek ini menghasilkan dataset yang lebih konsisten, ringkasan aktivitas pengemudi, statistik perjalanan, daftar pengemudi yang perlu ditinjau berdasarkan kriteria anomali, serta views yang dapat digunakan kembali untuk analisis operasional.

Hasil numerik dan kesimpulan akhir dicantumkan setelah seluruh query dijalankan dan divalidasi menggunakan dataset sumber.
