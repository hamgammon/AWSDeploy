import boto3

s3 = boto3.resource('s3') #service name is the parameter

bucket_name = 'sc-mah-bukkit-py1'

bucket = s3.Bucket(bucket_name)

for object in bucket.objects.all():
    obj = object.Object()
    print(object.key,'-',obj.version_id,'-',obj.storage_class)