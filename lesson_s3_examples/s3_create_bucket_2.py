import boto3

bucket_name = 'mydemobucket2050-east'

s3 = boto3.resource('s3') #service name is the parameter

session = boto3.session.Session()
region_name = session.region_name

if region_name == 'us-east-1':
    s3.create_bucket(Bucket=bucket_name)
else:
    s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint':region_name})

print(bucket_name, 'has been created')
