#!/bin/bash

# Kontrollime, kas PHP7.3 on juba paigaldatud
dpkg-query -W -f='${Status}' php7.3 | grep -q "ok installed"

# $? salvestab eelneva käsu väljundkoodi
if [ $? -eq 0 ]; then
    # Kui PHP7.3 on juba paigaldatud, väljastame teate
    echo "PHP7.3 on juba paigaldatud."
else
    # Kui PHP7.3 ei ole paigaldatud, paigaldame selle ja vajalikud paketid
    echo "PHP7.3 pole paigaldatud. Alustame paigaldust..."

    # Uuendame paketihaldust
    apt-get update

    # Paigaldame PHP7.3
    apt-get install -y php7.3

    # Paigaldame libapache2-mod-php7.3 ja php7.3-mysql, kui need puuduvad
    apt-get install -y libapache2-mod-php7.3 php7.3-mysql

    # Kontrollime, kas paigaldamine oli edukas
    if [ $? -eq 0 ]; then
        echo "PHP7.3 on edukalt paigaldatud."
    else
        echo "Viga: PHP7.3 paigaldamine ebaõnnestus."
    fi
fi

