-- For each start year convert it to date format,
-- then calculate percentage of positions with a description
WITH yearly_data AS (
	SELECT p.description,
		year(CAST(p.startdate AS DATE)) as start_years
	FROM revelio_2025.position p
)
SELECT start_years AS years,
	ROUND(
		(count_if(description <> '') * 100) / COUNT(*),
		2
	) AS description_percentage
FROM yearly_data
GROUP BY start_years
ORDER BY years