# Use Python 3.11 slim image
FROM python:3.11-slim

# Install system-level dependencies (required for yt-dlp and pydub audio processing)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies (utilizing --no-cache-dir to save space)
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Expose Streamlit's default port
EXPOSE 8501

# Command to run Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
