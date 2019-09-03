#!/bin/bash

commandes=$(mysql -D test_infinivo -u amelie -ppassword -se "select * from commande where status="N")
