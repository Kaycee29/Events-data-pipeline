<img width="1849" height="867" alt="Screenshot 2025-08-19 234246" src="https://github.com/user-attachments/assets/6578912b-fb49-40c2-9f68-3a8ddf35162a" />
<img width="1845" height="893" alt="Screenshot 2025-08-19 234227" src="https://github.com/user-attachments/assets/e07c83b5-722b-4311-a4f0-86265483e1eb" />
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
