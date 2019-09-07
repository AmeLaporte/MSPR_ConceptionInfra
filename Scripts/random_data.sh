#/bin/bash

#==============================================================================
# Script  : Creation automatiser des tables de la base de donnees.
# Appel   : random_data.sh
# Version : V0.0.1
#------------------------------------------------------------------------------
# V0.0 JpG 08/2019  -- Version initiale
#==============================================================================

#------------------------------------------------------------------------------
# M A I N . . . 
#------------------------------------------------------------------------------

status=("O" "N")

while [ "${x:=1}" -le 50 ]
    do
    # Table client
    societe=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
    nom=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1)
    prenom=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 8 | head -n 1)
    adresse=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 50 | head -n 1)
    code_postal=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 5)
    ville=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 12 | head -n 1)
    telephone=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 10)
    mail=$nom'.'$prenom'@'$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)".com"

    mysql -u amelie -ppassword <<EOFMYSQL
        use test_infinivo;
        insert into client(client_id,societe,nom,prenom,adresse,code_postal,ville,telephone,mail)
        values("$x","$societe","$nom","$prenom","$adresse","$code_postal","$ville","$telephone","$mail");
EOFMYSQL

    # Table logiciel
    descriptif=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 50 | head -n 1)
    nom=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 10 | head -n 1)
    prix_unitaire=`shuf -i 1-3000 -n 1`

    mysql -u amelie -ppassword <<EOFMYSQL
        use test_infinivo;
        insert into logiciel(logiciel_id,descriptif,nom,prix_unitaire)
        values("$x","$descriptif","$nom","$prix_unitaire");
EOFMYSQL

    # Table licence
    logiciel_id=`shuf -i 1-10 -n 1`
    status_lic=${status[$RANDOM % ${#status[@]}]}
    if [ $status_lic = "O" ]
        then
        date_debut=`date -d "$((RANDOM%6+2010))-$((RANDOM%12+1))-$((RANDOM%28+1))" '+%Y-%m-%d'`
        date_fin=`date -d "$((RANDOM%2+2012))-$((RANDOM%12+1))-$((RANDOM%28+1))" '+%Y-%m-%d'`
    else
        date_debut='0000-00-00'
        date_fin='0000-00-00'
    fi

    mysql -u amelie -ppassword <<EOFMYSQL
        use test_infinivo;
        insert into licence(licence_id,logiciel_id,date_debut,date_fin,status_lic)
        values("$x","$logiciel_id","$date_debut","$date_fin","$status_lic");
EOFMYSQL

    # table commande
    client_id=`shuf -i 1-$x -n 1`
    logiciel_id=`shuf -i 1-10 -n 1`
    remise=`shuf -i 1-40 -n 1`
    numero_facture=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 9 | head -n 1)
    prix=`shuf -i 1-6000 -n 1`
    status_com=${status[$RANDOM % ${#status[@]}]}
    if [ $status_com = "O" ]
        then
        date_commande=`date -d "$((RANDOM%6+2010))-$((RANDOM%12+1))-$((RANDOM%28+1))" '+%Y-%m-%d'`
        licence_id=`shuf -i 1-$x -n 1`
    else
    date_commande='0000-00-00'
    licence_id='1'
    fi

        mysql -u amelie -ppassword <<EOFMYSQL
        use test_infinivo;
        insert into commande(commande_id,client_id,date_commande,logiciel_id,licence_id,remise,numero_facture,prix,status_com)
        values("$x","$client_id","$date_commande","$logiciel_id","$licence_id","$remise","$numero_facture","$prix","$status_com");
EOFMYSQL
let x+=1
done

echo "Vos donnees ont ete generees."