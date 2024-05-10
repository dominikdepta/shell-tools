#!/bin/bash

# Timezone
export TZ=Europe/Warsaw
sudo timedatectl set-timezone $TZ

# APT packages
sudo apt update -y
sudo apt install -y build-essential python3 git procps curl file fzf zsh

# Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# brew packages
brew install nvm pipx autojump zsh-syntax-highlighting

export PATH="$PATH:/root/.local/bin"
export NVM_DIR="$HOME/.nvm"
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm

# pipx
pipx ensurepath
sudo pipx ensurepath --global

# Node LTS
nvm install --lts

# Directories
mkdir $HOME/projects

# Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# .zshrc
curl -fsSL https://raw.githubusercontent.com/dominikdepta/shell-tools/main/.zshrc > $HOME/.zshrc

# run zsh
zsh
