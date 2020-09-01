# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

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

ws() {
    webstorm $1 > /dev/null 2>&1 &!
}

pc() {
    pycharm $1 > /dev/null 2>&1 &!
}

# nvm
export NVM_DIR="$HOME/.nvm"
lazynvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm() {
    lazynvm
    nvm $@
}

node() {
    lazynvm
    node $@
}

npm() {
    lazynvm
    npm $@
}

npx() {
    lazynvm
    npx $@
}

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pythonrc
export PYTHONSTARTUP=~/.pythonrc.py

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
