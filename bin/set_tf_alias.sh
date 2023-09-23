#!/bin/bash

# Define the alias
alias tf='terraform'

# Check if .bash_profile exists
if [ -f ~/.bash_profile ]; then
  # Append the alias to .bash_profile
  echo 'alias tf="terraform"' >> ~/.bash_profile
  # Source the updated .bash_profile to make the alias immediately available
  source ~/.bash_profile
  echo "Alias 'tf' for 'terraform' has been added to .bash_profile."
else
  echo "Error: .bash_profile does not exist in your home directory."
  exit 1
fi