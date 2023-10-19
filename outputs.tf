output "bucket_name" {
  description = "bucket name for our website hosting"
  value = module.home_roadrash.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.home_roadrash.website_endpoint
}

output "cloudfront_url" {
  description = "The cloudfront distribution Domain name"
  value = module.home_roadrash.domain_name
}