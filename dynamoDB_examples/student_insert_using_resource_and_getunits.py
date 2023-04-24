# using resource, we don't have to add type information along with values 
import boto3
import json

dynamodb_resource = boto3.resource('dynamodb')

item = {} # dictionary 
item['Rollno'] = 103
item['Name'] = 'Jane'
item['Age'] = 23
item['Result'] = 'Fail'

table_name= 'Student'
table = dynamodb_resource.Table(table_name)

response = table.put_item(Item=item, ReturnConsumedCapacity='TOTAL')

print(json.dumps(response, indent=2))
