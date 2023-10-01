terraform {
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "terrahouse_website" {
  bucket = var.bucket_name
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html

    tags = {
    UserUuid    = var.user_uuid
  }
}
