from datetime import datetime

from airflow.operators.python import PythonOperator
from airflow.providers.amazon.aws.transfers.s3_to_redshift import S3ToRedshiftOperator
from events_transaction import generate_ticket_id

from airflow import DAG

date_str = datetime.now().strftime("%Y-%m-%d")

default_args = {
    "owner": "kaycee",
    "retries": 1,
}

dag = DAG(
    dag_id="events_pipeline",
    description="this pushes data from data source to the datalake which is s3",
    default_args=default_args,
    catchup=False,
    start_date=datetime(2025, 8, 5),
    schedule_interval="@daily",
)

push_to_s3 = PythonOperator(
    task_id="transactional_party_data", python_callable=generate_ticket_id, dag=dag
)

s3_to_redshift = S3ToRedshiftOperator(
    task_id="s3_to_redshift",
    dag=dag,
    schema="public",
    table="event_sales_ticket",
    s3_bucket="events-ticket-2025",
    s3_key=f"events/{date_str}_events.parquet",
    redshift_conn_id="redshift",
    aws_conn_id="aws_default",
    copy_options=["FORMAT AS PARQUET"],
)
push_to_s3 >> s3_to_redshift
