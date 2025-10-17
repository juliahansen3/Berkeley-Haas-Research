SELECT p.start_year AS start_years,
ROUND (
    (COUNT_IF((title_22_ai = 1 OR desc_22_ai = 1) AND p.f_prob > 0.5)*100.0)/COUNT(*), 4 
) AS AI_F_22,
ROUND (
    (COUNT_IF((title_22_ai = 1 OR desc_22_ai = 1) AND p.m_prob > 0.5)*100.0)/COUNT(*), 4 
) AS AI_M_22,
ROUND (
    (COUNT_IF((title_25_ai = 1 OR desc_25_ai = 1) AND p.f_prob > 0.5)*100.0)/COUNT(*), 4 
) AS AI_F_25,
ROUND (
    (COUNT_IF((desc_25_ai = 1 OR title_25_ai = 1) AND p.m_prob > 0.5)*100.0)/COUNT(*), 4 
) AS AI_M_25
FROM revelio_2022.ai_information_22_25_incl_genderandcity p
GROUP BY p.start_year
ORDER BY start_years