import boto3

s3_resource = boto3.resource('s3') #service name is the parameter

bucket_name = 'sc-mah-bukkit-py1'

bucket_versioning = s3_resource.BucketVersioning(bucket_name)
bucket_versioning.enable
bucket_versioning = s3_resource.BucketVersioning(bucket_name)
