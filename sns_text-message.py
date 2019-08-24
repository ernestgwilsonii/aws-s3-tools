import boto3
sns = boto3.client('sns', region_name='us-east-1')
phone_number = '+15558675309'
# Must have AWS Role: AmazonSNSFullAccess <--Needed to publish
sns.publish(Message='Hello from sns!',PhoneNumber=phone_number)