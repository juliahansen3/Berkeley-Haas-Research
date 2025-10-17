---Creating a new table for position id, state, start years of position, whether or not 2022 position has a description, 
---whether or not 2025 position has a description, whether or not 2022 title/description is AI related, and whether or not
---2025 title/description is AI related

CREATE TABLE revelio_2022.AI_information_22_25
WITH (
    format = 'PARQUET',
    external_location = 's3://nus-revelio-2022/AI_information_22_25/'
) AS
    SELECT p22.position_id, p22.state AS state, YEAR(CAST(p22.startdate AS date)) AS start_year, CAST((p22.title IS NOT NULL) AS INTEGER) AS title_22, CAST((p22.description IS NOT NULL) AS INTEGER) AS desc_22, CAST((p25.title_raw IS NOT NULL) AS INTEGER) AS title_25, CAST((p25.description IS NOT NULL) AS INTEGER) AS desc_25, 
            CASE 
                WHEN regexp_like(p22.title, '\b(AI|LLM|GPT|RAG|ML|NLP)\b[[:punct:]]?|(?i)(Artificial Intelligence|Machine Learning|Deep Learning|Neural Network|Generative AI|Large Language Model|Natural Language Processing|Computer Vision|Reinforcement Learning|Copilot|Claude|Gemini|ChatGPT|Gen AI|LangChain|retrieval[-]augmented generation|vector embeddings|vector database|transformer[-]based model|prompt engineering|prompt design|LlamaIndex|Pinecone|Weaviate|Milvus|OpenAI API|Anthropic Claude API|Azure OpenAI|Google Vertex AI Generative|HuggingFace|Transformers|RetrievalQA)') THEN 1 
                ELSE 0 
            END AS title_22_AI,
            CASE
                WHEN regexp_like(p22.description, '\b(AI|LLM|GPT|RAG|ML|NLP)\b[[:punct:]]?|(?i)(Artificial Intelligence|Machine Learning|Deep Learning|Neural Network|Generative AI|Large Language Model|Natural Language Processing|Computer Vision|Reinforcement Learning|Copilot|Claude|Gemini|ChatGPT|Gen AI|LangChain|retrieval[-]augmented generation|vector embeddings|vector database|transformer[-]based model|prompt engineering|prompt design|LlamaIndex|Pinecone|Weaviate|Milvus|OpenAI API|Anthropic Claude API|Azure OpenAI|Google Vertex AI Generative|HuggingFace|Transformers|RetrievalQA)') THEN 1 
                ELSE 0 
            END AS desc_22_AI,
            CASE
                   WHEN regexp_like(p25.title_raw, '\b(AI|LLM|GPT|RAG|ML|NLP)\b[[:punct:]]?|(?i)(Artificial Intelligence|Machine Learning|Deep Learning|Neural Network|Generative AI|Large Language Model|Natural Language Processing|Computer Vision|Reinforcement Learning|Copilot|Claude|Gemini|ChatGPT|Gen AI|LangChain|retrieval[-]augmented generation|vector embeddings|vector database|transformer[-]based model|prompt engineering|prompt design|LlamaIndex|Pinecone|Weaviate|Milvus|OpenAI API|Anthropic Claude API|Azure OpenAI|Google Vertex AI Generative|HuggingFace|Transformers|RetrievalQA)') THEN 1 
                   ELSE 0
            END AS title_25_AI,
            CASE
                   WHEN regexp_like(p25.description, '\b(AI|LLM|GPT|RAG|ML|NLP)\b[[:punct:]]?|(?i)(Artificial Intelligence|Machine Learning|Deep Learning|Neural Network|Generative AI|Large Language Model|Natural Language Processing|Computer Vision|Reinforcement Learning|Copilot|Claude|Gemini|ChatGPT|Gen AI|LangChain|retrieval[-]augmented generation|vector embeddings|vector database|transformer[-]based model|prompt engineering|prompt design|LlamaIndex|Pinecone|Weaviate|Milvus|OpenAI API|Anthropic Claude API|Azure OpenAI|Google Vertex AI Generative|HuggingFace|Transformers|RetrievalQA)') THEN 1 
                ELSE 0 
            END AS desc_25_AI
    FROM revelio_2022.position_1 p22
    INNER JOIN revelio_2025.position p25
    ON p22.position_id = p25.position_id 
    WHERE p22.country = 'United States' AND p25.country = 'United States' AND p22.title IS NOT NULL AND p25.title_raw IS NOT NULL AND YEAR(CAST(p22.startdate AS date)) BETWEEN 2000 AND 2022

    --- separate query example: 
    SELECT p.start_year AS start_years,
    --ROUND (
    --  (COUNT_IF(p.title_22_ai = 1)*100.0)/COUNT(*), 4 
    --) AS AI_desc_22,
    COUNT_IF(p.desc_22_ai = 1 AND p.desc_25_ai = 1) AS AI_22_25
    FROM revelio_2022.ai_information_22_25 p 
    GROUP BY p.start_year 
    ORDER BY start_years 