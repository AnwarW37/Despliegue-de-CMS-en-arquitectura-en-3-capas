#Instalamos MySQL
sudo apt update
sudo apt install mysql-server -y

#Creamos la base de datos.
sudo mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

#Creamos los usuarios para que los servidores web puedan acceder a la base de datos.
#ServidorWeb1
sudo mysql -e "CREATE USER 'UsuarioWordPress'@'192.168.66.2' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON WordPressBD.* TO 'UsuarioWordPress'@'192.168.66.2';"
#ServidorWeb2
sudo mysql -e "CREATE USER 'UsuarioWordPress'@'192.168.66.3' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON WordPressBD.* TO 'UsuarioWordPress'@'192.168.66.3';"
#Aplicamos los cambios
sudo mysql -e "FLUSH PRIVILEGES;"

#Cambiamos el Bind Adress para poder acceder desde fuera y reiniciamos el servicio mysql.
sudo cat /etc/mysql/mysql.conf.d/mysqld.cnf |sed "s/^bind-address[[:space:]]*=.*/bind-address = 192.168.66.1/" > /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
