-- For each start year convert it to date format,
-- then calculate percentage of positions with a description for each role
WITH yearly_data AS (
	SELECT p.description,
	p.role_k10_v3 as role_type,
	year(CAST(p.startdate AS DATE)) as start_years
	FROM revelio_2025.position p
)
SELECT start_years AS years, role_type AS clusters,
	ROUND(
		(count_if(description <> '') * 100.0) / COUNT(*),
		2
	) AS description_percentage
FROM yearly_data
WHERE (
    start_years BETWEEN 2016 AND 2025
    AND role_type <> ''
)
GROUP BY start_years, role_type
ORDER BY years, clusters