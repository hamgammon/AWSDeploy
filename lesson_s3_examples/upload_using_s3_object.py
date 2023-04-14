import boto3

s3_resource = boto3.resource('s3')

bucket_name = 'demobucket250-db82b0'
file_name = 'Tiger.jpg'

object = s3_resource.Object(bucket_name, file_name)
object.upload_file(Filename=file_name)

print(f'{file_name} has been uploaded to {bucket_name}')
