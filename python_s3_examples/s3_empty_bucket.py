import boto3

s3 = boto3.resource('s3') #service name is the parameter

bucket_name = 'sc-mah-bukkit-py1'
bucket = s3.Bucket(bucket_name)

objects_to_be_deleted = []

for object_version in bucket.object_versions.all():
    objects_to_be_deleted.append({
                        'Key': object_version.object_key,
                        'VersionId': object_version.id
    })
    print(f'the following will be deledted')
    print()
    print(objects_to_be_deleted)
    print()

    bucket.delete_objects(Delete={'Objects' : objects_to_be_deleted})