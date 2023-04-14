import boto3

s3 = boto3.resource('s3') #service name is the parameter

bucket_name = 'mydemobucket2025-west-py'

#Bucket is created in us-east-1
#s3.create_bucket(Bucket=bucket_name)

#Location constraint is need for any region other than us-east-1
s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint':'us-west-2'})

print(bucket_name, 'has been created')
