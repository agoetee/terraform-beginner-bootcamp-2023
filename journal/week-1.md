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

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform cloud, there are two kinds of variables.

- Terraform Variables - those that would be set in the bash terminal eg. AWS credentials
- Environment Variables - those that would normally be set in the `.tfvar` files

We can set Terraform cloud variables to be to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input

[Terraform Variables](https://developer.hashicorp.com/terraform/language/values)

#### var flag

We can use the `-var` flag to set an input variable or override a variable in the tfvars file. eg. `terraform -var user_uuid="my_user_uuid"`

#### var-file flag

- TODO - document the use of the `var-file` flag

### terraform.tfvars

This is the default file to load in terraform variables in blank

### auto.tfvars

- TODO - document the use of this functionality for terraform cloud

### Order of Terraform variables

- TODO - document which terraform variables take precedence. 