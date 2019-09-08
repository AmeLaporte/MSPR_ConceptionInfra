#/bin/bash

#==============================================================================
# Script  : Recupere la licence disponible pour les commandes client non traite et envoie un mail au client.
# Appel   : send_and_update_command.sh
# Version : V0.0.1
#------------------------------------------------------------------------------
# V0.0 JpG 08/2019  -- Version initiale
#==============================================================================

#Script a planifier dans un crontab toutes les minutes

today=`date '+%Y-%m-%d'`
logiciels=$(mysql -D test_infinivo -u amelie -ppassword -se "select logiciel_id from commande where status_com='N'")

#recuperer l'id du logiciel ET de la commande et iterer tout les 2 items et faire x-1 pour l'id commande?
for logiciel in $logiciels
do
    #Recupere l'id de la commande du client
    #commande=$(mysql -D test_infinivo -u amelie -ppassword -se "select commande_id from commande where status_com='N' and logiciel_id=$logiciel")
    # Recupere une licence libre a envoyer au client
    available_lic=$(mysql -D test_infinivo -u amelie -ppassword -se "select licence_id from licence where status_lic='N' and logiciel_id=$logiciel")
    lic_array=( $available_lic )
    # Si une licence est disponible, envoyer un mail au client et mettre a jour la bdd
    # Sinon envoyer un mail de remboursement au client et mettre a jour la bdd.
    if [ -z "$lic_array" ]
    then
     echo "Il n'y a pas de licence disponible pour le moment."
     # Envoyer un mail de remboursement au client
     #(
     #   echo "To: user@gmail.com"
     #   echo "Subject: Pas de licence disponible"
     #   echo "Content-Type: text/html"
     #   echo
     #   cat mail.html
     #) | sendmail -t
    else
        random_lic=${lic_array[$RANDOM % ${#lic_array[@]}]}
        echo $random_lic
        # Envoyer un mail au client avec sa facture
        # Mettre a jour la bdd
            #commande
                #licence_id
        mysql -u amelie -ppassword test_infinivo -e "UPDATE commande SET licence_id = "$random_lic" WHERE id='myid'"
                #date_commande
        mysql -u amelie -ppassword test_infinivo -e "UPDATE commande SET date_commande = "$today" WHERE id='myid'"
                #status_com
        mysql -u amelie -ppassword test_infinivo -e "UPDATE commande SET status_com = "O" WHERE id='myid'"
            #licence
                #date_debut
                #date_fin
                #status_lic


    fi 
done