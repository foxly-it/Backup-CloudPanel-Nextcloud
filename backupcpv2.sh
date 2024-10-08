#!/usr/bin/env bash
#
START=$(date +%s)
OS_DISTRO="$(lsb_release -ds)"
OS_ARCH="$(uname -m)"
NUM_CORES=$(nproc || echo 1)
#
################################################################
# Title          : BBCPv2 - BorgBackup CloudPanel v2           #
# Description    : BorgBackup Nextcloud for Debian/Ubuntu      #
#                  You need to adjust the settings in the      #
#                  TODO section for yourself                   #
# Author         : Mark Schenk <info@foxly.de>                 #
# Date           : 2024-08-09 14:08                            #
# License        : MIT                                         #
# Version        : 2.0.1                                       #
#                                                              #
# Usage          : bash ./backupcpv2.sh                        #
################################################################
#######################
# TODO  /   Variables #
#######################

# Which PHP version do you use e.g. 8.2, 8.3
phpversion="8.3"

# Just adjust the domain here e.g. cloud.example.org or example.org
domain="cloud.example.tld"

# Here you can assign a password (Borg passphrase) for the Borg backup archive.
backupPassword="P@ssw0rd"

# Here you have to specify the path to the Borg repository.
backupRepo="/mnt/backup"
backupDatabase="/mnt/backup/database"

# You must edit this user to Site User from the Domain.
siteUser="User"

# Which folder should be backed up? (e.G. /home/SiteUser/htdocs/nextcloud)
dirBackup="/home/"


####################
# Helper functions #
####################
backup_VER="v2.0.1"

str_repeat() {
  printf -v v "%-*s" "$1" ""
  echo "${v// /$2}"
}

displaytime() {
  local T=$1
  local D=$((T / 60 / 60 / 24))
  local H=$((T / 60 / 60 % 24))
  local M=$((T / 60 % 60))
  local S=$((T % 60))

  ((D > 0)) && printf '%d days ' $D
  ((H > 0)) && printf '%d hours ' $H
  ((M > 0)) && printf '%d minutes ' $M
  ((D > 0 || H > 0 || M > 0)) && printf 'and '

  printf '%d seconds\n' $S
}

####################
# Colors           #
####################

FSI='\033['
FRED="${FSI}1;31m"
FGREEN="${FSI}1;32m"
FYELLOW="${FSI}1;33m"
FBLUE="${FSI}1;36m"
FEND="${FSI}0m"

######################
# Check requirements #
######################

# Check if user is root
[ "$(id -u)" != "0" ] && {
  echo "Error: You must be root or use sudo to run this script"
  exit 1
}

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

# Make sure, that we are on Debian or Ubuntu
if ! command_exists apt-get; then
  echo "This script cannot run on any other system than Debian or Ubuntu"
  exit 1
fi

# Checking if lsb_release is installed or install it
if ! command_exists lsb_release; then
  apt-get update && apt-get install -qq lsb-release > /dev/null 2>&1
fi

echo -ne "\ec"

WELCOME_TXT="Welcome to BBCPv2 - BorgBackup CloudPanel v2 ${backup_VER}"
WELCOME_FEN=${#WELCOME_TXT}

echo ""
echo " $(str_repeat "$WELCOME_FEN" "#")"
echo " $WELCOME_TXT"
echo " $(str_repeat "$WELCOME_FEN" "#")"
echo ""

echo ""
echo " Detected OS     : $OS_DISTRO"
echo " Detected Arch   : $OS_ARCH"
echo " Detected Cores  : $NUM_CORES"
echo ""


#######################
# No Changes needed   #
#######################

# The location who Nextcloud is stored.
ncLocation="/home/$siteUser/htdocs/"

# Nextcloud Maintenance
echo ""
sudo -u $siteUser php$phpversion $ncLocation$domain/occ maintenance:mode --on
echo ""

# DATABASES: Remove "#" for the correct database
# You have to enter a specific database. It is no longer possible to save all databases at the same time.

####################
# MySQL Backup     #
####################

echo -e "\e[93mStart MySQL database backup"

bash clpctl db:export --databaseName=DATABASENAME --file=$backupDatabase/backup_$(date +%d-%m-%Y).sql.gz


echo -e "${FGREEN}Backup has been finished successfully after $(displaytime $(($(date +%s) - START)))!${FEND}"

####################################################################################################################################################################


#######################
# Script              #
#######################

export BORG_REPO=$backupRepo
export BORG_PASSPHRASE=$backupPassword

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup unterbrochen >&2; exit 2' INT TERM

info "Start backup"


# Here the backup is created, adjust this as you would like to have it

borg create                         \
    --stats                         \
    --compression lz4               \
    ::'{hostname}-{now}'            \
    $dirBackup                      \


backup_exit=$?

# Nextcloud Maintenance
echo ""
sudo -u $siteUser php$phpversion $ncLocation$domain/occ maintenance:mode --off
echo ""
echo "Ende des Backups:"
echo "Storage space usage of the backups:"
echo ""
df -h ${backupRepo}

info "Loeschen von alten Backups"
# Automatically delete old backups
borg prune                          \
    --glob-archives '{hostname}-'   \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6

prune_exit=$?

# Information whether the backup worked.
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    echo -e "${FGREEN}Backup und/oder Prune erfolgreich beendet nach $(displaytime $(($(date +%s) - START)))!${FEND}"
elif [ ${global_exit} -eq 1 ]; then
    echo -e "${FYELLOW}Backup und/oder Prune beendet mit Warungen nach $(displaytime $(($(date +%s) - START)))!${FEND}"
else
    echo -e "${FRED}Backup und/oder Prune beendet mit Fehlern nach $(displaytime $(($(date +%s) - START)))!${FEND}"
fi
exit ${global_exit}