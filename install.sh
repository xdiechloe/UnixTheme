#!/bin/bash

# Pterodactyl-Theme Installation
cd /var/www/pterodactyl
php artisan down  # Wartungsmodus aktivieren

# Lade das Theme von GitHub herunter und entpacke es
curl -L https://github.com/xdiechloe/UnixTheme/archive/refs/heads/main.zip -o theme.zip
unzip -o theme.zip
rm theme.zip  # Lösche die ZIP-Datei nach dem Entpacken

# Verschiebe die entpackten Dateien an die richtige Stelle
mv UnixTheme-main/* /var/www/pterodactyl
rm -rf UnixTheme-main  # Lösche das entpackte Verzeichnis

# Setze die richtigen Berechtigungen
chmod -R 755 storage/* bootstrap/cache
composer install --no-dev --optimize-autoloader
php artisan view:clear
php artisan config:clear
php artisan migrate --seed --force
chown -R www-data:www-data /var/www/pterodactyl/*

php artisan queue:restart
php artisan up  # Wartungsmodus beenden

# Abschlussmeldung
clear
echo "Theme wurde erfolgreich installiert!"
