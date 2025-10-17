SELECT p.state AS states,
ROUND (
    (COUNT_IF((p.title_22_ai = 1 OR p.desc_22_ai = 1))*100.0)/COUNT(*), 4 
) AS AI_states_22,
ROUND (
    (COUNT_IF((p.desc_25_ai = 1 OR p.title_25_ai = 1))*100.0)/COUNT(*), 4 
) AS AI_states_25
FROM revelio_2022.ai_information_22_25_incl_genderandcity p 
WHERE p.start_year = 2022 AND p.state not in ('Ajaria', 'Kvemo Kartli', 'Tbilisi', 'empty')
GROUP BY p.state
ORDER BY states