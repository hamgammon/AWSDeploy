# using resource, we don't have to add type information along with values 
import boto3

dynamodb_resource = boto3.resource('dynamodb')

item = {} # dictionary 
item['Rollno'] = 102
item['Name'] = 'Mat'
item['Age'] = 19
item['Result'] = 'Pass'

table_name= 'Student'
table = dynamodb_resource.Table(table_name)

response = table.put_item(Item=item)

print(response)
