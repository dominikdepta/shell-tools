#!/bin/bash

while true; do
  read -p "Enter SSH public key path (Ctrl + C to cancel): " ssh_key_path

  expanded_path="${ssh_key_path/#~/$HOME}"

  if [ -f "$expanded_path" ]; then
    break
  else
    echo "File not found. Try again."
  fi
done

if [ ! -d ".git" ]; then
  echo "Not a Git repository."
  exit 1
fi

git config gpg.format ssh
git config user.signingkey "$expanded_path"
git config commit.gpgSign true

echo "Git signing configured with key: $expanded_path"
