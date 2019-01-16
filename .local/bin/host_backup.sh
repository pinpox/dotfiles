#!/bin/bash

SERVER=pablo-tools.duckdns.org
export BORG_PASSCOMMAND="sudo -u binaryplease pass show borg/$(hostname)"

print_colored() {
	COLOR_RED='\33[0;31m'
	COLOR_GREEN='\33[0;32m'
	COLOR_YELLOW='\33[1;33m'
	NC='\033[0m'
	printf "$2$1${NC}\n"
}

# Check for root
if [ "$EUID" -ne 0 ]
then print_colored "Please run as root" $COLOR_RED
	exit
fi

if [[ $SERVER = $(hostname) ]]; then
	REPOSITORY=/mnt/backup/borgbackup/$(hostname)
else
	REPOSITORY=binaryplease@$SERVER:/mnt/backup/borgbackup/$(hostname)
fi

print_colored "Using repository $REPOSITORY\n" $COLOR_GREEN

# Check if backup server is reachable
print_colored "Checking if backup server is reachable..." $COLOR_GREEN
if ping -c1 -W1 $SERVER; then
	print_colored "Backup server $SERVER is reachable, continuing" $COLOR_GREEN
else
	print_colored "Backup server $SERVER is down, exiting." $COLOR_RED
	exit
fi

# Backup list of installes packages
print_colored "Creating package list..." $COLOR_GREEN
pacman -Qe > /home/binaryplease/installed_packages_list.txt

print_colored "Creating backup..." $COLOR_GREEN
borg create -v --progress --stats \
	--compression lz4 \
	"$REPOSITORY::{hostname}-{now:%Y-%m-%d}" \
		/etc \
		/home \
		/root \
			--exclude "/home/*/.config/chromium" \
		--exclude "/home/*/.local/share/Trash" \
		--exclude "/home/*/.cache" \
		--exclude "/home/*/VirtualBox VMs" \
		--exclude "*.pyc" \
	
	print_colored "Deleting old backups..." $COLOR_GREEN
	borg prune -v "$REPOSITORY" --prefix '{hostname}-' --keep-daily=3 --keep-weekly=2 --keep-monthly=6

print_colored "Deleting old backups..." $COLOR_GREEN
borg prune -v "$REPOSITORY" --prefix '{hostname}-' --keep-daily=3 --keep-weekly=2 --keep-monthly=6

print_colored "Deleting package list..." $COLOR_GREEN
rm -rf /home/binaryplease/installed_packages_list.txt

