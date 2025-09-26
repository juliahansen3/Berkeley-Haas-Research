WITH AI AS (
    SELECT p.title, p.description, 
    year(CAST(p.startdate AS date)) AS start_years,
        CASE 
            WHEN regexp_like(p.description, '\b(AI|LLM|GPT|RAG|ML|NLP)\b[[:punct:]]?|(?i)(Articial Intelligence|Machine Learning|Deep Learning|Neural Network|Generative AI|Large Language Model|Natural Language Processing|Computer Vision|Reinforcement Learning|Copilot|Claude|Gemini|ChatGPT|Gen AI|LangChain|retrieval[-]augmented generation|vector embeddings|vector database|transformer[-]based model|prompt engineering|prompt design|LlamaIndex|Pinecone|Weaviate|Milvus|OpenAI API|Anthropic Claude API|Azure OpenAI|Google Vertex AI Generative|HuggingFace|Transformers|RetrievalQA)') THEN 1 
            WHEN regexp_like(p.title, '\b(AI|LLM|GPT|RAG|ML|NLP)\b[[:punct:]]?|(?i)(Articial Intelligence|Machine Learning|Deep Learning|Neural Network|Generative AI|Large Language Model|Natural Language Processing|Computer Vision|Reinforcement Learning|Copilot|Claude|Gemini|ChatGPT|Gen AI|LangChain|retrieval[-]augmented generation|vector embeddings|vector database|transformer[-]based model|prompt engineering|prompt design|LlamaIndex|Pinecone|Weaviate|Milvus|OpenAI API|Anthropic Claude API|Azure OpenAI|Google Vertex AI Generative|HuggingFace|Transformers|RetrievalQA)') THEN 1 
            ELSE 0 
        END AS AI_related
    FROM revelio_2022.position_1 p
)
SELECT start_years AS years,
    ROUND(
        (COUNT_IF(AI_related = 1)* 100.0)/ COUNT(*), 4
    )  AS AI_perc,
    ROUND(
        (COUNT_IF(AI_related = 0)* 100.0)/ COUNT(*), 4 
    )  AS not_AI_perc

FROM AI
WHERE start_years BETWEEN 1950 AND 2022
GROUP BY start_years