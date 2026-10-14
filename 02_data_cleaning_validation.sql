```sql
-- =====================================================
-- 02_DATA_CLEANING_VALIDATION.SQL
-- Pembersihan dan validasi data
-- =====================================================

USE ojek_db;

-- 1. Standarisasi email pengemudi
-- Format: driver[id_driver]@meongjek.com
UPDATE ojek_drivers
SET email = LOWER(
    CONCAT('driver', TRIM(id_driver), '@meongjek.com')
)
WHERE email IS NULL OR TRIM(email) = '';

-- 2. Standarisasi email pelanggan
-- Format: cust[id_customer]@meongjek.com
UPDATE ojek_customers
SET email = LOWER(
    CONCAT('cust', TRIM(id_customer), '@meongjek.com')
)
WHERE email IS NULL OR TRIM(email) = '';

-- 3. Normalisasi status pengemudi
-- Status kosong atau Unknown dijadikan Inactive
UPDATE ojek_drivers
SET status = 'Inactive'
WHERE status IS NULL
   OR TRIM(status) = ''
   OR LOWER(TRIM(status)) = 'unknown';

-- 4. Memeriksa hasil pembersihan email pengemudi
SELECT id_driver, nama, email
FROM ojek_drivers
ORDER BY id_driver
LIMIT 100;

-- 5. Memeriksa hasil pembersihan email pelanggan
SELECT id_customer, nama, email
FROM ojek_customers
ORDER BY id_customer
LIMIT 200;

-- 6. Memvalidasi format email pengemudi
SELECT id_driver, nama, email
FROM ojek_drivers
WHERE email IS NULL
   OR TRIM(email) = ''
   OR email NOT REGEXP
      '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

-- 7. Memvalidasi format email pelanggan
SELECT id_customer, nama, email
FROM ojek_customers
WHERE email IS NULL
   OR TRIM(email) = ''
   OR email NOT REGEXP
      '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

-- 8. Memeriksa status pengemudi setelah pembersihan
SELECT status, COUNT(*) AS jumlah_pengemudi
FROM ojek_drivers
GROUP BY status
ORDER BY jumlah_pengemudi DESC;
```
