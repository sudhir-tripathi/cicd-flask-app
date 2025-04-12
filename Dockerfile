# Use official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Create non-root user and use it
RUN adduser --disabled-password --gecos '' appuser
USER appuser

# Expose Flask port
EXPOSE 5000

# Start the app with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]