#!/bin/bash

GIT_REPO=""
CONF_DIR_NAME=".dotfiles"
CURRENT_TIME=$(date +"%Y-%m-%dT%H-%M-%S")
BACKUP_DIR="config-backup-$CURRENT_TIME"
BASE16_THEME="snazzy"

if [[ $(ssh -T git@github.com) == *"success"* ]]; then
	echo "Using SSH-authentication to connect to github"
	GIT_REPO="git@github.com:binaryplease/dotfiles.git"
else
	echo "Using HTTPS-authentication to connect to github"
	GIT_REPO="https://github.com/binaryplease/dotfiles/"
fi

function backup_conf() {
	while read -r fn
	do
		con="$(dirname "$fn")"
		con="$BACKUP_DIR/$con"
		mkdir -p "$con"
		mv "$fn" "$(realpath "$con")"
	done
}

function setup_dotfiles() {
	mv $CONF_DIR_NAME "dotfiles-repo-backup-$CURRENT_TIME"
	echo "Setting up dotfiles..."
	cd ~
	git clone --bare $GIT_REPO "$HOME/$CONF_DIR_NAME"
	function config {
		/usr/bin/git --git-dir="$HOME/$CONF_DIR_NAME/" --work-tree="$HOME" "$@"
	}
	if grep -Fxq ".gitignore" $CONF_DIR_NAME
	then
		echo "$CONF_DIR_NAME already in .gitignore"
	else
		echo "$CONF_DIR_NAME" >> .gitignore
	fi
	mkdir -p "$BACKUP_DIR"
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
		if ! [ -x "$(command -v "$i")" ]; then
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

last_version_antibody() {
	curl -s https://raw.githubusercontent.com/getantibody/homebrew-tap/master/Formula/antibody.rb |
		grep url |
		cut -f8 -d'/'
}



function install_antibody() {

	set -e
	DOWNLOAD_URL="https://github.com/getantibody/antibody/releases/download"
	test -z "$TMPDIR" && TMPDIR="$(mktemp -d)"

	version="$(last_version_antibody)" || true
	test -z "$version" && {
		echo "Unable to get antibody version."
	exit 1
}

	echo "Downloading antibody $version for $(uname -s)_$(uname -m)..."
	rm -f "$TMPDIR/antibody.tar.gz"
	curl -s -L -o "$TMPDIR/antibody.tar.gz" \
		"$DOWNLOAD_URL/$version/antibody_$(uname -s)_$(uname -m).tar.gz" || true

	tar -xf "$TMPDIR/antibody.tar.gz" -C "$TMPDIR"

	mv -f "$TMPDIR"/antibody ~/.local/bin/antibody
	command -v antibody

	echo "Installing ZSH plugins..."
    antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh

}

# Function to confirm execution. Call confirmExecute <message> <command>
function confirmExecute() {
	read -p "$1" -n 1 -r
	echo

	if [[ $REPLY =~ ^(y|Y| ) ]] || [[ -z $REPLY ]];
	then
		eval "$2"
	fi
}

confirmExecute "Check for missing dependencies? [Y/n]" "check_dependencies"
confirmExecute "Setup dotfiles? [Y/n]"  "setup_dotfiles"
confirmExecute "Setup VIM/Neovim? [Y/n]" "setup_vim"
confirmExecute "Set ZSH as shell? [Y/n]" "chsh -s /bin/zsh"
confirmExecute "Install antibody? [Y/n]" "install_antibody"
confirmExecute "Install termite terminfo? [Y/n]" "tic -x termite.terminfo"
confirmExecute "Setup colors with base16-manager (base16-$BASE16_THEME)? [Y/n]" "setup_colors"

