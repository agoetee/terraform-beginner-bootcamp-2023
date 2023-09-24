# Terraform Beginner Bootcamp 2023 Week 0

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform changes](#considerations-with-the-terraform-changes)
  * [Considerations for Linux Distributions](#considerations-for-linux-distributions)
  * [Refactoring into Bash Script](#refactoring-into-bash-script)
    + [Linux permission Execution Considerations](#linux-permission-execution-considerations)
    + [Execute without execute permission](#execute-without-execute-permission)
- [Gitpod Lifecycle)](#gitpod-lifecycle)
- [Working with Environment Variables](#working-with-environment-variables)
  * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
  * [Printing Env Vars](#printing-env-vars)
  * [Scoping of Env Vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS](#aws)
  * [AWS cli Installation](#aws-cli-installation)
  * [AWS S3 bucket](#aws-s3-bucket)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
  * [Terraform Init](#terraform-init)
  * [Terraform plan](#terraform-plan)
  * [Terraform apply](#terraform-apply)
  * [Terraform Destroy](#terraform-destroy)
  * [Terraform Lock Files](#terraform-lock-files)
  * [Terraform State File](#terraform-state-file)
  * [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud Login and Gitpod Workaround](#issues-with-terraform-cloud-login-and-gitpod-workaround)
  * [Terraform to tf alias](#terraform-to-tf-alias)
- [Git and Github stash](#git-and-github-stash)




## Semantic Versioning 

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So I needed to refer to the latest CLI installation instructions on the Terraform documentation and change the scripting for install.

 [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distributions
This project is built against ubuntu.
Please consider checking your linux distribution and change according to your distribution needs.

[How to check Linux Type and distribution](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS distribution

```bash
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into Bash Script
While fixing the Terraform depreciation issues, I noticed that Bash Scripts were a considerable amount more code. So I decided to create a bash script to install the Terraform CLI.

The bash script file is located here: [./bin/install_terraform_CLI](./bin/install_terraform_CLI.sh)

- This will keep the Gitpod Task file tidy
- This will allow an easier way to debud and execute manually Terraform CLI installs
- This will allow better portability for other projects that need to install Terraform CLI
 
 #### Linux permission Execution Considerations
 
 After the shell script have been finalized, the file permisions need to be set to make it executable.
 Generally starts with the `chmod` command followed by the permission and file name. 
 Two ways of applying the executions:

 - By users, example `chmod u+x <filename>` will give the user executing permissions.
 - By arithmetic method `chmod 700 <filename>` gives the user all actions and group and others get __no__ actions at all.
 More on permissions in the link below: 
 [Linux Permissions](https://www.redhat.com/sysadmin/linux-file-permissions-explained)

#### Execute without execute permission

To do this, the command ia as follows:
```sh
source ./bin/install_terraform_CLI.sh
```
 [Execute without execute permission ($source..)](https://www.baeldung.com/linux/run-not-executable-script)

## Gitpod Lifecycle

We need to be careful when using the Init because it will not rerun if we start an existing workspace

 [Gitpod Workspaces[entire tab]](https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle)

## Working with Environment Variables

We can list out all the environment variables(env vars) using the `env` command

We can filter specific env vars with the `grep` command. eg `env | grep ROOT`

### Setting and Unsetting Env Vars

In the terminal, we can set using ```$ export HELLO='Ghana'```

In the terminal, we can unset using `$ unset HELLO`

We can set an env var temporarily when just runnung a command...

```sh
HELLO='Ghana' ./bin/print_message
```

Within a bash script, we can set an env var without writing an export like so:

```sh
!#/bin/bash
HELLO='Ghana'

echo $HELLO
```

### Printing Env Vars

We can print an env var using echo. Example `echo $HELLO`

### Scoping of Env Vars

When you open new bash terminals in VSCode it will not be aware of other env vars you have already set in other windows.

If you want Env Vars to persist accross all future terminals that are open, you need to set env vars in your bash profile

### Persisting Env Vars in Gitpod

We can persist Env Vars into gitpod by storing them in Gitpod secrets Storage.

```sh
gp env HELLO='Ghana'
```

All future workspaces launched will set the env Vars for all bash terminals open in those workspaces

You can also set env vars in the `gitpod.yml` but this can only contain non-sensitive env vars.

## AWS 

### AWS cli Installation

AWS CLI is installed for the project via bash script [./bin/install_aws_cli.sh](./bin/install_aws_cli.sh)

[Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We can check if our AWS credentials is configured correctly by running the following command
```sh
$ aws sts get-caller-identity

```
If the identity call is successful, it should return a json like this:

```json
    "UserId": "QIDAUAYO5SOY1DV7M5GGV",
    "Account": "121314151617",
    "Arn": "arn:aws:iam::121314151617:user/terraform-beginner"
```

We will need to generate AWS user credentials from IAM user in order to use the AWS cli

### AWS S3 bucket

The S3 bucket is s simple storage service by AWS. The idea is to create a random bucket name by the Terraform resource. AWS has restrictions on the naming of S3 buckets such as the name not including _uppercase_ characters etc. [S3 naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)

Initially our random bucket name had _uppercase_ characters and threw an error whiles creating the bucket. We had to specify the _uppercase_ and _lowercase_ options in the json like so:

```json
resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 32
  special = false
}

```
With this, the random S3 bucket name did not have a uppercase and the creation was successful

## Terraform Basics

### Terraform Registry

Terraform sources their _providers_ and _modules_ from Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to API's that will allow to create resources in Terraform
- **Modules** is a way to make large ammount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

### Terraform Console

We can see a lost of all the terraform commands by simply typing `terraform` on the command line.

### Terraform Init

At the start of every Terraform project we run `terraform init` to download the binaries for the terraform providers that we will use in the project.

### Terraform plan 

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. plan to be passed to an apply, but often you can just ignore outputting.


### Terraform apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt 'yes' or 'no'

If we want to automatically approve an apply, we can provide the auto-approve flag eg. `terraform apply --auto-approve`.

### Terraform Destroy
`terraform destroy`
This will destroy resources that has been effected by the terraform apply command.

You can use the auto approve flag to skip the skip the approve prompt eg `terraform destroy --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should ne used for the project.

The terraform lock file **should be committed** to the Version Control Sustem (VCS) eg. Github.

### Terraform State File

`terraform.tfstate` contains information about the current state of your infrastructure.

It **should not be committed** to the Version Control System (VCS)

This file contains sensitive data and if you lose the file, you lose knowing the state of your infrastructure.

`terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains the binaries for the terraform providers.

### Issues with Terraform Cloud Login and Gitpod Workaround

The steps:
- Login to the [Terraform Cloud](https://app.terraform.io/session) login page
- Set up an `organisation`, `Project` and a `workspace`
- Select to connect through CLI
- copy the configuration json into main.tf in Gitpod, the resources section
- Run `terraform login` and pres `P` to print the extended information
- A [token weblink](https://app.terraform.io/app/settings/tokens?source=terraform-login) will display. open in a new tab and copy it.
- When the prompt requests for the token, **right click** to past. _The token will not show_.
- Thats where @Andrew Brown had an issue. This is how He worked around it:

> Create the config file manually by this command:
```sh
$ vi /home/gitpod/.terraform.d/credentials.tfrc.json
```
Copy and paste this snippet and fill in the token.
```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "!@#$%^&^%$#@FQ.atlasv1.VievXqyn2LiLXVTWMcSb1NNTAuFhrEhvy5USqhnIUjFy8ymqOSB5I6kSadExampleToken"
    }
  }
}
```

We have automated the workaround issue with the following bash script: [/bin/generate_tfrc_credential.sh](/bin/generate_tfrc_credential.sh)

Since the bash script is used on start-up, the `.gitpod.yaml` file was updated in the following areas:

```yml
 before: |
      source ./bin/install_terraform_CLI.sh
      source ./bin/generate_tfrc_credential.sh
```
### Terraform to tf alias
We had to reduce the longer 'terraform' to a shorter 'tf' and created a script to do this.
Aliases are placed in the `bash_profile` file. [Info here](https://phoenixnap.com/kb/bashrc-vs-bash-profile#:~:text=bash_profile-,The%20.,in%20Bash%20interactive%20login%20shells.)

Asked Chatgpt the following:
`write a bash script that will alias tf to terraform to the .bash_profile`

Then an executable file was created in the bin folder and then updated in the `gitpod.yml` file

## Git and Github stash

When we forgot to create the **issue** and a **branch** to be working on, we worked mainly in the main and therefore followed the following procedure to create an issue and branch midway to push the code through it.
At the point you remember, 

- `git add .`
- `git stash save`
- Create the **issue** and **branch** from Github
- `git fetch`
- `git checkout <new branch>`
- `git pull`
- `git stash apply`