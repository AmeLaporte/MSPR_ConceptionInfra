#/bin/bash

char="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
num="0123456789"

#fonction randomChaine(chaine charactere, nb aleatoire){
while [ "${n:=1}" -le "8" ] 
do
chaine="$chaine${char:$(($RANDOM%${#char})):1}"
let n+=1
done
}

while ["${entrees:=1" -le "500"]
do

randomChaine(numero,10)

#SQL insert line with all the infos!

done
echo "Vos donnees ont ete generees."