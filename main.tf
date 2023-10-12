terraform {

  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
#  cloud {
#    organization = "agoetee"
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"

}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  bucket_name = var.bucket_name
#  user_uuid = var.user_uuid
#  error_html_filepath = var.error_html_filepath
#  index_html_filepath = var.index_html_filepath
#  content_version = var.content_version
#  assets_path = var.assets_path
#}

resource "terratowns_home" "the_ampe" {
  name = "the game ampe"
  description = <<DESCRIPTION
  Ampe is a game mainly played by ladies.
The basic features involve clapping the hands in some unison and jumping.
Most of the time, rythmic singing that goes with the clapping and jumping.
DESCRIPTION

  #domain_name = "module.terrahouse_aws.cloudfront_url"
  domain_name = "21dewe.cloudfront.net"
  town = "missingo"
  content_version = 1
}