#!/bin/bash

# Define the alias
alias_name='tf'
alias_command='terraform'

# Check if .bash_profile exists
if [ -f ~/.bash_profile ]; then
  # Check if the alias already exists in .bash_profile
  if grep -q "alias $alias_name=" ~/.bash_profile; then
    echo "Alias '$alias_name' for '$alias_command' already exists in .bash_profile."
  else
    # Append the alias to .bash_profile
    echo "alias $alias_name='$alias_command'" >> ~/.bash_profile
    # Source the updated .bash_profile to make the alias immediately available
    source ~/.bash_profile
    echo "Alias '$alias_name' for '$alias_command' has been added to .bash_profile."
  fi
else
  echo "Error: .bash_profile does not exist in your home directory."
  exit 1
fi