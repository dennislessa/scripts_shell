#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    if [ -z $2 ]; then
        echo "Erro: Nome de usuário e senha nao informados."
        echo 
        echo "Voce precisa informar o nome e senha de usuario para poder continuar."
        exit;
    fi;
    
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
    mysql -u root -p"$2" -e "use mysql; update user set plugin='' where User='root'; flush privileges; exit;"
    
    echo "Instalando PHP..."
    apt install php php-mysql -y
    
    echo "Alterando permissões..."
    chown www-data:www-data -R /var/www/
    chown -R $1 /var/www
    chmod -R 755 /var/www
    
    echo 
    echo "Instalação concluída."
else
    echo "Você precisa ter permissão de administrador."
    echo "Instalação cancelada."
    exit;
fi
