terraform {

  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "agoetee"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_roadrash" {
  source = "./modules/terrahome_aws"
#  bucket_name = var.bucket_name
  user_uuid = var.teacherseat_user_uuid
  public_path = var.roadrash.public_path
  content_version = var.content_version
}

resource "terratowns_home" "RoadRash" {
  name = "Road Rash"
  description = <<DESCRIPTION
  RoadRash is a MotorBike game of voilence. There are multiple players and each has his special
Weapon to be used during the race.
Since there is voilence, there is the Police too who happens to be more voilent with his Rod and Siren.
The game features all-California locales: The City, The Peninsula, Pacific Coast Highway, Sierra Nevada, and Napa Valley.
The roads themselves feature brief divided road sections.
DESCRIPTION
  domain_name = module.home_roadrash.domain_name
  #domain_name = "21dewe.cloudfront.net"
  town = "missingo"
  content_version = var.roadrash.content_version
}

module "home_visit_ghana" {
  source = "./modules/terrahome_aws"
#  bucket_name = var.bucket_name
  user_uuid = var.teacherseat_user_uuid
  public_path = var.visit_ghana.public_path
  content_version = var.visit_ghana.content_version
}

resource "terratowns_home" "Visit_Ghana" {
  name = "Visit Ghana"
  description = <<DESCRIPTION
  The tourism industry in Ghana is known to promote sustainable tourism that includes: cultural tourism, heritage tourism,
  recreational tourism, adventure tourism and event tourism. Cultural tourism focuses on festivals and events, whereas heritage 
  tourism focuses on the history of the slave routes. Recreational tourism allows tourists to explore beaches and theme parks. 
  Adventure tourism takes a look at rain forests and game parks. Click to view more fun things to do in Ghana.
DESCRIPTION

  domain_name = module.home_visit_ghana.domain_name
  #domain_name = "21dewe.cloudfront.net"
  town = "missingo"
  content_version = var.visit_ghana.content_version
}
module "home_food_ghana" {
  source = "./modules/terrahome_aws"
#  bucket_name = var.bucket_name
  user_uuid = var.teacherseat_user_uuid
  public_path = var.food_ghana.public_path
  content_version = var.food_ghana.content_version
}
resource "terratowns_home" "Food_Ghana" {
  name = "Food Ghana"
  description = <<DESCRIPTION
  The main dishes of Ghana are organized around starchy staple foods, which goes with either sauce or soup accompanied 
with a source of protein. Yam, maize and beans are used across Ghana as staple foods. The selected maize 
is used to prepare different kinds of food. A lot of photographs are shown when you click to view.
DESCRIPTION

  domain_name = module.home_food_ghana.domain_name
  #domain_name = "21dewe.cloudfront.net"
  town = "missingo"
  content_version = var.food_ghana.content_version
}