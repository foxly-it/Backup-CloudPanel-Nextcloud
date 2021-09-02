#!/bin/sh
#
# @author  Mark Schenk
# @copyright   2017-2021 Foxly.de
# @license GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
# This backup script is customized for CloudPanel. However, with small changes, you can configure it for any purpose. For more information visit: https://foxly.de
#
# ToDo:
#
# Which PHP version do you use e.g. 7.3 , 7.4 , 8.0
phpversion="7.4"
# Just adjust the domain here e.g. cloud.example.org or example.org
domain="cloud.example.org"
# You can back up all databases or specific databases. For all databases enter "all".
databases="db1,db2 or all"
# Here you can assign a password (Borg passphrase) for the Borg backup archive.
backupPassword="p@ssw0rd"
# Here you have to specify the path to the Borg repository.
backupRepo="/path/to/backup"



# No Changes needed
clpLocation="/home/cloudpanel/htdocs/"
# You must edit this user if you are not using the default installation of ClouPanel. 
# Otherwise, you can leave this value unchanged.
user="clp"
#

# Check for root
#
if [ "$(id -u)" != "0" ]
then
    errorecho "ERROR: This script has to be run as root!"
    exit 1
fi

# Nextcloud Maintenance
echo "\n###### Aktiviere Wartungsmodus: ${currentDateReadable} ######\n"
sudo -u $user php$phpversion $clpLocation$domain/occ maintenance:mode --on

echo  "\n###### Datenbank Backups ######\n"
clpctl db:backup --databases=$databases
echo  "\n###### Datenbank Backups erstellt! ######\n"



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
    /home/cloudpanel/backups                        \
    /home/cloudpanel/htdocs
 
backup_exit=$?

# Nextcloud Maintenance
echo  "\n###### Deaktiviere Wartungsmodus ######\n"
sudo -u $user php$phpversion $clpLocation$domain/occ maintenance:mode --off

echo "\n###### Ende des Backups: ${endDateReadable} (${durationReadable}) ######\n"
echo "Storage space usage of the backups:\n"
df -h ${backupRepo}

info "Loeschen von alten Backups"
# Automatically delete old backups
borg prune                          \
    --prefix '{hostname}-'          \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6
 
prune_exit=$?

# Information whether the backup worked.
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
 
if [ ${global_exit} -eq 0 ]; then
    info "Backup und/oder Prune erfolgreich beendet"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup und/oder Prune beendet mit Warungen"
else
    info "Backup und/oder Prune beendet mit Fehlern"
fi
 
exit ${global_exit}
