# Haohao's dotfiles

This repository stores my dotfiles for unix-like systems. It currently has the
following configurations.

* Vim
* Neovim
* GNU screen
* tmux

## Notice

* **The installation script won't install any software like vim, Neovim, etc. Please install by yourself.**

## Requirements

* `realpath` command.
  * If using macOS, you can use brew to install `coreutils` to have this command.
* Git.

## Installation

1. Clone this repository to your home directory.
2. Go in to this repository and run `./install.sh` and follow the script instructions.

## Post-Installation Procedures

* If you use GNU screen, please uncomment one of the following two line starting with `source` keyword in `$HOME/.screenrc` based on your GNU screen version.

  ```=
  # Uncomment the following line if your screen version is less than 5.0.0.
  source $HOME/.screenrc_4_9_9

  # Uncomment the following line if your screen version is equal to or greater than 5.0.0.
  # source $HOME/.screenrc_5_0_0
  ```

  * You can use `screen -v` to check you GNU screen version.

## Installation Details

### Vim

* A symbolic link `$HOME/.vimrc` will be created and link to the `vim/vimrc` in this repository.

### Neovim

* All neovim configuration files and directories will be created as symbolic links in `$HOME/.config/nvim/` directory and links to the files and directories in `nvim` directory.

### GNU Screen

* Three symbolic links will be created in the home directory (`$HOME`).
  * `$HOME/.screenrc` links to `screen/screenrc` in this repository.
  * `$HOME/.screenrc_4_9_9` links to `screen/screenrc_4_9_9` in this repository.
  * `$HOME/.screenrc_5_0_0` links to `screen/screenrc_5_0_0` in this repository.

### TMUX

* A symbolic link `$HOME/.tmux.conf` will be created and links to the `tmux/tmux.conf` in this repository.
