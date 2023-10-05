# Terraform Beginner Bootcamp 2023 Week 1

## Git - Fixing Tags

[Delete Tags, Local and Remote in Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

_Local tag delete_
`$ git tag -d <tag_name>`

_Remote tag delete_
`$ git push --delete origin tagname`

Checkout the commit you want to retag and do so. Grab the SHA from the Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

## Dealing with Configuration Drift

### What happens if you loose your state file

If you lose your state file, you most likely have to tear down your cloud infrastructure manually.

You can use terraform import but it wont work for all cloud resources. You need to check the terraform providers documentation for which resources support imports.

### Fix missing resources with Terraform 

```
# terraform import aws_s3_bucket.bucket bucket-name
```
[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 bucket import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix manual Configuration

If someone deletes or modifies cloud resources manually.

If we run terraform run, it will attempt to put our infrastructure back to the expected state fixing the Configuration Drift.

### Fix Using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```


## Terraform Modules

### Terraform Modules Structure

It is recommended to place modules in a `modules` directory when developing local modules, but can be named whatever

### Passing Input Variables

We can pass input variables to our module. The module has to declare the terraform variables in its own variables.tf file.

```t
module "terrahouse_aws" {
    sousource = "./modules/terrahouse_aws"
    bucket_name = var.bucket_name
    user_uuid = var.user_uuid
}

```

### Module Sources

Using the source, we can import the the module from various places. eg. 
> github
> AWS storage
> local paths
> etc

```t
module "terrahouse_aws" {
    sousource = "./modules/terrahouse_aws"
}

```
[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLM's such as ChatGPT may not be trained on the latest documentation or information about terraform.

It may likely produce older examples that could be deprecated, oftern affecting providers.

## Working with Files in Terraform

### Fileexist Function

```js
validation {
  condition     = can(fileexists(var.index_html_filepath))
  error_message = "The specified file does not exist. Please provide a valid filepath."
}

```

### filemd5 - [Built in functions](https://developer.hashicorp.com/terraform/language/functions)


[](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Values in the Filesystem

- `path.module` is the path of the module where the expression is placed. 
- `path.root` is the filesystem path of the root module of the configuration.

[Special Path Variables](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```t
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.terrahouse_website.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  etag = filemd5("${path.root}/public/index.html")
}
```

## Terraform Locals

[LOcal Values](https://developer.hashicorp.com/terraform/language/values/locals)

Locals allow us to define local variables.

It can be very useful when we need to transform data into another format and have referenced a variable.

```js
locals {
  s3_origin_id = "MyS3Origin"
}

```

## Terraform Data Sources

This allows us to source data from cloud resources

This is useful when we want to reference cloud resources without importing them.

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

[Data Source: Caller Identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)

```t
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

## Working with JSON

we use the jsonencode to create the json policy in the hcl.

```h
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode Function](https://developer.hashicorp.com/terraform/language/functions/jsonencode)