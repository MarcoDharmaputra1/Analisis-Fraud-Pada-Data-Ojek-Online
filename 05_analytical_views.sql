```sql
-- =====================================================
-- 05_ANALYTICAL_VIEWS.SQL
-- Pembuatan views analitis
-- =====================================================

USE ojek_db;

-- 1. Aktivitas pengemudi
CREATE OR REPLACE VIEW view_driver_activity AS
SELECT
    d.id_driver,
    d.nama,
    d.status,
    COUNT(o.id_order) AS jumlah_perjalanan,
    ROUND(AVG(o.durasi_menit), 2)
        AS rata_rata_durasi_menit,
    MIN(o.tanggal) AS tanggal_pertama,
    MAX(o.tanggal) AS tanggal_terakhir
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama, d.status;


-- 2. Statistik jarak perjalanan
CREATE OR REPLACE VIEW view_driver_distance AS
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan,
    ROUND(AVG(o.jarak_km), 2) AS rata_rata_jarak_km,
    ROUND(MIN(o.jarak_km), 2) AS min_jarak_km,
    ROUND(MAX(o.jarak_km), 2) AS max_jarak_km,
    ROUND(SUM(o.jarak_km), 2) AS total_jarak_km
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama;


-- 3. Statistik pendapatan berdasarkan tarif perjalanan
CREATE OR REPLACE VIEW view_driver_income AS
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan,
    SUM(o.tarif) AS total_tarif_perjalanan,
    ROUND(AVG(o.tarif), 2) AS rata_rata_tarif,
    MIN(o.tarif) AS tarif_minimum,
    MAX(o.tarif) AS tarif_maksimum
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama;


-- 4. Deteksi pola perjalanan anomali
CREATE OR REPLACE VIEW view_fraud_detection AS
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan,
    ROUND(AVG(o.jarak_km), 2) AS rata_rata_jarak_km,
    ROUND(AVG(o.durasi_menit), 2)
        AS rata_rata_durasi_menit,
    SUM(o.tarif) AS total_tarif_perjalanan,
    CASE
        WHEN COUNT(o.id_order) > 50
         AND AVG(o.jarak_km) < 2
        THEN 'FLAGGED_FOR_REVIEW'
        ELSE 'NORMAL'
    END AS status_anomali
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama;


-- =====================================================
-- VERIFIKASI VIEWS
-- =====================================================

SELECT *
FROM view_driver_activity
ORDER BY jumlah_perjalanan DESC;

SELECT *
FROM view_driver_distance
ORDER BY rata_rata_jarak_km ASC;

SELECT *
FROM view_driver_income
ORDER BY total_tarif_perjalanan DESC;

SELECT *
FROM view_fraud_detection
WHERE status_anomali = 'FLAGGED_FOR_REVIEW';

SELECT *
FROM view_fraud_detection
ORDER BY id_driver;
```
