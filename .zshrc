# tmux color support
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set nvim as my default visual editor
export VISUAL="$(which nvim)"

plugins=(
    git
    django
    pip
    cargo
    npm
    yarn
    docker
    docker-compose
    zsh-autosuggestions
    zsh-syntax-highlighting
    ssh-agent
    golang
)

source $ZSH/oh-my-zsh.sh
source /usr/share/powerlevel9k/powerlevel9k.zsh-theme

# powerlevel9k configuration
POWERLEVEL9K_MODE="awesome-patched"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv dir vcs)

# aliases
alias cat="bat --style=plain --paging=never"
alias vact="source venv/bin/activate"
alias ppt2pdf="libreoffice --headless --invisible --convert-to pdf"
alias vim="nvim"
alias vi="nvim"
alias chrome="google-chrome"

# functions
eexport() {
    export $(grep -v ^# $1 | xargs)
}

vnv() {
    if command -v virtualenv >/dev/null 2>&1; then
        virtualenv venv -p python
    else
        python -m venv venv
    fi
}

# nvm 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
