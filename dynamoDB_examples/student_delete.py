import boto3
from pprint import pprint

dynamodb_resource = boto3.resource('dynamodb')

table_name = 'Student'
student_table = dynamodb_resource.Table(table_name)

response = student_table.delete_item(Key={'Rollno':102})

pprint(response)
