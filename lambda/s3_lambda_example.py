import json
import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):

    bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key'] 
    
    response = s3.get_object(Bucket=bucket_name, Key=key)
    content_type = response['ContentType']

    print('Bucket name:', bucket_name)
    print('Object :', key)
    print('Content type:', content_type)

    return {
        'statusCode': 200,
        'body': json.dumps(key)
           }