import boto3
import json

sqs_client = boto3.client('sqs', region_name='us-east-1')

queue_url = sqs_client.get_queue_url(QueueName='MyDemoQueue')['QueueUrl']

response = sqs_client.purge_queue(QueueUrl=queue_url) 

print(json.dumps(response, indent=2))