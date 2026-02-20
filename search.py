from sentence_transformers import SentenceTransformer, util
import time

model = SentenceTransformer('all-MiniLM-L6-v2')


items = [
    {"id": 101, "title": "Electric cars", "category": "Automotive"},
    {"id": 102, "title": "Mountain bikes", "category": "Sports"},
    {"id": 103, "title": "Heavy vehicles", "category": "Automotive"},
]
texts = [f"{item['title']} {item['category']}" for item in items]
query = "bike"

time_start = time.time()

# Encode
doc_embeddings = model.encode(texts, convert_to_tensor=True)
query_embedding = model.encode(query, convert_to_tensor=True)

# Similarity scores
scores = util.cos_sim(query_embedding, doc_embeddings)

# Rank
ranked = sorted(zip(texts, scores[0]), key=lambda x: x[1], reverse=True)
print(ranked)
print(f"Search took {time.time() - time_start:.2f} seconds")