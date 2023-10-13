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
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token

}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
#  bucket_name = var.bucket_name
  user_uuid = var.teacherseat_user_uuid
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Road Rash"
  description = <<DESCRIPTION
  RoadRash is a MotorBike game of voilence. There are multiple players and each has his special
Weapon to be used during the race.
Since there is voilence, there is the Police too who happens to be more voilent with his Rod and Siren.
The game features all-California locales: The City, The Peninsula, Pacific Coast Highway, Sierra Nevada, and Napa Valley.
The roads themselves feature brief divided road sections.
DESCRIPTION

  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "21dewe.cloudfront.net"
  town = "missingo"
  content_version = 1
}