#!/bin/bash

MYSQL=$(dpkg-query -W -f='${Status}' default-mysql-server 2>/dev/null | grep -c 'ok installed')

if [ $MYSQL -eq 0 ]; then
    echo "Paigaldame MySQL ja vajalikud lisad"
    apt-get update
    apt-get install -y default-mysql-server

    if [ $? -eq 0 ]; then
        echo "MySQL on edukalt paigaldatud."

        # Loome MySQL konfiguratsioonifaili
        touch $HOME/.my.cnf
        echo "[client]" >> $HOME/.my.cnf
        echo "host = localhost" >> $HOME/.my.cnf
        echo "user = root" >> $HOME/.my.cnf
        echo "password = qwerty" >> $HOME/.my.cnf

        # Käivitame MySQL klienti
        mysql
    else
        echo "Viga: MySQL paigaldamine ebaõnnestus."
    fi

elif [ $MYSQL -eq 1 ]; then
    echo "MySQL-server on juba paigaldatud."
    mysql
fi

