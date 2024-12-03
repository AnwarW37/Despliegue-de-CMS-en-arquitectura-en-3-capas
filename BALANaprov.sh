# Actualizar repositorios y instalamos Apache.
sudo apt update
sudo apt install apache2 -y
#Activar los siuientes módulos para que funcione como balanceador .
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests
#Reiniciar servicio apache.
sudo systemctl restart apache2
#Copiamos el Fichero de config.
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/load-balancer.conf
#Editamos el fichero de config.

#sudo nano /etc/apache2/sites-available/load-balancer.conf

#Editamos el fichero de configuración.Ponemos las IPs de los servidores web.
#<VirtualHost *:80>
#        <Proxy balancer://mycluster>
#                # Server 1
#                BalancerMember http://192.168.33.20
#                # Server 2
#                BalancerMember http://192.168.33.30
#        </Proxy>
#        ProxyPass / balancer://mycluster/
# </VirtualHost>

#Deshabilitamos el que esta por defecto y habilitamos el que hemos creado
sudo a2dissite 000-default.conf
sudo a2enssite load-balancer.conf
#Reiniciamos apache.
sudo systemctl reload apache2