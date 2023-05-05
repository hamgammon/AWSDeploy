import boto3
import json

sqs_client = boto3.client('sqs', region_name='us-east-1')

queue_url = sqs_client.get_queue_url(QueueName='MyDemoQueue')['QueueUrl']

flag = True 

while flag:
    response = sqs_client.receive_message(QueueUrl=queue_url, MaxNumberOfMessages=10, WaitTimeSeconds=0)
    
    if 'Messages' in response:
        messages_list = response['Messages']
        print('Number of Messages received:', len(messages_list))
        print()

        for message in messages_list:
            print('Message body:', message['Body'])
            print()
            #print('Receipt Handle:', message['ReceiptHandle'])
            #print()
        
        read_again = input('Do you wish to continue (y/n):')

        if read_again.lower() == 'y':
            continue
        else:
            flag = False
    else:
        print('Sorry...no more messages')
        flag = False
