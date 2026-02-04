# GCP Data Warehouse BigQuery – NYC Taxi Pipeline

End-to-end data engineering exercise using GCP, Docker, dlt, DuckDB and BigQuery with NYC Yellow Taxi 2024 data.

## Overview

This repository contains two main parts:

- **Ingestion script + Docker**: Download Parquet files for NYC Yellow Taxi trips and upload them to Google Cloud Storage (GCS).
- **dlt pipelines + Colab notebook**: Load the same data into DuckDB for local testing and into BigQuery for analytics.

The goal is to simulate a small, but realistic data platform:

1. Raw data in **cloud storage (GCS)**
2. Local validation in **DuckDB**
3. Analytics-ready tables in **BigQuery**

## Architecture

High-level flow:

1. **Cloudfront → Docker container → GCS bucket**

   - A Python script running in a Docker container downloads monthly Parquet files from  
     `https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-XX.parquet`
   - Files are uploaded to a GCS bucket:  
     `gs://dezoomcamp_hw3_arcan_2025`

2. **Cloudfront → dlt → DuckDB**

   - A dlt `resource` downloads the same Parquet files into Pandas DataFrames.
   - A dlt pipeline with `destination="duckdb"` loads them into a local DuckDB file:
     - pipeline: `rides_pipeline`
     - dataset: `rides_dataset`
     - table: `rides`
   - Row counts are validated in DuckDB.

3. **Cloudfront → dlt → BigQuery**

   - The same dlt resource is reused.
   - A second dlt pipeline with `destination="bigquery"` loads the data into:
     - project: `gcp-data-warehouse-486419`
     - dataset: `rides_dataset`
     - table: `rides`
   - Row counts in DuckDB and BigQuery match (~20.3M rows), confirming consistency.

## Repository Structure

- `upload_to_gcs.py`  
  Python script that:
  - downloads `yellow_tripdata_2024-01…06.parquet`
  - creates/checks a GCS bucket
  - uploads the files to GCS and verifies each upload

- `Dockerfile`  
  Builds a lightweight Python 3.11 image to run `upload_to_gcs.py` inside a container.

- `requirements.txt`  
  Python dependencies for the ingestion script (`google-cloud-storage`).

- `.gitignore`  
  Ensures that sensitive files such as `gcs.json` (service account key) are never committed.

- `dezoomcamp_gcp_dlt_rides.ipynb`  
  Colab notebook that:
  - uses dlt to download Parquet files as a `rides` resource
  - loads data into DuckDB (`rides_dataset.rides`)
  - loads data into BigQuery (`rides_dataset.rides`)
  - verifies that row counts in DuckDB and BigQuery match.

## GCS Ingestion with Docker

1. Build the image:

   ```bash
   docker build -t gcs-uploader .

2. Run the container:

   ```bash
   docker run --rm gcs-uploader

The script will:

Create/check the bucket dezoomcamp_hw3_arcan_2025

Download yellow_tripdata_2024-01.parquet to -06.parquet

Upload each file to GCS and verify the upload

Service account credentials are provided via a local gcs.json file inside the container (not committed to the repo).
