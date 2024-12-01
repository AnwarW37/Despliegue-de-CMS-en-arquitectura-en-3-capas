# WORDPRESS 3 CAPAS
## Índice
- [Introducción](#introducción)
- [Despliegue AWS](#DespliegueAWS)

## Introducción
En esta práctica, he desplegado WordPress en AWS con alta disponibilidad y escalabilidad, implementando una arquitectura en tres capas:
* Capa 1 (Pública): Balanceador de carga.
* Capa 2 (Privada): Servidores de Backend + NFS.
* Capa 3 (Privada): Servidor de BBDD.

Con respecto a la infraestructura,que solo la capa pública sea accesible desde el exterior. Además, se impedirá la conectividad directa entre las capas 1 y 3, y se utilizan grupos de seguridad para proteger las máquinas y gestionar el tráfico entre las capas.

## Despliegue AWS
En primer lugar, creamos una VPC.
![IM1](https://drive.google.com/file/d/1nzFyFNLwlM3VuhoMRlpsrKd5Jyhjr4_X)
