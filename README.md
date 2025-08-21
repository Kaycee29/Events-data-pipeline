🎟️ 
Transactional Events Data Pipeline

This project simulates an event ticketing platform data pipeline using Python, Apache Airflow, AWS, and Amazon Redshift.

It generates large-scale simulated transactional event data (tickets purchased, payment methods, buyer details, etc.), stores it in Amazon S3 as Parquet files, and then ingests it into Amazon Redshift for querying and analytics.

📌 Features

Generates 500K–1M simulated ticket sales records per batch.

Data includes:

-Ticket ID
-Event name (e.g., Afrobeats Live, Tech Expo, Lagos Fashion Show)
-Ticket type (Regular, VIP, VVIP)
-Payment method (Card, Transfer, Cash, USSD)
-Buyer details (name, email, city, country)
-Pricing and totals
-Stores generated data in Amazon S3 (Parquet format).
-Orchestrates daily ingestion from S3 → Redshift for analytics and BI use cases.
⚙️ Tech Stack
 -Python
 -Pandas (data handling)
 -Faker (simulated data generation)
 -AWS Wrangler (S3 + Redshift integration)
 -Boto3 (AWS SDK for Python)
 -Apache Airflow (workflow orchestration)
 -Amazon S3 (data lake storage)
 -Amazon Redshift (data warehouse for querying)
