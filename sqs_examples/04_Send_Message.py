import boto3
import json

sqs_client = boto3.client('sqs', region_name='us-east-1')

message = 'This 2nd SQS message is sent from Python'

queue_url = sqs_client.get_queue_url(QueueName='MyDemoQueue')['QueueUrl']

response = sqs_client.send_message(QueueUrl=queue_url, MessageBody=message)

print(json.dumps(response, indent=2))
