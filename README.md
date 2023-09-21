# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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
 
 #### Linux permission & Execution Considerations
 
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

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we start an existing workspace

 [Gitpod Workspaces[entire tab]](https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle)

### Working with Environment Variables

We can list out all the environment variables(env vars) using the `env` command

We can filter specific env vars with the `grep` command. eg `env | grep ROOT`

#### Setting and Unsetting Env Vars

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

#### Printing Env Vars

We can print an env var using echo. Example `echo $HELLO`

#### Scoping of Env Vars

When you open new bash terminals in VSCode it will not be aware of other env vars you have already set in other windows.

If you want Env Vars to persist accross all future terminals that are open, you need to set env vars in your bash profile

### Persisting Env Vars in Gitpod

We can persist Env Vars into gitpod by storing them in Gitpod secrets Storage.

```sh
gp env HELLO='Ghana'
```

All future workspaces launched will set the env Vars for all bash terminals open in those workspaces

You can also set env vars in the `gitpod.yml` but this can only contain non-sensitive env vars.