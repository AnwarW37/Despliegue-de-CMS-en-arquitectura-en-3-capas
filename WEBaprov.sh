#Instalamos el cliente de NFS
sudo apt update
sudo apt install nfs-common -y

#Creamos la carpeta donde vamos a montar la carpeta compartida.
sudo mkdir -p /nfs/general

#Automatizamos el montado de la carpeta. La IP del servidor NFS.
echo "192.168.33.40:/var/nfs/general    /nfs/general   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab


#Instalamos Apache.
sudo apt update
sudo apt install apache2 -y

#Copiamos el Fichero de config
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf
#Configuramos el fichero de la siguiente forma:
#sudo nano /etc/apache2/sites-available/wordpress.conf

# <VirtualHost *:80>
#        ServerAdmin webmaster@localhost
#        DocumentRoot /nfs/general/wordpress/
#        <Directory /nfs/general/wordpress>
#           Options +FollowSymlinks
#           AllowOverride All
#           Require all granted
#        </Directory>
#        ErrorLog ${APACHE_LOG_DIR}/error.log
#        CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>

#Deshabilitamos el que esta por defecto y habilitamos el que hemos creado
sudo a2dissite 000-default.conf
sudo a2enssite load-balancer.conf
#Reiniciamos apache.
sudo systemctl reload apache2

