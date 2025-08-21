🎟️ Events Data Pipeline

This project simulates an event ticketing platform data pipeline using Python, Airflow, AWS, and Redshift.

It generates synthetic transactional event data (tickets purchased, payment methods, buyer info, etc.), stores it in Amazon S3 (Parquet format), and then loads it into Amazon Redshift for querying and analytics.

📌 Features

Generates 500k – 1M random ticket sales records using Faker
Data includes:

-Ticket ID
-Event name (e.g., Afrobeats Live, Tech Expo, Lagos Fashion Show)
-Ticket type (Regular, VIP, VVIP)
-Payment method (Card, Transfer, Cash, USSD)
-Buyer details (name, email, city, country)
-Pricing and totals
Stores generated data in Parquet format in an Amazon S3 bucket.
Data is later ingested from S3 → Redshift for BI and analytics use cases.

⚙️ Tech Stack

Python
-Pandas (data handling)
-Faker (simulated data generation)
-AWS Wrangler (S3 + Redshift integration)
-Boto3 (AWS SDK for Python)
-Apache Airflow (workflow orchestration)
-Amazon S3 (data lake storage)
-Amazon Redshift (data warehouse for querying
