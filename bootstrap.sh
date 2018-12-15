#!/bin/bash
GIT_REPO="https://gitlab.com/binaryplease/dotfiles/"
CONF_DIR_NAME=".dotfiles"

function backup_conf() {
	while read fn
	do
		con="$(dirname $fn)"
		con=".config-backup/$con"
		mkdir -p $con
		mv $fn $(realpath $con)
	done
}

function setup_dotfiles() {
	cd ~
	git clone --bare $GIT_REPO $HOME/$CONF_DIR_NAME
	function config {
		/usr/bin/git --git-dir=$HOME/$CONF_DIR_NAME/ --work-tree=$HOME $@
	}
	echo "$CONF_DIR_NAME" >> .gitignore
	mkdir -p .config-backup
	echo "Backing up pre-existing dot files.";
	config checkout 2>&1 | awk '/^[[:space:]]/{print $1}' | backup_conf
	config checkout
	config config status.showUntrackedFiles no
}

function set_zsh() {
	read -p "Change shell to zsh? [Y/n]" -n 1 -r
	echo
	if [[ $REPLY =~ ^(y|Y| ) ]] || [[ -z $REPLY ]];
	then
		chsh -s /bin/zsh
	fi
}

function setup_vim() {
	if type "nvim" > /dev/null
	then
		nvim -c 'PlugClean|PlugInstall|qa'
	elif type "vim" > /dev/null
	then
		vim -c 'PlugClean|PlugInstall|qa'
	else
		echo "Vim/Neovim doesn't seem to be installed"
	fi
}

setup_dotfiles
tic -x termite.terminfo
#setup_vim
# set_zsh


