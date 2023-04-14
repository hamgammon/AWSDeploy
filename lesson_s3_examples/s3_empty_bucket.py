import boto3

s3 = boto3.resource('s3') #service name is the parameter

bucket_name = 'demobucket250-db82b0'
bucket = s3.Bucket(bucket_name)

objects_to_be_deleted = []

for object_version in bucket.object_versions.all():
    objects_to_be_deleted.append({
                            'Key': object_version.object_key,
                            'VersionId' : object_version.id
                            })

if len(objects_to_be_deleted) > 0:
    print('Following objects will be deleted:')
    print()
    print(objects_to_be_deleted)
    bucket.delete_objects(Delete={'Objects' : objects_to_be_deleted})
    print()
    print('Bucket is now Empty')
else:
    print('Bucket is Empty')