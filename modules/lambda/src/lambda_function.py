import boto3

def lambda_handler(event, context):
    # Extract resource information from the AWS Config event
    resource_type = event['detail']['resourceType']
    resource_id = event['detail']['resourceId']

    # Define default tags
    default_tags = {
        'Environment': 'Development',
        'Owner': 'DefaultOwner',
        'Project': 'Unassigned'
    }

    # Initialize the appropriate client based on resource type
    if resource_type == 'AWS::EC2::Instance':
        client = boto3.client('ec2')
        client.create_tags(
            Resources=[resource_id],
            Tags=[{'Key': k, 'Value': v} for k, v in default_tags.items()]
        )
    elif resource_type == 'AWS::S3::Bucket':
        client = boto3.client('s3')
        # S3 bucket tagging is a bit different
        client.put_bucket_tagging(
            Bucket=resource_id,
            Tagging={'TagSet': [{'Key': k, 'Value': v} for k, v in default_tags.items()]}
        )
    # Add more conditions for other resource types as necessary

    return {
        'message': f"Tags applied to {resource_id} of type {resource_type}",
        'status': 200
    }
