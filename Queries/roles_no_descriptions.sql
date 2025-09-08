-- Create a CTE to track total number of rows where there is not a valid description
WITH table_count AS (
    SELECT COUNT(*) AS row_count
    FROM revelio_2025.position p
    WHERE p.description = '' AND p.role_k10_v3 <> ''
)
-- Select cluster name from role_k10 and calculate the percentage of each 
-- cluster using GROUP BY
SELECT 
    p.role_k10_v3 AS cluster_name,
    ROUND((COUNT(*)*100.0)/t.row_count, 2) AS cluster_percentage

FROM revelio_2025.position p
CROSS JOIN table_count t
WHERE p.description = '' AND p.role_k10_v3 <> ''
GROUP BY p.role_k10_v3, t.row_count
ORDER BY cluster_name