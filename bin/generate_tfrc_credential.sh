#!/bin/bash

# Define the output directory and file path
output_dir="/home/gitpod/.terraform.d/"
output_file="${output_dir}credentials.tfrc.json"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Check if TERRAFORM_CLOUD_TOKEN is set
if [ -z "$TERRAFORM_CLOUD_TOKEN" ]; then
  echo "Error: TERRAFORM_CLOUD_TOKEN environment variable is not set."
  exit 1
fi

# Define the JSON structure
json_data='{
  "credentials": {
    "app.terraform.io": {
      "token": "'"$TERRAFORM_CLOUD_TOKEN"'"
    }
  }
}'

# Write the JSON data to the specified file
echo "$json_data" > "$output_file"

echo "$output_file has been created with the Terraform Cloud token."
