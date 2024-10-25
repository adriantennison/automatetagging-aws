### README: AWS Resource Auto-Tagging System with Terraform

This project provides a Terraform-based solution to automatically tag AWS resources that are detected as untaged by AWS Config rules. The system uses a combination of AWS Config, AWS Lambda, and Amazon EventBridge (formerly AWS CloudWatch Events) to monitor and enforce tagging policies across specified resource types within an AWS environment.

### Project Structure

The Terraform configuration is modularized into three main components:

- **Config Module**: Manages AWS Config rules to detect untagged resources.
- **Lambda Module**: Contains the Lambda function used to automatically tag resources.
- **EventBridge Module**: Sets up EventBridge rules to trigger the Lambda function based on AWS Config rule findings.

The directory structure is as follows:

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

### Prerequisites

- Terraform v0.14 or newer
- AWS CLI configured with Administrator access
- An S3 bucket for Lambda deployment package

### Setup and Configuration

1. **Prepare Lambda Function Code**:
   - Package your Lambda function code into a ZIP file and upload it to an S3 bucket. This function should have the logic to apply tags to AWS resources.

2. **Configure Terraform Variables**:
   - Create a `terraform.tfvars` file or multiple `.tfvars` files for different environments (e.g., `prod.tfvars`, `dev.tfvars`).
   - Define the required variables such as `resource_types`, `lambda_s3_bucket`, and `lambda_s3_key`.

Example `terraform.tfvars` content:
```hcl
resource_types = ["AWS::EC2::Instance", "AWS::S3::Bucket"]
lambda_s3_bucket = "my-lambda-bucket"
lambda_s3_key = "lambda-code.zip"
```

3. **Initialize Terraform**:
   - Run `terraform init` in the project directory to initialize Terraform and download the necessary providers.

4. **Deploy the Infrastructure**:
   - Execute `terraform plan -var-file="prod.tfvars"` to see the deployment plan.
   - Apply the configuration using `terraform apply -var-file="prod.tfvars"`.

### Usage

Once deployed, the system will automatically monitor the specified AWS resource types for missing tags as defined in the AWS Config rule. When a resource is detected as untagged, the EventBridge rule will trigger the Lambda function to apply the default tags.

### Improvements

1. **Expand Resource Coverage**:
   - Update the `resource_types` variable to include additional AWS resource types that support tagging.

2. **Enhance Tagging Logic**:
   - Modify the Lambda function to implement more complex tagging logic, possibly using external data sources to determine appropriate tags.

3. **Security Enhancements**:
   - Ensure that the IAM roles and policies assigned to the Lambda function adhere strictly to the principle of least privilege.

4. **Error Handling and Monitoring**:
   - Add error handling in the Lambda function to manage tagging failures.
   - Set up additional monitoring and alerts through AWS CloudWatch for the Lambda function and EventBridge rule.

5. **Environment Specific Configurations**:
   - Utilize workspace or additional `.tfvars` files for managing multiple environments to ensure isolation between production, development, and staging configurations.

### Contributing

Contributions to improve the auto-tagging system are welcome. Before making any changes, please discuss the changes via issue or email with the repository maintainers.

### Support

For support, feature requests, or bug reporting, please open an issue in the repository or contact the maintainers directly.

This README outlines how to deploy and manage the AWS resource auto-tagging system using Terraform and provides guidance for potential improvements to the system.