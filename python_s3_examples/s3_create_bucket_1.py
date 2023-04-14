import boto3

s3 = boto3.resource('s3') #service name is the parameter

bucket_name = "sc-mah-bukkit-py1"

#creates is in us-east-01 by default
#s3.create_bucket(Bucket=bucket_name)

#specifiy region where other than us-east-1
s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint':'us-west-2'})                 
print(bucket_name, 'has been created.')