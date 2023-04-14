#create a bucket in the region specified in the S3 connection

import boto3
import uuid

def get_bucket_name(bucket_prefix):
    return bucket_prefix + '-' + str(uuid.uuid4())[:6]


def create_bucket(bucket_prefix, s3_resource):
    bucket_name = get_bucket_name(bucket_prefix)
    region_name = s3_resource.meta.client._client_config.region_name
    if region_name == 'us-east-1':
        bucket_response = s3_resource.create_bucket(Bucket=bucket_name)
    else:
        bucket_response = s3_resource.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint':region_name})

    return bucket_response


bucket_prefix = 'demobucket250'


#provided credentials will be used else picked from CLI configuration if not provided  
s3 = boto3.resource('s3', 
                    aws_access_key_id='AKIA6KD4T5TKFOIN2Y5F', 
                    aws_secret_access_key='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', 
                    region_name='us-east-1')

bucket_response = create_bucket(bucket_prefix,s3)
print(bucket_response)
