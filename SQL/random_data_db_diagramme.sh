#/bin/bash

#==============================================================================
# Script  : Creation automatiser des tables de la base de donnees.
# Appel   : random_data_db_diagramme.sh
# Version : V1.0.0
#------------------------------------------------------------------------------
# V0.0 AL 10/2019  -- Version initiale
#==============================================================================

#------------------------------------------------------------------------------
# M A I N . . . 
#------------------------------------------------------------------------------

while [ "${x:=1}" -le 50 ]
    do
    # Table client
    nom=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1)
    prenom=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 8 | head -n 1)
    telephone=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 10)
    mail=$nom'.'$prenom'@'$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)".com"

    mysql -u amelie -ppassword <<EOFMYSQL
        use db_diagramme;
        insert into client(client_id,nom,prenom,telephone,mail)
        values("$x","$nom","$prenom","$telephone","$mail");
EOFMYSQL

    # Table logiciel
    nom=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1)
    cle_licence= $(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 100 | head -n 1)
    mysql -u amelie -ppassword <<EOFMYSQL
        use db_diagramme;
        insert into logiciel(logiciel_id,nom,cle_licence)
        values("$x","$nom","$cle_licence");
EOFMYSQL

    # table commande
    client_id=`shuf -i 1-$x -n 1`
    logiciel_id=`shuf -i 1-$x -n 1`
    date_commande=`date -d "$((RANDOM%6+2010))-$((RANDOM%12+1))-$((RANDOM%28+1))" '+%Y-%m-%d'`
    
        mysql -u amelie -ppassword <<EOFMYSQL
        use db_diagramme;
        insert into commande(commande_id,client_id,date_commande,logiciel_id)
        values("$x","$client_id","$date_commande","$logiciel_id");
EOFMYSQL

let x+=1
done

echo "Vos donnees ont ete generees."