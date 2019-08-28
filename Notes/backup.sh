#!/bin/sh
################################
# Sauvegarde de la BDD Infinivo
#
# Ce script doit tourner sur le serveur de backup.
# On recupère une copie de la BDD de prod via le reseau.
# Necessite mysqldump (du paquet mysql) et rsync.
# 
################################

# Variables, pas de / final dans les chemins
bdd_name=testinfinivo
bdd_ip=
bdd_port=
bdd_user=
bdd_password=

dir_log=/var/log/backup
dir_temp=/tmp/backup
dir_backup=/backups

timestamp_day=$(date '+%Y%m%d')
timestamp=$(date '+%Y%m%d-%H%M%S')

# Fonctions
maFonction ()
{
  bloc d’instructions 
}


### Verification de l environnement

# Journalisation
if [[ -f $dir_log/backup-critical.log ]];
then
  true
else
  touch /$dir_log/backup-critical.log
  echo "[$timestamp] Creation of the critical errors log file" >> $dir_log/backup-$timestamp_day.log
fi

if [[ -f $dir_log/backup-$timestamp_day.log ]];
then
  echo "[$timestamp] * Le script a ete execute de nouveau" >> $dir_log/backup-$timestamp_day.log
else
  touch /$dir_log/backup-$timestamp_day.log
  echo "[$timestamp] Debut du fichier log pour ce jour" >> $dir_log/backup-$timestamp_day.log
fi

# Volumes et points de montage
if [ -d $dir_temp ] 
then
    true
else
  echo "[$timestamp] *** Le dossier temporaire est injoignable" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** Could not reach temporary files directory" >> $dir_log/backup-critical.log
  exit 1
fi

if [ -d $dir_backup ] 
then
    true
else
  echo "[$timestamp] Le chemin $dir_backup est injoignable" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** Could not reach backup directory" >> $dir_log/backup-critical.log
  exit 1
fi





### Recuperation de la base
mysqldump --host $bdd_ip -P $bdd_port -u $bdd_user -p $bdd_password --single-transaction --quick --lock-tables=false $bdd_name > $dir_temp/infinivo-$timestamp.sql

if [[ $? -eq 0 ]];
then
  echo "[$timestamp] Base MySQL OK" >> $dir_log/backup-$timestamp_day.log
else
  echo "[$timestamp] *** ERREUR DUMP MYSQL ***" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** PAS DE TRAITEMENT ***" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** COULD NOT DUMP MYSQL BASE ***" >> $dir_log/backup-critical.log
  echo "[$timestamp] *** EXIT ***" >> $dir_log/backup-critical.log
  exit 1
fi

# Traitement du fichier
