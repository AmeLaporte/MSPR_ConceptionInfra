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

while [ "${x:=1}" -le 10 ]
    do
    chaine=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $2 | head -n 1)
    print $chaine
    mysql -u amelie -ppassword <<EOFMYSQL
        use testdb;
        insert into info(id,nom)
        values("$id","$chaine");
EOFMYSQL
done

echo "Vos donnees ont ete generees."