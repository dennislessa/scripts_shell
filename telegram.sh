#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    echo "Apagando versões anteriores..."
    rm -R /usr/lib/telegram
    rm /usr/share/applications/telegram.desktop

    echo "Baixando o Telegram..."
    wget "https://telegram.org/dl/desktop/linux" -O telegram.tar.xz
    tar -Jxf telegram.tar.xz -C /usr/lib
    
    echo "Instalando o Telegram..."
    mv /usr/lib/Telegram*/ /usr/lib/telegram
    wget "https://telegram.org/img/t_logo.png" -O telegram-icon.png
    mv ./telegram-icon.png /usr/lib/telegram
    ln -sf /usr/lib/telegram/Telegram /usr/bin/telegram

    echo "Criando atalho..."
    echo "[Desktop Entry]" >> /usr/share/applications/telegram.desktop
    echo "Type=Application" >> /usr/share/applications/telegram.desktop
    echo "Name=Telegram" >> /usr/share/applications/telegram.desktop
    echo "Icon=/usr/lib/telegram/telegram-icon.png" >> /usr/share/applications/telegram.desktop
    echo "Exec=/usr/bin/telegram %U" >> /usr/share/applications/telegram.desktop
    echo "Terminal=false" >> /usr/share/applications/telegram.desktop
    echo "Categories=Internet;" >> /usr/share/applications/telegram.desktop

    echo "Removendo pacotes desncesessários..."
    rm telegram.tar.xz
    apt autoremove
    
    echo 
    echo "Instalação concluída."
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
