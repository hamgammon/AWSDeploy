import boto3
import json

dynamodb_resource = boto3.resource('dynamodb')

item = {}
item['RollNo'] = '105'
item['Name'] = 'Batt'
item['Age'] = 25
item['Result'] = 'Fail'

table_name = 'Student'
table = dynamodb_resource.Table(table_name)

response = table.put_item(Item=item, ReturnConsumedCapacity='TOTAL')
print(json.dumps(response, indent=2))