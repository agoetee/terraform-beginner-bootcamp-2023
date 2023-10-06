output "bucket_name" {
  description = "bucket name for our website hosting"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "The cloudfront distribution Domain name"
  value = module.terrahouse_aws.cloudfront_url
}