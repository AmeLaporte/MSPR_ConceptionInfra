#!/bin/bash


: <<'COMMENT'
# Recuperer les donnees des logs SAMBA
#id: pour donner l id dans la table mySQL qui s incremente automatiquement
id_smb=0

#Boucle qui va lister tous les fichiers des logs samba un a un
for file in /var/log/samba/*
do
  #Dans ip_smb on recupere l adresse IP en fin du nom de fichier log
  ip_smb=`ls -l $file | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"`
  #Si le fichier contient une adresse ip dans son nom alors on recupere le reste des infos
  #et on les enregistre dans la table mySQL
  if [ $ip_smb ]
    then
      #On recupere la date du fichier de log
      date_smb=`ls --full-time $file | grep -Eo "\b([0-9]{1,4}\-){2}[0-9]{1,3}\b"`
      type_smb="samba"
      heure_ftp=`ls --full-time $file | grep -Eo "\b([0-9]{1,2}\:){2}[0-9]{1,2}\b"`
      #On insere les informations dans la table mySQL
      mysql -u root -ppassword <<EOFMYSQL
	use connection;
	insert into info(id,date,adresse,type)
        values("$id","$date_smb","$ip_smb","$type_smb");
EOFMYSQL
    #On incremente l id afin que la prochaine entree dans la table mySQL ai un id different
    id_smb=$(($id_smb+1))
    fi
done
COMMENT


#Recuperer les donnees des logs proFTP
oldIFS=$IFS
IFS=$'\n'

id_ftp=0

while read -r line
do
echo $line
#ip_ftp=`grep -Eo "\b\[([0-9]{1,3}\.){3}[0-9]{1,3}\b" $line`
date_ftp=`grep -Eo "\b([0-9]{1,4}\-){2}[0-9]{1,3}\b" $line`
heure_ftp=`echo "$line" | grep -Eo "\b([0-9]{1,2}\:){2}[0-9]{1,2}\b"`
type_fpt="ftp"
echo "${ip_ftp#\[}"

#id_ftp=${{$id_ftp+1}}
done < /var/log/proftpd/proftpd.log
