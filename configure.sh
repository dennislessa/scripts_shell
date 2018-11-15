#!/bin/bash

function _getUserEx
{
    getent passwd "$1" >/dev/null 2>&1
}

if [ $(id -u) -eq 0 ]; then
    if [ "$1" != "--pulse-configure" ] && [ "$1" != "" ]; then
        echo "Argumento nao existe."
        echo "Instalação abortada."
        exit;
    fi;
    
    if [ "$1" = "--pulse-configure" ] && [ "$(cat /etc/passwd| grep -i $2| wc -l)" != "1" ]; then
        echo "Informe o segundo argumento (nome do usuário válido)."
        echo "Instalação abortada."
        exit;
    fi;

    echo "Atualizando o sistema..."
    apt update && apt dist-upgrade -y
    
    echo "Atualizando o Grub..."
    update-grub && update-grub2
    
    echo "Instalando programas..."
    apt install linux-headers-$(uname -r) \
                linux-image-$(uname -r) \
                firmware-linux \
                firmware-linux-free \
                firmware-linux-nonfree \
                firmware-samsung \
                firmware-iwlwifi \
                firmware-realtek \
                firmware-intel-sound \
                intel-microcode \
                inteltool \
                intel-gpu-tools \
                build-essential \
                phonon-backend-vlc -y
    
    if [ "$1" = "--pulse-configure" ] && [ "$(cat /etc/passwd| grep -i $2| wc -l)" = "1" ]; then
        echo "Configurando Pulse Audio..."
        echo "" >> /etc/pulse/daemon.conf
        echo "flat-volumes = no" >> /etc/pulse/daemon.conf
        echo "enable-deferred-volume = no" >> /etc/pulse/daemon.conf

        su - $2
        pulseaudio -k && pulseaudio --start
        
        echo "Pulse Audio configurado."
        echo "Instalação finalizada."
    else
        echo "usuario nao existe"
    fi;
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
