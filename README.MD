### AWS Resource Auto-Tagging System with Terraform

This project leverages Terraform to automate the tagging of AWS resources that are detected as untagged by AWS Config rules. The system employs a combination of AWS Config, AWS Lambda, and Amazon EventBridge to monitor and enforce tagging policies across specified resource types within an AWS environment.

#### Project Structure

The Terraform configuration is modularized into three primary components:

- **Config Module**: Manages AWS Config rules to detect untagged resources.
- **Lambda Module**: Contains the Lambda function used to automatically tag resources.
- **EventBridge Module**: Sets up EventBridge rules to trigger the Lambda function based on AWS Config rule findings.

The directory structure is organized as follows:

```
terraform-tagging-automation/
│
├── main.tf       # Main Terraform configuration file
├── variables.tf  # Variable declarations
├── outputs.tf    # Outputs from the Terraform modules
│
├── modules/      # Terraform modules
│   ├── config/   # AWS Config module
│   ├── lambda/   # AWS Lambda module
│   └── eventbridge/ # EventBridge module
```

#### Prerequisites

- Terraform v0.14 or newer
- AWS CLI configured with Administrator access
- An S3 bucket for the Lambda deployment package

#### Setup and Configuration

1. **Lambda Function Code**:
   - Place your Python Lambda function code and any dependencies in the `src` directory within the `lambda` module.
   - Use the provided shell script `package_lambda.sh` to package your Lambda function. This script automates the packaging of your Python Lambda function, including any dependencies, into a ZIP file for deployment.

2. **Terraform Variables Configuration**:
   - Define necessary variables such as `resource_types`, `s3_bucket_name`, and `s3_key` in your `.tfvars` file for environment-specific configurations.

Example content of `terraform.tfvars`:
```hcl
resource_types = ["AWS::EC2::Instance", "AWS::S3::Bucket"]
s3_bucket_name = "my-lambda-deployments"
s3_key = "lambda_function.zip"
```

3. **Deploy the Infrastructure**:
   - Initialize Terraform with `terraform init` to download necessary providers.
   - Deploy your configurations with `terraform apply -var-file="prod.tfvars"` to apply your infrastructure setup.

#### Deployment Steps

1. **Package Lambda Function**:
   - Run the packaging script `package_lambda.sh` which is invoked automatically by Terraform using the `null_resource` with a `local-exec` provisioner.

2. **Update and Deploy**:
   - Terraform manages the deployment of your Lambda function, ensuring that the most recent code is packaged and uploaded to an S3 bucket before updating the Lambda function.

3. **Monitor and Maintain**:
   - Use Terraform outputs to retrieve important information like AWS Config rule IDs and Lambda function ARNs.
   - Monitor the execution and effectiveness of the Lambda function through AWS CloudWatch linked via EventBridge.

#### Enhancements and Security

- **Environment Variables**: The Lambda function configuration now includes environment variables, which are defined in the Terraform module and can be adjusted as needed for different deployments.
- **Security Practices**: Ensure IAM roles and policies are tightly scoped to minimize permissions while still allowing necessary actions.

#### Contribution and Support

- **Contributions**: Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.
- **Support**: For bugs and feature requests, please use the GitHub issues section of this repository.

This README file includes comprehensive instructions for deploying and managing the AWS resource auto-tagging system using Terraform. It highlights the automated deployment of the Python Lambda function, handling of environment-specific configurations, and security best practices..