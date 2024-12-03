#Actualizamos los repositorio y instalmos el servidor NFS
sudo apt update
sudo apt install nfs-kernel-server -y

#Creamos el directorio que queremos compartir.
sudo mkdir /var/nfs/general -p

#Cambiamos los propietarios del grupo para no tener problemas de permisos.
sudo chown nobody:nogroup /var/nfs/general

#Añadimos a los servidores como clientes del servidor NFS y la carpeta que queremos compartir.
echo "/var/nfs/general    192.168.33.20(rw,sync,no_subtree_check)" >> /etc/exports
echo "/var/nfs/general    192.168.33.30(rw,sync,no_subtree_check)" >> /etc/exports

#Reiniciamos el servidorNFS
sudo systemctl restart nfs-kernel-server

