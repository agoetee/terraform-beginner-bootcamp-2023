variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "user_uuid must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

variable "bucket_name" {
  description = "Name of the AWS S3 bucket"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}$", var.bucket_name))
    error_message = "Bucket name must be between 3 and 63 characters, contain only lowercase letters, numbers, and hyphens, and not have consecutive hyphens."
  }
}

variable "index_html_filepath" {
  description = "Filepath to the index.html file"
  type        = string

  validation {
    condition     = can(fileexists(var.index_html_filepath))
    error_message = "The specified file does not exist. Please provide a valid filepath."
  }
}

variable "error_html_filepath" {
  description = "Filepath to the error.html file"
  type        = string

  validation {
    condition     = can(fileexists(var.error_html_filepath))
    error_message = "The specified file does not exist. Please provide a valid filepath."
  }
}

variable "content_version" {
  description = "Positive integer representing content version"
  type        = number

  validation {
    condition     = can(regex("^[1-9][0-9]*$", tostring(var.content_version)))
    error_message = "content_version must be a positive integer starting at 1."
  }
}