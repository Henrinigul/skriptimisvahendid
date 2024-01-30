#!/bin/bash

# Kontrollime, kas Apache on juba paigaldatud
dpkg-query -W -f='${Status}' apache2 | grep -q "ok installed"

# $? salvestab eelneva käsu väljundkoodi
if [ $? -eq 0 ]; then
    # Kui Apache on juba paigaldatud, väljastame teade ja näitame teenuse staatust
    echo "Apache on juba paigaldatud."
    service apache2 status
else
    # Kui Apache ei ole paigaldatud, paigaldame selle
    echo "Apache pole paigaldatud. Alustame paigaldust..."
    apt-get update
    apt-get install -y apache2

    # Kontrollime, kas paigaldamine oli edukas
    if [ $? -eq 0 ]; then
        echo "Apache on edukalt paigaldatud."
        service apache2 status
    else
        echo "Viga: Apache paigaldamine ebaõnnestus."
    fi
fi

