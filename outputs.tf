output "bucket_name" {
  description = "bucket name for our website hosting"
  value = ["module.home_roadrash.bucket_name", "module.home_visit_ghana.bucket_name", "module.home_food_ghana.bucket_name",]
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = ["module.home_roadrash.website_endpoint", "module.home_visit_ghana.website_endpoint", "module.home_food_ghana.website_endpoint",]
}

output "cloudfront_url" {
  description = "The cloudfront distribution Domain name"
  value = ["module.home_roadrash.domain_name", "module.home_visit_ghana.domain_name", "module.home_food_ghana.domain_name",]
}