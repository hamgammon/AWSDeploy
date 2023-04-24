import boto3

dynamodb_resource = boto3.resource('dynamodb')

table_name = 'Student'
student_table = dynamodb_resource.Table(table_name)

try:
    response = student_table.delete_item(Key={'Rollno':101}, 
                                     ConditionExpression='#abc = :xyz',
                                     ExpressionAttributeNames={'#abc' : 'Result'},
                                     ExpressionAttributeValues={':xyz':'Fail'})
    print('Item deleted')
except Exception as e:
    print(e.args[0])

