#!/bin/bash

if [ $(id -u) -eq 0 ]; then
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
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
