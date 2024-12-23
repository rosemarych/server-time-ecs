# ECS Deployment of Server Time Application

## Overview
This project provisions an AWS Elastic Container Service (ECS) environment to deploy the **server-time** application using Terraform. The application returns the current server time.

## Prerequisites
- AWS Account
- Terraform CLI installed
- AWS CLI configured with credentials

## Steps to Deploy
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>

2. Initialize Terraform:
    ```bash
    terraform init

3. Apply the Terraform plan:
    ```bash
    terraform apply -auto-approve

4. Access the application using the ALB DNS name in the Terraform output:
    ```bash
    alb_dns_name = http://<ALB-DNS-Name>