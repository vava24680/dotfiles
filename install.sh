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

    # If destination already exists and it is a symbolic link, unlink it first.
    # This check is needed when destination is symbolic link to a directory that
    # is actually the target. Without this check, ln will create another symbolic
    # link in the target directory, which is not what we want.
    [ -h $DESTINATION ] && unlink $DESTINATION

    ln -f -s $1 $2
}

unlink_file() {
    for file in $@
    do
        echo "Unlink the file ${file}"
        unlink ${file}
    done
}

install_dotfiles() {
    # Arguments explanations
    # $1: Configuration files directory name.
    # $2: Configuration file name.
    #     If an empty string is given, all files and directory in that directory
    #     will be installed.
    # $3: The flag to denote if need to add dot before the installed
    #     configuration files. (Optional, default is "Y".)
    # $4: Installation directory name (Optional, default is $HOME).

    if [ $# != 1 -a $# != 2 -a $# != 3 -a $# != 4 ]; then
        echo "Wrong number of arguments, $# received"
        exit 1
    fi

    SOURCE_DIRECTORY="${BASE_DIR}/$1"

    if [ ! -z "$2" ]; then
        SOURCE_FILES=$2
    else
        SOURCE_FILES=""

        # As BSD find does not support -printf option, use shell's built-in
        # parameter expansion to extract the basename part (the part after
        # the last /) from each search result.
        for file in $(find ${SOURCE_DIRECTORY} -mindepth 1 -maxdepth 1)
        do
            if [ -z "${SOURCE_FILES}" ]; then
                SOURCE_FILES="${file##/*/}"
            else
                SOURCE_FILES="${SOURCE_FILES} ${file##/*/}"
            fi
        done
    fi

    if [ "$3" != "Y" -a "$3" != "N" -a "$3" != "" ]; then
        echo "Prepend dot flag only accepts \"Y\", \"N\" or empty string," \
             "\"$3\" received"
        exit 1
    elif [ -z "$3" ]; then
        PREPENDED_DOT="Y"
    else
        PREPENDED_DOT=$3
    fi

    if [ -z "$4" ]; then
        DESTINATION_DIR=${HOME}
    else
        DESTINATION_DIR=$4

        [ ! -d ${DESTINATION_DIR} ] && mkdir -p ${DESTINATION_DIR}
    fi

    for file in ${SOURCE_FILES}
    do
        if [ "${PREPENDED_DOT}" = "Y" ]; then
            DESTINATION_FILE_PATH="${DESTINATION_DIR}/.${file}"
        else
            DESTINATION_FILE_PATH="${DESTINATION_DIR}/${file}"
        fi

        SOURCE_FILE_PATH="${SOURCE_DIRECTORY}/${file}"

        if [ -e $DESTINATION_FILE_PATH ]; then
            BACKUP_FILE_FLAG=1

            if [ -d $DESTINATION_FILE_PATH ]; then
                # If destination file is a diectory, use realpath to check
                # if the source directory and the destination directory.
                # If they are the same, do not proceed backup procedure.
                if [ $(realpath $DESTINATION_FILE_PATH) = $(realpath $SOURCE_FILE_PATH) ]; then
                    BACKUP_FILE_FLAG=0
                fi
            elif [ -f $DESTINATION_FILE_PATH ]; then
                check_file_difference "${DESTINATION_FILE_PATH}" "${SOURCE_FILE_PATH}"

                RETURN_VALUE=$?

                [ $RETURN_VALUE -eq 0 ] && BACKUP_FILE_FLAG=0
            fi

            if [ $BACKUP_FILE_FLAG -eq 1 ]; then
                backup_file "${DESTINATION_FILE_PATH}"
            fi
        fi

        link_file "${SOURCE_FILE_PATH}" "${DESTINATION_FILE_PATH}"
    done
}

install_vim_dotfiles() {
    install_dotfiles "vim"
    install_dotfiles "nvim" "" "N" "${HOME}/.config/nvim"
}

install_screen_dotfiles() {
    install_dotfiles "screen"
}

install_tmux_dotfiles() {
    install_dotfiles "tmux"
}

main() {
    echo "This script will install the configuration files for the following softwares:"
    echo "1. Vim, also Neovim"
    echo "2. tmux"
    echo "2. GNU Screen"

    read -p "Do you want to install ? [Y/n] " install_decision

    case $install_decision in
        [Yy])
            echo "Start installing"
            install_vim_dotfiles
            install_screen_dotfiles
            install_tmux_dotfiles
            echo "Complete installation"
            ;;
        *)
            echo "Quit the installation script"
            ;;
    esac
}

main
