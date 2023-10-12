# Terraform Beginner Bootcamp 2023 Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for Ruby. It is the primary way to install ruby packages (known asgems) for Ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file

```r
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

then you need to run the bundle install command. this will run on the system globally (unlike nodejs which will install packages in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions being used in the project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro webframework for ruby to build web apps. It is great for mock or development servers or for very simple projects.

You can create a web-server in a single file

https://sinatrarb.com/

## Terratowns Mock Web Server

We can run the web server by executing the following command

```r
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD operations

Terraform provider resource utilize CRUD. 

CRUD stands for Create, Read, Update and Delete

[CRUD Wikipedia](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete#:~:text=In%20computer%20programming%2C%20create%2C%20read,computer%2Dbased%20forms%20and%20reports.)