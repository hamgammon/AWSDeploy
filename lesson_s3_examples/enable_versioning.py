import boto3

s3_resource = boto3.resource('s3')

bucket_name = 'demobucket250-db82b0'

bucket_vesioning = s3_resource.BucketVersioning(bucket_name)
print('bucket_vesioning:', bucket_vesioning.status)
bucket_vesioning.enable()
print('bucket_vesioning:', bucket_vesioning.status)