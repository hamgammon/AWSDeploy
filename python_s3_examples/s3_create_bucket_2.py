import boto3

session = boto3.session.Session()
s3 = boto3.resource('s3')
bucket_name = 'sc-mah-bukkit-py2-us-east-1-3'

print('I am in', session.region_name)

if session.region_name == 'us-east-1':
    print('Bucket going to be made in default reigon us-east-1')
    s3.create_bucket(Bucket=bucket_name)
    print(bucket_name,'made in us-east-1')
else:
    print('Making', bucket_name,'in', session.region_name)
    s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint':session.region_name})
    print(bucket_name,'made in',session.region_name)           

print('\nHere are all your buckets\n')
for bucket in s3.buckets.all():
    print(bucket.name)