# AWS Configuration
variable "aws_region" {
  description = "The AWS region to deploy resources."
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use."
  default     = "default"
}

# Tags
variable "resource_tags" {
  description = "Tags to apply to all resources."
  default = {
    Environment = "production"
    Project     = "server_time"
  }
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# ECS Configuration
variable "container_image" {
  description = "Docker container image for ECS."
  default     = "rosemarych/server-time:latest"
}

# ALB Configuration
variable "alb_listener_port" {
  description = "Port for the ALB listener."
  default     = 80
}
