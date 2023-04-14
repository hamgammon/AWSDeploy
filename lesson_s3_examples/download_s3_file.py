import boto3

s3 = boto3.resource('s3') #service name is the parameter

bucket_name = 'demobucket250-e67018'
file_name = 'Tiger.jpg'

# file_name is the object key in bucket
object = s3.Object(bucket_name, file_name)


# file_name is the name with which we want to save the file locally
object.download_file(file_name)

print(f'{file_name} has been downloaded from Bucket - {bucket_name}\nSaved as {file_name}')