import boto3

s3_resource = boto3.resource('s3')

bucket_name = 'demobucket250-e67018'
file_name = 'abc.txt'
key_name = 'xyz.txt'

bucket = s3_resource.Bucket(bucket_name)

# Filename is the local file whose content needs to be uploaded
# Key is the identification of the uploaded object in the bucket
bucket.upload_file(Filename=file_name, Key=key_name)

print(f'{file_name} has been uploaded to {bucket_name} bucket with key {key_name}')
