#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    if [ -z $1 ]; then
        echo "Erro: Chave de instalação não informada."
        echo 
        echo "Voce precisa informar uma chave para instalação do Spofify."
        echo "Acess: https://www.spotify.com/br/download/linux/ para adquiri-la."
        exit;
    else
        echo "Instalando dependencias..."
        apt install dirmngr -y
        
        echo "Instalando Spotify..."
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $1
        echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
        apt update
        apt install spotify-client -y
        echo
        echo "Instalação concluída."
    fi
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
