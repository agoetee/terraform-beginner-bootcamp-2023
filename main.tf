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
}
