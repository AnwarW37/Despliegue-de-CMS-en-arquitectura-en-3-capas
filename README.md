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

