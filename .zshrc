# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fino"

plugins=(
    git
    autojump
    npm
    nvm
    zsh-interactive-cd
)

# plugins
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# pipx
export PATH="$PATH:/home/ubuntu/.local/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source $ZSH/oh-my-zsh.sh

# aliases

alias docker_start="sudo systemctl start docker.service docker.socket"
alias docker_stop="sudo systemctl stop docker.service docker.socket"
alias k=kubectl

