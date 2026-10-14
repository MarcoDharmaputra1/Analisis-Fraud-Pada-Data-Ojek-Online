```sql
-- =====================================================
-- 01_DATA_QUALITY_CHECKS.SQL
-- Pemeriksaan awal kualitas data
-- =====================================================

USE ojek_db;

-- 1. Jumlah baris setiap tabel
SELECT COUNT(*) AS total_orders FROM ojek_orders;
SELECT COUNT(*) AS total_drivers FROM ojek_drivers;
SELECT COUNT(*) AS total_payments FROM ojek_payments;
SELECT COUNT(*) AS total_customers FROM ojek_customers;


-- 2. Memeriksa data pembayaran yang kosong
SELECT *
FROM ojek_payments
WHERE id_payment IS NULL OR TRIM(id_payment) = ''
   OR id_order IS NULL OR TRIM(id_order) = ''
   OR metode_bayar IS NULL OR TRIM(metode_bayar) = ''
   OR amount IS NULL;


-- 3. Memeriksa data perjalanan yang kosong
SELECT *
FROM ojek_orders
WHERE id_order IS NULL OR TRIM(id_order) = ''
   OR id_driver IS NULL OR TRIM(id_driver) = ''
   OR id_customer IS NULL OR TRIM(id_customer) = ''
   OR jarak_km IS NULL
   OR durasi_menit IS NULL
   OR tarif IS NULL;


-- 4. Memeriksa data pelanggan yang kosong
SELECT *
FROM ojek_customers
WHERE id_customer IS NULL OR TRIM(id_customer) = ''
   OR nama IS NULL OR TRIM(nama) = ''
   OR email IS NULL OR TRIM(email) = '';


-- 5. Memeriksa data pengemudi yang kosong
SELECT *
FROM ojek_drivers
WHERE id_driver IS NULL OR TRIM(id_driver) = ''
   OR nama IS NULL OR TRIM(nama) = ''
   OR email IS NULL OR TRIM(email) = ''
   OR status IS NULL OR TRIM(status) = '';


-- 6. Menghitung email kosong per tabel
SELECT
    SUM(CASE
        WHEN email IS NULL OR TRIM(email) = '' THEN 1
        ELSE 0
    END) AS total_email_kosong_driver
FROM ojek_drivers;

SELECT
    SUM(CASE
        WHEN email IS NULL OR TRIM(email) = '' THEN 1
        ELSE 0
    END) AS total_email_kosong_customer
FROM ojek_customers;


-- 7. Memeriksa format email awal
SELECT id_driver, nama, email
FROM ojek_drivers
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
  AND email NOT REGEXP
      '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

SELECT id_customer, nama, email
FROM ojek_customers
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
  AND email NOT REGEXP
      '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';
```
