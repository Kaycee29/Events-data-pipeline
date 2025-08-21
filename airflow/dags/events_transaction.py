import pandas as pd
import random
import awswrangler as wr
from datetime import datetime, timedelta
from faker import Faker
import os
import boto3
from airflow.models import Variable

secret_key = Variable.get("MY_SECRET_KEY")
access_key = Variable.get("MY_ACCESS_KEY")
region_key = Variable.get("REGION_NAME")




session = boto3.Session(
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        region_name=region_key
    )


fake = Faker()

num_rows = random.randint(500000, 1000000)

# Lists for choice fields
event_names = ["Afrobeats Live", "Naija Comedy Night", "Tech Expo", "Food Fest", "Lagos Fashion Show"]
ticket_types = ["Regular", "VIP", "VVIP"]
payment_methods = ["Card", "Transfer", "Cash", "USSD"]

 
def generate_ticket_id():
    date_part = datetime.now().strftime("%Y%m%d")
    random_part = str(random.randint(1000, 9999))
    return f"ticket-{date_part}-{random_part}"

data = []

for row in range(num_rows):
    ticket_id = generate_ticket_id()
    event = random.choice(event_names)
    ticket_type = random.choice(ticket_types)
    payment = random.choice(payment_methods)
    price = random.randint(5000, 50000)
    quantity = random.randint(1, 5)
    total_amount = price * quantity
    purchase_date = fake.date_between(start_date='-180d', end_date='today')
    buyer_name = fake.name()
    buyer_email = fake.email()
    buyer_city = fake.city()
    buyer_country = fake.country()

    data.append([
        ticket_id, event, ticket_type, payment, price, quantity, total_amount,
        purchase_date.strftime("%Y-%m-%d"), buyer_name, buyer_email, buyer_city, buyer_country
    ])

columns = [
    "ticket_id", "event_name", "ticket_type", "payment_method",
    "ticket_price", "quantity", "total_amount", "purchase_date",
    "buyer_name", "buyer_email", "buyer_city", "buyer_country"
]

df = pd.DataFrame(data,columns= columns)


s3_bucket = 'events-ticket-2025'
s3_filename = 'events'
date_str = datetime.now().strftime('%Y-%m-%d')

s3_path = f"s3://{s3_bucket}/{s3_filename}/{date_str}_events.parquet"
print(s3_path)

wr.s3.to_parquet(
    df, path=s3_path,
    dataset=True,
    mode='overwrite',
    index=False,
    boto3_session=session)
print(f"Data successfully uploaded to {s3_path}")

