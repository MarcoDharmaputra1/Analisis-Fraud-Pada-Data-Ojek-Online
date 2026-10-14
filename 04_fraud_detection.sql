```sql
-- =====================================================
-- 04_FRAUD_DETECTION.SQL
-- Identifikasi pengemudi dengan pola perjalanan anomali
-- =====================================================

USE ojek_db;

-- 1. Klasifikasi seluruh pengemudi
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan,
    ROUND(AVG(o.jarak_km), 2) AS rata_rata_jarak_km,
    CASE
        WHEN COUNT(o.id_order) > 50
         AND AVG(o.jarak_km) < 2
        THEN 'FLAGGED_FOR_REVIEW'
        ELSE 'NORMAL'
    END AS status_anomali
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama
ORDER BY d.id_driver;


-- 2. Menampilkan pengemudi yang memenuhi kriteria
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan,
    ROUND(AVG(o.jarak_km), 2) AS rata_rata_jarak_km,
    'FLAGGED_FOR_REVIEW' AS status_anomali
FROM ojek_drivers AS d
INNER JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama
HAVING COUNT(o.id_order) > 50
   AND AVG(o.jarak_km) < 2
ORDER BY rata_rata_jarak_km ASC;
```
