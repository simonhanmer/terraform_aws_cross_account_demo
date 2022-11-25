provider "aws" {
    region = var.region
    default_tags {
        tags = {
            Project = "AWS Cross Account demo"
            Repo    = "terraform_aws_cross_account_demo"
        }
    }
}

terraform {
    backend "s3" {
        key            = "terraform_aws_cross_account_demo"
        dynamodb_table = "terraform-lock-table"
        # region         = "eu-west-1"
    }
}