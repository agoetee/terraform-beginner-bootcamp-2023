terraform {
#  cloud {
#    organization = "agoetee"
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  bucket_name = var.bucket_name
  user_uuid = var.user_uuid
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
}
