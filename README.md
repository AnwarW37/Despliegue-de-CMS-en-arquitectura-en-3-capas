# WORDPRESS 3 CAPAS

## Índice
- [Introducción](#introducción)
- [Despliegue](#despliegue)

## Introducción
En esta práctica, he desplegado WordPress en AWS con alta disponibilidad y escalabilidad, implementando una arquitectura en tres capas:
* Capa 1 (Pública): Balanceador de carga.
* Capa 2 (Privada): Servidores de Backend + NFS.
* Capa 3 (Privada): Servidor de BBDD.

Con respecto a la infraestructura, que solo la capa pública sea accesible desde el exterior. Además, se impedirá la conectividad directa entre las capas 1 y 3, y se utilizan grupos de seguridad para proteger las máquinas y gestionar el tráfico entre las capas.

## Despliegue
### VPC

En primer lugar he creado la VPC. Con la red 192.168.1.0/24

![1](https://github.com/user-attachments/assets/83229e7d-bc96-4ed9-93bd-eb05b4079127)

### Subredes
Para mayor seguridad he dividido la red 192.168.1.0/24 en 3 subredes , una para cada capa.
* Subred Pública.
![2](https://github.com/user-attachments/assets/0a33a75a-618a-422f-97bc-19de53c3e03b)
  Importante, para la Subred Pública, tenemos que activar la siguiente opción para que, cuando vayamos a crear la instancia, este le asigne una IP pública.

* ![5](https://github.com/user-attachments/assets/d19378e0-d232-4bdb-ae86-d1cbdfaa71bd)

* Subred Privada Servidores Web y NFS.
![3](https://github.com/user-attachments/assets/145271ac-1950-40c4-a008-7e914b06d838)

* Subred Privada para Base de Datos.
![4](https://github.com/user-attachments/assets/4d28a357-ab87-4a9c-a3cd-4e5b5a95c2d6)

### Tablas de enrutamiento
Creamos 2 tablas de enrutamiento, una para la subred pública y otra para las privadas.

* Tabla de enrutamiento pública.
  
  Le asociamos la subred pública y le añadimos las siguientes rutas. La local que viene por defecto y la de internet , que necesitamos crear para tener una puerta de enlace de internet.
  ![6](https://github.com/user-attachments/assets/ffa1d6dc-a7aa-43e4-a257-11652da05f24)
  
* Tabla de enrutamiento privada.
  
  La asociamos a las subredes privada y le añadimos las siguientes rutas. La local que viene por defecto y para que tengan conexion a internet , primero antes creamos una GateawayNAT. Una vez instalado los paquetes que necesitamos se lo quitamos para una mayor seguridad.
  ![7](https://github.com/user-attachments/assets/9f7f3315-d39a-435e-979c-bcdaacd4d7ad)

## Instancias
Necesitamos crear las siguientes instancias.
* Balanceador de Carga
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente,la subred pública y habilitado la opción de asignar automáticamente la IP pública.
  * El grupo de seguridad he creado el siguiente:
    * Permite la conexion HTTP,HTTS y SSH desde cualquier red , podemos mejorar la seguridad asignando nuestra ip a la regla del ssh.
  * ![9](https://github.com/user-attachments/assets/6ccce951-67c8-464f-95f6-4d52ff178e65)

* Servidores Web
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente,la subred privada de los servidores web y el NFS.
  * El grupo de seguridad he creado el siguiente:
    * Permite la conexion HTTP y HTTPS solo al Balanceador de carga.
  * ![8](https://github.com/user-attachments/assets/e2b79453-86d3-4313-9be1-78c7d78c4438)  

* Servidor NFS
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente,la subred privada de los servidores web y el NFS.
  * El grupo de seguridad he creado el siguiente:
  * ![10](https://github.com/user-attachments/assets/3b04dce3-9f05-4e4f-b78c-fb1d8ea69b2e)

