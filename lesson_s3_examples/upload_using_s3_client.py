# upload to S3 bucket through S3 client

import boto3

bucket_name = 'demobucket250-e67018'
file_name = 'abc.txt'


# s3_resource = boto3.resource('s3')
# s3_client = s3_resource.meta.client
# s3_client.upload_file(Bucket=bucket_name, Filename=file_name, Key=file_name)

#OR

s3_client = boto3.client('s3')
s3_client.upload_file(Bucket=bucket_name, Filename=file_name, Key=file_name)

print(f'{file_name} has been uploaded to {bucket_name} bucket')
