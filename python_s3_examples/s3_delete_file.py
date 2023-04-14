
# upload to S3 bucket through S3 client
import boto3

s3 = boto3.resource('s3')

bucket_name = 'sc-mah-bukkit-py1'
file_name = 'wooot.txt'


#file_name ois the object key in bucket
object = s3.Object(bucket_name, file_name)

#file_name is file name
object.delete


print(f'{file_name} has been deleted')