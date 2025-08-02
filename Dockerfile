# Use official Python
FROM python:3.11-slim

# Set working dir
WORKDIR /app

# Copy only dependencies first (for better caching)
COPY requirements.txt .

RUN pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Install OS dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg libsndfile1 \
 && rm -rf /var/lib/apt/lists/*

# Copy rest of your application code
COPY . .

# Expose port if relevant
EXPOSE 8000

# Final command:
CMD ["python", "serve.py"]
