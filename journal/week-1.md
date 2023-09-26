# Terraform Beginner Bootcamp 2023 Week 1

## Root Module Structure

The root module structure is as follows:

```
PROJECT_ROOT
├── main.tf        - the primary entry point
├── variables.tf   - contains variables and should be described in a sentence or two
├── terraform.tfvars - the data of variables we want to load into our Terraform project
├── providers.tf   - contains providers
├── outputs.tf     - contains outputs and should be described
└── README.md      - required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
