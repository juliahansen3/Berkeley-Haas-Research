WITH AI AS (
    SELECT p.title_raw, p.description, p.position_id,
        CASE 
            WHEN regexp_like(p.description, '(?i) AI |Articial Intelligence|Machine Learning| ML |Deep Learning|Neural Network|Generative AI|Large Language Model| LLM |Natural Language Processing|Computer Vision|Reinforcement Learning') THEN 1 
            WHEN regexp_like(p.title_raw, '(?i) AI | Articial Intelligence|Machine Learning| ML |Deep Learning|Neural Network|Generative AI|Large Language Model| LLM |Natural Language Processing|Computer Vision|Reinforcement Learning') THEN 1 
            ELSE 0 
        END AS AI_related
    FROM revelio_2025.position p
)
SELECT AI.title_raw, AI.description, AI_related
FROM AI