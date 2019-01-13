#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    echo "Instalando dependencias..."
    apt install dirmngr -y
    
    echo "Instalando Spotify..."
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C9
    echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
    apt update
    apt install spotify-client -y
    echo
    echo "Instalação concluída."
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
