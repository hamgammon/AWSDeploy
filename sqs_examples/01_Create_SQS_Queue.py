import boto3
import json
from pprint import pprint

sqs_client = boto3.client('sqs', region_name='us-east-1')

response = sqs_client.create_queue(
                QueueName='DemoQueue4', Attributes={'DelaySeconds':'0', 'VisibilityTimeout':'30'})

#print(response)
#print(json.dumps(response, indent=2))
pprint(response)
