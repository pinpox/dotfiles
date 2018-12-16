#!/bin/bash

GIT_REPO=""
CONF_DIR_NAME=".dotfiles"
CURRENT_TIME=`date +"%Y-%m-%dT%H-%M-%S"`
BACKUP_DIR="~/config-backup-$CURRENT_TIME"
BASE16_THEME="snazzy"

if [[ $(ssh -T git@github.com) == *"success"* ]]; then
	echo "Using SSH-authentication to connect to github"
	GIT_REPO="git@github.com:binaryplease/dotfiles.git"
else
	echo "Using HTTPS-authentication to connect to github"
	GIT_REPO="https://github.com/binaryplease/dotfiles/"
fi

function backup_conf() {
	while read fn
	do
		con="$(dirname $fn)"
		con="$BACKUP_DIR/$con"
		mkdir -p $con
		mv $fn $(realpath $con)
	done
}

function setup_dotfiles() {
	echo "Setting up dotfiles..."
	cd ~
	git clone --bare $GIT_REPO $HOME/$CONF_DIR_NAME
	function config {
		/usr/bin/git --git-dir=$HOME/$CONF_DIR_NAME/ --work-tree=$HOME $@
	}
	echo "$CONF_DIR_NAME" >> .gitignore
	mkdir -p $BACKUP_DIR
	echo "Backing up pre-existing dot files.";
	config checkout 2>&1 | awk '/^[[:space:]]/{print $1}' | backup_conf
	config checkout
	config config status.showUntrackedFiles no
}

function setup_vim() {

	echo "Setting up vim/neovim..."
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

function check_dependencies() {
	echo "Checking dependencies..."
	declare -a arr=("git" "base16-manager" "nvim")

	for i in "${arr[@]}"
	do
		if ! [ -x "$(command -v $i)" ]; then
			echo "Error: $i is not installed." >&2
			exit 1
		fi
	done
}

function setup_colors() {
	echo "Setting up colors with base16-manager..."
	mkdir -p .config/rofi
	mkdir -p .Xresources.d

	base16-manager install nicodebo/base16-fzf
	base16-manager install 0xdec/base16-rofi
	base16-manager install chriskempson/base16-vim
	base16-manager install chriskempson/base16-xresources
	base16-manager install khamer/base16-termite
	base16-manager install khamer/base16-dunst
	base16-manager set $BASE16_THEME
}

# Function to confirm execution. Call confirmExecute <message> <command>
function confirmExecute() {
	read -p "$1" -n 1 -r
	echo

	if [[ $REPLY =~ ^(y|Y| ) ]] || [[ -z $REPLY ]];
	then
		eval $2
	fi
}

confirmExecute "Check for missing dependencies? [Y/n]" check_dependencies
confirmExecute "Setup dotfiles? [Y/n]"  setup_dotfiles
confirmExecute "Setup VIM/Neovim? [Y/n]" setup_vim
confirmExecute "Set ZSH as shell? [Y/n]" "chsh -s /bin/zsh"
confirmExecute "Install termite terminfo? [Y/n]" "tic -x termite-terminfo"
confirmExecute "Setup colors with base16-manager (base16-$BASE16_THEME)? [Y/n]" setup_colors

