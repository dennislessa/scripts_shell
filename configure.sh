#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    if [ "$1" != "--pulse-configure" ] && [ "$1" != "" ]; then
        echo "Commando nao existe."
        echo "Instalação abortada."r
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
    
    if [ "$1" = "--pulse-configure" ]; then
        echo "Configurando Pulse Audio..."
        echo "" >> /etc/pulse/daemon.conf
        echo "flat-volumes = no" >> /etc/pulse/daemon.conf
        echo "enable-deferred-volume = no" >> /etc/pulse/daemon.conf

        su - dennislessa
        pulseaudio -k && pulseaudio --start
        
        echo "Pulse Audio configurado."
        echo "Instalação finalizada."
    fi;
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
