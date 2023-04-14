import boto3

s3 = boto3.resource('s3') #service name is the parameter

for bucket in s3.buckets.all():
    print(bucket.name)

