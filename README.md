# WORDPRESS 3 CAPAS

## Índice
- [Introducción](#introducción)
- [Despliegue](#despliegue)
  - [VPC](#vpc)

## Introducción
En esta práctica, he desplegado WordPress en AWS con alta disponibilidad y escalabilidad, implementando una arquitectura en tres capas:
* Capa 1 (Pública): Balanceador de carga.
* Capa 2 (Privada): Servidores de Backend + NFS.
* Capa 3 (Privada): Servidor de BBDD.

Con respecto a la infraestructura, que solo la capa pública sea accesible desde el exterior. Además, se impedirá la conectividad directa entre las capas 1 y 3, y se utilizan grupos de seguridad para proteger las máquinas y gestionar el tráfico entre las capas.

## Despliegue
En primer lugar, creamos una VPC.

### VPC

![1](https://github.com/user-attachments/assets/c51a2623-7f21-448b-9075-81ec066681e6)


![2](https://github.com/user-attachments/assets/e50b73fc-f43c-4ec0-b480-0a29e4a13286)
