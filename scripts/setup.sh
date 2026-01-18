#!/bin/bash

# 1. Bob & Nvim installation script:\

echo "Installing Bob. What's Bob? It's currently the best package amnager for NVIM."

curl -LO https://github.com/MordechaiHadad/bob/releases/download/v2.9.0/bob-linux-x86_64.zip
unzip bob-linux-x86_64.zip
sudo mv bob /usr/local/bin/
rm bob-linux-x86_64.zip
bob install v0.11.5
bob use v0.11.5

# 2. Pnpm installation

echo "Installing pnpm ... What's Pnpm? It's currently the most secure and fastest package manager"
curl -fsSL https://get.pnpm.io/install.sh | sh -

# 3. Creating symb links:
#  WezTerm
ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
# Neovim
mkdir -p ~/.config/nvim
cp -r ~/dotfiles/nvim/* ~/.config/nvim/
