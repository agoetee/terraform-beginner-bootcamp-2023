variable "user_uuid" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_html_filepath" {
  description = "Filepath to the index.html file"
  type        = string
}

variable "error_html_filepath" {
  description = "Filepath to the error.html file"
  type        = string
}

variable "content_version" {
  description = "Positive integer representing content version"
  type        = number
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}