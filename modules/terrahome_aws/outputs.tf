output "bucket_name" {
  value = aws_s3_bucket.terrahouse_website.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.terrahouse_configuration.website_endpoint

}

output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}