#!/bin/sh

BASE_DIR=`dirname $(readlink -f $0)`

check_file_difference() {
  if [ "$#" != "2" ]; then
    echo "Need 2 arguments, but $# are given"
    exit 1
  fi
  diff -rq $1 $2 > /dev/null 2>&1
  return
}

backup_file() {
  for file in $@
  do
    backup_filename="${file}.bk.`date +"%y.%m.%d"`"
    echo "Backup file ${file} to ${backup_filename}"
    mv ${file} ${backup_filename}
  done
}

link_file() {
  if [ "$#" != "2" ]; then
    echo "Need 2 arguments, but $# are given"
    exit 1
  fi
  TARGET=$1
  DESTINATION=$2
  ln -s $1 $2
}

unlink_file() {
  for file in $@
  do
    echo "Unlink the file ${file}"
    unlink ${file}
  done
}

install_dotfiles() {
  if [ "$#" != "2" -a "$#" != "3" -a "$#" != "4" ]; then
    echo "Wrong number of arguments"
    exit 1
  fi

  if [ -z "$3" ]; then
    DESTINATION_DIR=${HOME}
  else
    DESTINATION_DIR=$3
    [ ! -d ${DESTINATION_DIR} ] && mkdir -p ${DESTINATION_DIR}
  fi
  PREFIX=$1
  SOURCE_FILES=$2
  NO_PREPENDED_DOT=$4

  for file in $SOURCE_FILES
  do
    if [ -n "${NO_PREPENDED_DOT}" ]; then
      DESTINATION_FILE_PATH="${DESTINATION_DIR}/${file}"
    else
      DESTINATION_FILE_PATH="${DESTINATION_DIR}/.${file}"
    fi

    SOURCE_FILE_PATH="${BASE_DIR}/${PREFIX}/${file}"
    if [ -e ${DESTINATION_FILE_PATH} ]; then
      check_file_difference "${DESTINATION_FILE_PATH}" "${SOURCE_FILE_PATH}"
      RETURN_VALUE=$?
      if [ "$RETURN_VALUE" != "0" ]; then
        backup_file "${DESTINATION_FILE_PATH}"
        link_file "${SOURCE_FILE_PATH}" "${DESTINATION_FILE_PATH}"
      fi
    else
      link_file "${SOURCE_FILE_PATH}" "${DESTINATION_FILE_PATH}"
    fi
  done
  echo "Complete installing ${PREFIX} dotfiles"
}

install_vim_dotfiles() {
  install_dotfiles "vim" "vimrc"
  install_dotfiles "nvim" "init.vim" "${HOME}/.config/nvim" "Y"
}

install_screen_dotfiles() {
  install_dotfiles "screen" "screenrc"
}

install_tmux_dotfiles() {
  install_dotfiles "tmux" "tmux.conf"
}

main() {
  echo "This script will install the configuration files for the following softwares:"
  echo "1. vim, also neovim"
  echo "2. screen"
  echo "3. tmux"

  read -p "Do you want to install ? [Y/n] " install_decision

  case $install_decision in
    [Yy])
      echo "Start installing"
      ;;
    *)
      echo "Quit the installation script"
      ;;
  esac

  install_vim_dotfiles
  install_screen_dotfiles
  install_tmux_dotfiles
}

main
