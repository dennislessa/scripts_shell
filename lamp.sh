#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    echo "Removendo instalações anteriores"
    apt purge apache2* php* mysql* -y
    apt autoremove -y
    
    echo "Atualizando base de pacotes..."
    apt update && apt dist-upgrade -y
    
    echo "Instalando servidor Apache2..."
    apt install apache2 apache2-doc -y
    
    echo "Instalando MySQL..."
    apt install mysql-server mysql-client phpmyadmin -y
    mysql_secure_installation
    mysql -u root -p"211190" -e "use mysql; update user set plugin='' where User='root'; flush privileges; exit;"
    
    echo "Instalando PHP..."
    apt install php php-mysql -y
    
    echo "Alterando permissões..."
    chown www-data:www-data -R /var/www/
    chown -R dennislessa /var/www
    chmod -R 755 /var/www
    
    echo 
    echo "Instalação concluída."
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
