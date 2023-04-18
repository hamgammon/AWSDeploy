import boto3

dynamodb_resource = boto3.resource('dynamodb')

item = {}
item['RollNo'] = '104'
item['Name'] = 'Matt'
item['Age'] = 24
item['Result'] = 'Pass'

table_name = 'Student'
table = dynamodb_resource.Table(table_name)

response = table.put_item(Item=item)
print(response)