import boto3

s3 = boto3.resource('s3')


def get_object(bucket, key):
    try:
        obj = s3.Object(bucket, key)
        print(obj.get()['Body'].read().decode('utf-8'))
        return obj.get()['Body'].read().decode('utf-8')
    except Exception as e:
        print('Error:')
        print(e)


mybucket = 'shared-s3-bucket-YourAccountNumberGoesHere'
mykey = 'ec2_standard.sh'

get_object(mybucket, mykey)
