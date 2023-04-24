import boto3
from pprint import pprint

dynamodb_resource = boto3.resource('dynamodb')

table_name = 'Student'
student_table = dynamodb_resource.Table(table_name)

response = student_table.update_item(Key={'Rollno': 101}, 
                                     UpdateExpression='set #abc = :n',    
                                     ExpressionAttributeNames={'#abc' : 'Subject'},
                                     ExpressionAttributeValues={':n' : 'Physics'},
                                     ReturnValues='UPDATED_NEW')

pprint(response['Attributes'])
