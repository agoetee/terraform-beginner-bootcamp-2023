variable "terratowns_access_token" {
  type = string
}
variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "roadrash" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "food_ghana" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "visit_ghana" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "content_version" {
  description = "Positive integer representing content version"
  type        = number
}