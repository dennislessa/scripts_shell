#!/bin/bash

remove_packages() {
	echo "Removing unecessary packages..."
	apt autoremove -y
}

update_system() {
    echo "Atualizando o sistema..."
    apt update && apt dist-upgrade -y
    
    echo "Atualizando o Grub..."
    update-grub && update-grub2
}

thin_kde() {
    echo "Installing thin KDE..."
    apt purge *kde* *plasma* *firefox* *libreoffice* *openjdk* *icedtea* -y

    apt install plasma-desktop \
                plasma-nm \
                plasma-widgets-addons \
                kde-l10n-ptbr \
                firefox-esr \
                firefox-esr-l10n-pt-br \
                libreoffice \
                libreoffice-l10n-pt-br \
                libreoffice-style-breeze \
                openjdk-8-jdk \
                openjdk-8-jre \
                ark \
                gwenview \
                okular \
                kio-mtp \
                vlc \
                phonon-backend-vlc -y
}

general_packages() {
    echo "Installing general packages..."

    apt install linux-headers-$(uname -r) \
                linux-image-$(uname -r) \
                firmware-linux \
                firmware-samsung \
                firmware-intel-sound \
                intel-microcode \
                inteltool \
                intel-gpu-tools \
                build-essential \
                chromium \
                chromium-l10n \
                ktorrent \
                gimp \
                inkscape \
                partitionmanager -y
}

if [ $(id -u) -eq 0 ]; then
    dpkg --add-architecture i386

    # Update system
    update_system

    # Install general pakages
    general_packages

    # Install thin kde
    thin_kde

    # Clean the system
    remove_packages

    # Update system
    update_system
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
fi;
