#/bin/bash

#==============================================================================
# Script  : Creation automatiser des tables de la base de donnees.
# Appel   : random_data.sh [option...]
# Args    : Voir usage
# Version : V0.0.1
#------------------------------------------------------------------------------
# V0.0 JpG 09/2016  -- Version initiale
# V0.1 JpG 09/2016  -- Modification nom fichier resultat
# V0.2 JpG 11/2016  -- Ajout prise en compte ORPHANs
# V1.0 JpG 10/2018  -- Utilisation 3par.inc + Prise en compte domains
#==============================================================================

usage() {
    echo "Usage: $0"
    echo "           --database  -d : Nom de la base de donnees."
    echo "           --table   -t    : Nom de la table a creer."
    echo "           --ligne   -l    : Nombre de lignes a generer."
    echo "           --numerique    -n    : Noms des champs [0-9] a generer."
    echo "           --alpha -a    : Noms des champs [Aa-Zz] a generer."
    echo ""
    exit 1
} # usage

initScript() {
    local   database=
    local   table=
    local   ligne=
    local   numerique=
    local   alpha=

    #-----------------------------------------------------------
    # Analyse ligne de commande
    #-----------------------------------------------------------

    while [ $# -gt 0 ]
    do
        case "$1" in
            --age=*)
                debugText initScript Option $1
                RefreshAge=$1
                RefreshAge=${RefreshAge#*=}
                if [[ "${RefreshAge}" != +([0-9]) ]]
                then
                    echo "Valeur option age invalide."
                    exit 4
                fi
                debugText initScript RefreshAge=${RefreshAge}
                ;;
            -a)
                [ $# -lt 2 ] && usage 4
                shift
                if [[ "${1}" != +([0-9]) ]]
                then
                    echo "Valeur option age invalide."
                    exit 4
                fi
                RefreshAge=$1
                debugText initScript RefreshAge=${RefreshAge}
                ;;
            --debug|-d)
                DebugMode=$1
                debugText initScript Option $1
                ;;
            --force|-f)
                OptRefresh=--force
                debugText initScript Option $1
                ;;
            --help|-f)
                usage 1
                ;;
            --keep|-k)
                OptRefresh=--keep
                debugText initScript Option $1
                ;;
            --quiet|-q)
                QuietMode=--quiet
                debugText initScript Option $1
                ;;
            --refresh|-r)
                OptRefresh=--refresh
                debugText initScript Option $1
                ;;
            -*)
                debugText initScript Option invalide $1
                usage 4
                ;;
            *)
                break
                ;;
        esac
        shift
    done

    debugText initScript Liste toutes baies = ${all_arrays}

    if [ $# -eq 0 ]
    then
        opt_arrays=${all_arrays}
        debugText initScript baies demandees = toutes
    else
        opt_array=${*-}
        debugText initScript baies demandees = ${opt_array}
    fi

    #-----------------------------------------------------------
    # Determination des baies sans datas
    #-----------------------------------------------------------

    opt=${OptRefresh}

    debugText initScript Determination baies sans datas
    OptRefresh=--keep
    for array in ${all_arrays}
    do
        file=${FILE_3PAR_MDL//<array>/${array,,}}
        if needRefresh ${file}
        then
            refresh_arrays="${refresh_arrays} ${array^^}"
        fi
    done
    debugText initScript baies sans datas ${refresh_arrays}

    OptRefresh=${opt}

    #-----------------------------------------------------------
    # Determinations baies a traiter (sans datas + demandees)
    #-----------------------------------------------------------



} # initScript

randomChaine(){
while [ "${n:=1}" -le "8" ] 
do
chaine="$chaine${char:$(($RANDOM%${#char})):1}"
let n+=1
done
} # randomChaine

#
# M A I N . . . 
#
mysql -u amelie -ppassword <<EOFMYSQL
use testdb;
insert into test(id,nom)
values("$x","$chaine");
EOFMYSQL

while ["${entrees:=1" -le "500"]
do

randomChaine(numero,10)

#SQL insert line with all the infos!

done
echo "Vos donnees ont ete generees."