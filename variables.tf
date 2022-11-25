variable "project_name" {
    type        = string
    default     = "terraform_aws_cross_account_demo"
    description = "Project name - used to build resource names"
}

variable "region" {
    type        = string
    default     = "eu-west-1"
    description = "AWS region for deployment"
}

variable "destination_account" {
    type        = string
    default     = "468176841679"
    description = "account id for destination account"
}

variable "bucket_pattern" {
    type        = string
    default     = "cross-account-bucket"
    description = "suffix for s3 cross account buckets"
}