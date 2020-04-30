#!/usr/bin/env bash

# dependenies
sudo apt update -y
sudo apt install git curl -y
sudo apt install build-essential libclang-dev -y
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y
sudo apt install libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev zlib1g-dev -y

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# cargo-deb 
cargo install cargo-deb

# alacritty
git clone https://github.com/alacritty/alacritty
cd alacritty
cargo deb --install -p alacritty
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
cd ..

# bat
git clone https://github.com/sharkdp/bat
cargo install bat

# zsh
sudo apt install zsh -y
sudo usermod -s /usr/bin/zsh $(whoami)

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# powerlevel9k
sudo apt install powerline fonts-powerline
sudo apt-get install zsh-theme-powerlevel9k

# nvim
sudo apt install neovim -y

# copy the dotfiles to their respective locations
cp .zshrc ~/.zshrc
cp .profile ~/.profile
cp .alacritty.yml ~/.alacritty.yml
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

source ~/.zshrc
pyenv install 3.8.2
pyenv global 3.8.2

# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# nodejs
nvm install 12

