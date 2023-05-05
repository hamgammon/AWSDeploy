import boto3

sqs_client = boto3.client('sqs', region_name='us-east-1')
response = sqs_client.get_queue_url(QueueName='MyDemoQueue')
print(response['QueueUrl'])
