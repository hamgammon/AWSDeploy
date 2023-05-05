import boto3

sqs_client = boto3.client('sqs', region_name='us-east-1')

response = sqs_client.list_queues()

for queue_url in response['QueueUrls']:
    print(queue_url)

