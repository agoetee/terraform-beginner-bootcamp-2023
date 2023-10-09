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

## Changing the Lifecycle of Resources

[Meta-arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[terraform_data Managed Resource](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow you to execute commands on compute instances eg AWS CLI command

They are not recommended for use by Harshicorp because Configuration Management tools like Ansible are a better fit but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute commands on the machine running the commands eg plan, apply

[Local exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

```js
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

### Remote-exec

This will execute commands on the machine you target. You will need to provide credentials such as ssh to log into the machine

[Remote exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)

```js
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```

### Multi line Codeblock

The multi-line syntax did not work for the local Exec provisioning  as shown in this code snippet:

```js
provisioner "local-exec" {
  command = <<COMMAND
aws cloudfront create-invalidation \
--distribution-id ${aws_cloudfront_distribution.s3_distribution.id} \
--paths '/*'
COMMAND
}
```
The correct syntax that worked was the single line :

```js
provisioner "local-exec" {
  command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.s3_distribution.id} --paths '/*'"
}
```

## For Each Expressions

For and For_each allows us to enumerate over complex data types

```s
[for s in var.list : upper(s) if s != ""]
```

This is mostly useful whiles creating multiples of cloud resources. And yu want to reduce the amount of terraform code

- [For Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)

- [For_each Expression](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

## Interpolation Syntax

In Interpolation syntax, text is wrapped in `${}`, such as `${var.foo}`. The interpolation syntax is powerful and allows you to reference variables, attributes of resources, call functions, etc.

It was used at the `.../modules/terrahouse/resource-storage.tf` file to refer to the source of the `./public/assets/` folder. 

```s
 source = "${var.assets_path}${each.key}"
  etag = filemd5("${var.assets_path}${each.key}")
```

[Interpolation Syntax](https://www.koding.com/docs/terraform/configuration/interpolation.html/#:~:text=The%20interpolation%20syntax%20is%20powerful,index%20%2B%201%7D%20.)