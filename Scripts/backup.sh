#!/bin/sh
#==============================================================================
# Script  :   Ce script doit tourner sur le serveur de backup.
#             On recupère une copie de la BDD de prod via le reseau.
# Pre requis: Necessite mysqldump et gzip.
# Appel   : backup.sh
# Version : V1.0.0
#------------------------------------------------------------------------------
# V0.0 GB 08/2019  -- Version initiale
#==============================================================================


# Variables, pas de / final dans les chemins
bdd_name=test_infinivo
bdd_ip=
bdd_port=
bdd_user=amelie
bdd_password=password

facture_ip=
facture_user=
facture_password=

dir_backup=/backups
dir_factures=/factures
dir_factures_distant=/factures

dir_temp=/tmp/backup
dir_log=/var/log/backup

#### DEBUT SCRIPT ####

# Formats de date ISO
timestamp_day=$(date '+%Y%m%d')
timestamp=$(date '+%Y%m%d-%H%M%S')

# Fonctions
VerifTailleDispo ()
{
  df $1 | awk '{ print $5 }' | tail -n 1| cut -d'%' -f1
}

VerifDossier ()
{
  if [ -d $1 ] 
  then
      true
  else
    echo "[$timestamp] *** Le dossier $1 est injoignable" >> $dir_log/backup-$timestamp_day.log
    echo "[$timestamp] *** Could not reach directory $1" >> $dir_log/backup-critical.log
    exit 1
  fi
}



########## Verification de l environnement #########

# Journalisation
if [[ -f $dir_log/backup-critical.log ]]
then
  true
else
  touch /$dir_log/backup-critical.log
  echo "[$timestamp] Creation of the critical errors log file" >> $dir_log/backup-critical.log
fi

if [[ -f $dir_log/backup-$timestamp_day.log ]]
then
  echo "[$timestamp] * Le script a ete execute de nouveau" >> $dir_log/backup-$timestamp_day.log
else
  touch /$dir_log/backup-$timestamp_day.log
  echo "[$timestamp] Debut du fichier log pour ce jour" >> $dir_log/backup-$timestamp_day.log
fi

# Volumes et points de montage
VerifDossier $dir_temp
VerifDossier $dir_backup
VerifDossier $dir_factures

VerifTailleDispo $dir_temp
VerifTailleDispo $dir_backup
VerifTailleDispo $dir_factures


########## TRAITEMENT BASE ################

### Recuperation de la base
mysqldump --host $bdd_ip -P $bdd_port -u $bdd_user -p $bdd_password --single-transaction --quick --lock-tables=false $bdd_name > $dir_temp/infinivo-$timestamp.sql

if [[ $? -eq 0 ]]
then
  echo "[$timestamp] Base MySQL OK" >> $dir_log/backup-$timestamp_day.log
else
  echo "[$timestamp] *** ERREUR DUMP MYSQL ***" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** PAS DE TRAITEMENT ***" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** COULD NOT DUMP MYSQL BASE ***" >> $dir_log/backup-critical.log
  echo "[$timestamp] *** EXIT ***" >> $dir_log/backup-critical.log
  exit 1
fi

# Traitement du dump BDD
gzip -q $dir_temp/infinivo-$timestamp.sql
mv $dir_temp/infinivo-$timestamp.sql.gz $dir_backup

if [ $? -eq 0 ]
then
  rm $dir_temp/infinivo-$timestamp.sql.gz
else
  echo "[$timestamp] *** ERREUR CRITIQUE FS BACKUP ***" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** CRITICAL BACKUP FILESYSTEM ERROR ***" >> $dir_log/backup-critical.log
  exit 1
fi

echo "[$timestamp] *** Traitement OK ***" >> $dir_log/backup-$timestamp_day.log


########## TRAITEMENT FACTURES ################

mkdir $dir_facture/$timestamp_day
scp $facture_user@$facture_user:$dir_factures_distant $dir_factures/timestamp_day
if (($? > 0))
then
  echo "[$timestamp] *** Erreur SCP copie des factures" >> $dir_log/backup-$timestamp_day.log
  echo "[$timestamp] *** Invoices not saved, SCP error" >> $dir_log/backup-critical.log
fi

