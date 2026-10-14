```sql
-- =====================================================
-- 03_DRIVER_OPERATIONAL_ANALYSIS.SQL
-- Analisis aktivitas operasional pengemudi
-- =====================================================

USE ojek_db;

-- 1. Jumlah perjalanan per pengemudi
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama
ORDER BY jumlah_perjalanan DESC;


-- 2. Rata-rata jarak perjalanan per pengemudi
SELECT
    d.id_driver,
    d.nama,
    COUNT(o.id_order) AS jumlah_perjalanan,
    ROUND(AVG(o.jarak_km), 2) AS rata_rata_jarak_km
FROM ojek_drivers AS d
LEFT JOIN ojek_orders AS o
    ON d.id_driver = o.id_driver
GROUP BY d.id_driver, d.nama
ORDER BY rata_rata_jarak_km ASC;
```
