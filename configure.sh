#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    echo "Removendo configurações padrão..."
    apt purge sddm-theme* plasma-workspace-wallpapers
    rm -rf /usr/share/wallpapers/*
    
    dpkg --add-architecture i386
    
    echo "Atualizando o sistema..."
    apt update && apt dist-upgrade -y
    
    echo "Atualizando o Grub..."
    update-grub && update-grub2
    
    echo "Instalando programas..."
    apt install linux-headers-$(uname -r) \
                linux-image-$(uname -r) \
                firmware-linux \
                firmware-samsung \
                firmware-iwlwifi \
                firmware-realtek \
                firmware-intel-sound \
                intel-microcode \
                inteltool \
                intel-gpu-tools \
                build-essential \
                phonon-backend-vlc \
                sddm-theme-maui \
                plasma-workspace-wallpapers -y
    
    echo "Atualizando o novos pacotes..."
    apt update && apt dist-upgrade -y
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
