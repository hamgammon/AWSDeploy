import boto3

dynamodb_client = boto3.client('dynamodb')

table_name = 'Student'

item = {}
item['RollNo'] = {'S':'103'}
item['Name'] = {'S':'Bobberton'}
item['Age'] = {'N':'21'}
item['Result'] = {'S':'Fail'}

response = dynamodb_client.put_item(TableName=table_name, Item=item)

print(response)