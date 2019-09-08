#/bin/bash

#==============================================================================
# Script  : Recupere la licence disponible pour les commandes client non traite et envoie un mail au client.
# Appel   : send_and_update_command.sh
# Version : V0.0.1
#------------------------------------------------------------------------------
# V0.0 JpG 08/2019  -- Version initiale
#==============================================================================

commandes=$(mysql -D test_infinivo -u amelie -ppassword -se "select logiciel_id from commande where status_com='N'")

for logiciel in $commandes
do
    available_lic=$(mysql -D test_infinivo -u amelie -ppassword -se "select licence_id from licence where status_lic='N' and logiciel_id=$logiciel")
    lic_array=( $available_lic )
    random_lic=${lic_array[$RANDOM % ${#lic_array[@]}]}
    echo $random_lic
done