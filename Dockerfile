FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY upload_to_gcs.py upload_to_gcs.py
COPY gcs.json gcs.json

CMD ["python", "upload_to_gcs.py"]
