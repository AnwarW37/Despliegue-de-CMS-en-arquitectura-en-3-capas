## Índice
- [Introducción](#introducción)
- [DDespliegue y Configuración](#despliegue-y-configuración)
  - [VPC](#vpc)
  - [Subredes](#subredes)
  - [Tablas de enrutamiento](#tablas-de-enrutamiento)
  - [Instancias](#instancias)
    - [Balanceador de Carga](#balanceador-de-carga)
    - [Servidores Web](#servidores-web)
    - [Servidor NFS](#servidor-nfs)
    - [Servidor Base de Datos](#servidor-base-de-datos)

## Introducción
En esta práctica, he desplegado WordPress en AWS con alta disponibilidad y escalabilidad, implementando una arquitectura en tres capas:
* Capa 1 (Pública): Balanceador de carga.
* Capa 2 (Privada): Servidores de Backend + NFS.
* Capa 3 (Privada): Servidor de BBDD.

Con respecto a la infraestructura, que solo la capa pública sea accesible desde el exterior. Además, se impedirá la conectividad directa entre las capas 1 y 3, y se utilizan grupos de seguridad para proteger las máquinas y gestionar el tráfico entre las capas.

## Despliegue y Configuración

### VPC
En primer lugar he creado la VPC. Con la red 192.168.1.0/24

![1](https://github.com/user-attachments/assets/83229e7d-bc96-4ed9-93bd-eb05b4079127)

### Subredes
Para mayor seguridad he dividido la red 192.168.1.0/24 en 3 subredes, una para cada capa.
* Subred Pública.
![2](https://github.com/user-attachments/assets/0a33a75a-618a-422f-97bc-19de53c3e03b)
  Importante, para la Subred Pública, tenemos que activar la siguiente opción para que, cuando vayamos a crear la instancia, esté le asigne una IP pública.

* ![5](https://github.com/user-attachments/assets/d19378e0-d232-4bdb-ae86-d1cbdfaa71bd)

* Subred Privada Servidores Web y NFS.
![3](https://github.com/user-attachments/assets/145271ac-1950-40c4-a008-7e914b06d838)

* Subred Privada para Base de Datos.
![4](https://github.com/user-attachments/assets/4d28a357-ab87-4a9c-a3cd-4e5b5a95c2d6)

### Tablas de enrutamiento
Creamos 2 tablas de enrutamiento, una para la subred pública y otra para las privadas.

* Tabla de enrutamiento pública.
  
  Le asociamos la subred pública y le añadimos las siguientes rutas. La local que viene por defecto y la de internet, que necesitamos crear para tener una puerta de enlace de internet.
  ![6](https://github.com/user-attachments/assets/ffa1d6dc-a7aa-43e4-a257-11652da05f24)
  
* Tabla de enrutamiento privada.
  
  La asociamos a las subredes privadas y le añadimos las siguientes rutas. La local que viene por defecto y, para que tengan conexión a internet, primero antes creamos una GateawayNAT. Una vez instalados los paquetes que necesitamos, se lo quitamos para una mayor seguridad.
  ![7](https://github.com/user-attachments/assets/9f7f3315-d39a-435e-979c-bcdaacd4d7ad)

## Instancias
Necesitamos crear las siguientes instancias.

### Balanceador de Carga
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente, la subred pública y habilitado la opción de asignar automáticamente la IP pública.
  * El grupo de seguridad que he creado es el siguiente:
    * Permite el tráfico HTTP, HTTPS y SSH desde cualquier red; podemos mejorar la seguridad asignando nuestra IP a la regla del SSH.
  * ![9](https://github.com/user-attachments/assets/6ccce951-67c8-464f-95f6-4d52ff178e65)

### Servidores Web
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente, la subred privada de los servidores web y el NFS.
  * El grupo de seguridad que he creado es el siguiente:
    * Permite el tráfico HTTP "80" y HTTPS "443" solo al Balanceador de carga. Para el SSH me he conectado a través del balanceador, pero una vez en funcionamiento, deberíamos quitar esta regla para mejorar la seguridad.
  * ![8](https://github.com/user-attachments/assets/6dff5aaf-3aef-4dcf-9301-c67396d396c6)

### Servidor NFS
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente, la subred privada de los servidores web y el NFS.
  * El grupo de seguridad que he creado es el siguiente:
    * Permite el tráfico NFS "2049" solo a la red de los servidores web y el SSH mediante el servidor balanceador. 
  * ![9](https://github.com/user-attachments/assets/d412ab3a-d7fc-431b-9111-6ea1bf3a3053)

### Servidor Base de Datos
  * He utilizado la imagen de Ubuntu Server 24.04 LTS.
  * Par de claves vockey.
  * En la configuración de red, he seleccionado la VPC que hemos creado anteriormente, la subred privada de la base de datos.
  * El grupo de seguridad que he creado es el siguiente:
    * Permite el tráfico de MySQL "3306" a los servidores web. La regla SSH, como he comentado anteriormente, la podemos quitar o poner la IP del dispositivo con el que nos vamos a conectar. Yo, en este caso, me he conectado mediante los servidores web. Ya que la práctica nos especifica que no puede haber conectividad entre la Capa 1 y la Capa 3.
  * ![10](https://github.com/user-attachments/assets/275659f4-3bf2-4035-b743-67ab6d10c389)
