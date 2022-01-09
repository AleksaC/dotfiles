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
    pip
    npm
    yarn
    docker
    docker-compose
    zsh-autosuggestions
    zsh-syntax-highlighting
    ssh-agent
    golang
    terraform
    kubectl
    rust
)

ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

command_not_found_handler() {
    if [ -x "venv/bin/$1" ]; then
        echo "You need to activate ./venv to run $1" 1>&2
        exe="venv/bin/$1"
        shift
        "$exe" "$@"
        return $?
    # Kinda sucks to use explicit path here, no other way around it tho, except
    # loading nvm which is too slow in case the command is actually incorrect
    elif [ -x "$NVM_DIR/versions/node/v12.18.2/bin/$1" ]; then
        echo "You need to load nvm to run $1" 1>&2
        exe="$NVM_DIR/versions/node/v12.18.2/bin/$1"
        shift
        "$exe" "$@"
        return $?
    else
        echo "$0: $1: command not found" 1>&2
        return 127
    fi
}

read -r -d '' inspect_hack <<- EOF
import code
import os
import sys

exec(open(os.environ.get("PYTHONSTARTUP")).read())

sys.stdin = open("/dev/tty")
print(); code.interact(local=locals())
EOF

python_shim() {
    if [[ $PYTHONSTARTUP ]]; then
        for arg in "$@"
        do
            case $arg in
                -i)
                    echo "$inspect_hack" | \python $@
                    return $?
                    ;;
            esac
        done
    fi
    \python $@
}

# aliases
alias tf="terraform"
alias ls="exa"
alias top="htop || top"
alias fe="nemo . &> /dev/null &!"
alias xcl="xclip -sel clip"
alias cat="bat --style=plain --paging=never"
alias python="python_shim"
alias vact="source venv/bin/activate"
alias wp="python -c 'import sys; print(sys.executable)'"
alias ppt2pdf="libreoffice --headless --invisible --convert-to pdf"
alias vim="nvim"
alias vi="nvim"
alias chrome="google-chrome"
alias gdc="git diff --cached"
alias docker-compose="docker compose"
alias EXIT="exit"

# functions
eexport() {
    export $(grep -v ^# $1 | xargs)
}

vnv() {
    if command -v virtualenv &> /dev/null; then
        virtualenv venv -p python
    else
        python -m venv venv
    fi
}

ws() {
    webstorm $1 &> /dev/null &!
}

pc() {
    pycharm $1 &> /dev/null &!
}

cl() {
    clion $1 &> /dev/null &!
}

gld() {
    goland $1 &> /dev/null &!
}

# nvm
export NVM_DIR="$HOME/.nvm"
lazynvm() {
    unset -f nvm node npm npx yarn
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

yarn() {
    lazynvm
    yarn $@
}

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi

# pythonrc
export PYTHONSTARTUP=~/.pythonrc.py

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ttouch completions
[[ ! -f ~/.ttouch/shell_completions.sh ]] || source ~/.ttouch/shell_completions.sh

[[ -d "$HOME/.local/bin" ]] && [[ -z $(grep "$HOME/.local/bin" <<< $PATH) ]] && export PATH="$PATH:$HOME/.local/bin"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
