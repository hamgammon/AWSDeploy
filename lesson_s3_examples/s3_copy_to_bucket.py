import boto3

s3 = boto3.resource('s3') #service name is the parameter

source_bucket_name = 'mydemobucket2020'
dest_bucket_name = 'mydemobucket2030'
object_to_be_copied = 'Tiger.jpg'

copy_source = {}
copy_source['Bucket'] = source_bucket_name
copy_source['Key'] = object_to_be_copied

s3.Object(dest_bucket_name, object_to_be_copied).copy(copy_source)

#delete from source after copy to dest
#s3.Object(source_bucket_name, object_to_be_copied).delete()

print(f'{object_to_be_copied} has been copied from {source_bucket_name} to {dest_bucket_name}')