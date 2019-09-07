#!/bin/bash

commandes=$(mysql -D test_infinivo -u amelie -ppassword -se "select logiciel_id from commande where status_com='N'")

for logiciel in $commandes
do
    available_lic=$(mysql -D test_infinivo -u amelie -ppassword -se "select licence_id where status_lic='N' and logiciel_id=$logiciel")
    echo $commande
    echo $available_lic
done