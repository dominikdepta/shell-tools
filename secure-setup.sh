#!/bin/bash

# Vars
secure_ssh_config="/etc/ssh/sshd_config.d/60-secure-login.conf"

# Functions
add_new_user() {
  root_shell_path=$(getent passwd root | cut -d: -f7)

  while true; do
      read -p "Enter the new username: " new_user_name
      if [ -z "$new_user_name" ]; then
          echo "Username cannot be empty. Please enter a valid username."
      elif id "$new_user_name" &>/dev/null; then
          echo "User '$new_user_name' already exists. Please choose a different username."
      else
          break
      fi
  done

  read -p "Enter the comment (Full Name): " new_user_comment

  useradd -m -c "$new_user_comment" -s "$root_shell_path" "$new_user_name"

  if id "$new_user_name" &>/dev/null; then
      echo "User '$new_user_name' created successfully."
      echo "Changing password for the new user..."
      passwd "$new_user_name"

      # Add an SSH key for the new user
      read -p "Do you want to add an SSH key for the new user? (Y/n): " confirm_ssh_key

      if [[ -z "$confirm_ssh_key" || "$confirm_ssh_key" =~ ^[Yy]$ ]]; then
          mkdir -p /home/"$new_user_name"/.ssh
          chmod 700 /home/"$new_user_name"/.ssh
          read -p "Enter the SSH key to add: " ssh_key
          echo "$ssh_key" >> /home/"$new_user_name"/.ssh/authorized_keys
          chmod 600 /home/"$new_user_name"/.ssh/authorized_keys
          chown -R "$new_user_name":"$new_user_name" /home/"$new_user_name"/.ssh
          echo "SSH key added for user '$new_user_name'."
      else
          echo "Skipping SSH key addition."
      fi
  else
      echo "Failed to create user '$new_user_name'. Exiting."
      exit 1
  fi
}

add_secure_ssh() {
  bash -c "cat > $secure_ssh_config" << EOF
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
EOF

  echo "Created secure SSH configuration at $secure_ssh_config"

  echo "Restarting SSH service..."
  systemctl restart ssh
}

# Change current password
read -p "Do you want to change the current user's password? (Y/n): " confirm_password_change

if [[ -z "$confirm_password_change" || "$confirm_password_change" =~ ^[Yy]$ ]]; then
    echo "Changing password for the current user..."
    passwd
else
    echo "Skipping password change for the current user."
fi

# Create a new user
read -p "Do you want to create a new user? (Y/n): " confirm_creating_user

if [[ -z "$confirm_creating_user" || "$confirm_creating_user" =~ ^[Yy]$ ]]; then
    echo "Creating the new user..."
    add_new_user
else
    echo "Skipping password change for the current user."
fi

# Add secure ssh configuration file
read -p "Do you want to create $secure_ssh_config? (Y/n): " confirm_secure_login

if [[ -z "$confirm_secure_login" || "$confirm_secure_login" =~ ^[Yy]$ ]]; then
  echo "Creating $secure_ssh_config..."
  add_secure_ssh
else
    echo "Skipping creating $secure_ssh_config."
fi

# Finish
echo "Script execution completed."
