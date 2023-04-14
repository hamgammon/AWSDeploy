#create bucket by picking the region from the session

import boto3
import uuid

def get_bucket_name(bucket_prefix):
    return bucket_prefix + '-' + str(uuid.uuid4())[:6]


def create_bucket(bucket_prefix, s3_resource):
    session = boto3.session.Session()
    region_name = session.region_name
    print('Region name in session:', region_name)
    bucket_name = get_bucket_name(bucket_prefix)
    if region_name == 'us-east-1':
        bucket_response = s3_resource.create_bucket(Bucket=bucket_name)
    else:
        bucket_response = s3_resource.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint':region_name})

    return bucket_response


bucket_prefix = 'demobucket250'
s3 = boto3.resource('s3')
bucket_response = create_bucket(bucket_prefix,s3)
print(bucket_response)
