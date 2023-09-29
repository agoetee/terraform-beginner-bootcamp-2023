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

It can be set multiple times on the same line to denote different variables. eg `terraform apply -var='image_id_list=["ami-abc123","ami-def456"]' -var="instance_type=t2.micro"`

#### var-file flag

- TODO - document the use of the `var-file` flag
> THE DO
The `-var-file` flag is used to specify a variable file that contains values for variables defined in the Terraform configuration. It allows for seperation of the variable values from the code and reuse the configurations. A path to the variable can be provided like this: `terraform apply -var-file=my_variables.tfvars`. 

### terraform.tfvars

This is the default file to load in terraform variables in blank

### auto.tfvars

- TODO - document the use of this functionality for terraform cloud

> THE DO

Terraform automatically loads variables in the file `.auto.tfvar`. It is a convinient way to set default values for variables without explicitly specifying them.

### Order of Terraform variables

- TODO - document which terraform variables take precedence.
> THE DO

- Environment variables. Terraform looks for variables set as Environment variables
- The terraform.tfvars or *auto.tfvars file, if present. Terraform automatically loads variables from this files. Values here override defaults but are overridden by environmental variables
- The Command line option -vars. - whiles runnung the `terraform apply` or `terraform run` commands. values here override both those in .tfvars and environment variables.
- Variable Defaults in the Configuration: If no value is provided via environment variables, files, or command-line options, Terraform uses the default value specified in the variable declaration within the Terraform configuration file
