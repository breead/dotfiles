## Nvim setup
To link nvim config folder in repo to appropriate nvim config folder, do this before creating ~/.config/nvim:

`ln -s ~/dotfiles/nvim ~/.config/nvim`

zsh alias with custom app name for running two versions:

`alias nvin="NVIM_APPNAME=nvim-linux nvim"`

## Other setups
[fzf](https://github.com/junegunn/fzf):
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
