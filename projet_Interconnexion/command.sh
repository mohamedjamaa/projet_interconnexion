#!/bin/bash

# Supprimer les conteneurs, images, et réseaux existants
docker rm -vf $(docker ps -a -q)
docker rmi -f $(docker images -a -q)
docker network prune -f

# Build des images nécessaires
docker build Routeur_SiteP -t image_routeur_sitep
docker build Routeur_Entreprises -t image_routeur_entreprises
docker build Serveur_DHCP -t image_serveur_dhcp
docker build Serveur_DNS -t image_serveur_dns

# Création des réseaux nécessaires
docker network create --driver=bridge Reseau_Site_Principal --subnet=120.0.54.0/23
docker network create --driver=bridge Reseau_Entreprise --subnet=120.0.50.0/23

# Lancement des conteneurs
docker run -tid --name Routeur_SiteP --cap-add=NET_ADMIN image_routeur_sitep
docker run -tid --name Routeur_Entreprises --cap-add=NET_ADMIN image_routeur_entreprises
docker run -tid --name Serveur_DHCP --cap-add=NET_ADMIN image_serveur_dhcp
docker run -tid --name Serveur_DNS --cap-add=NET_ADMIN image_serveur_dns

# Connexion des conteneurs aux réseaux
docker network connect Reseau_Site_Principal Routeur_SiteP
docker network connect Reseau_Site_Principal Serveur_DHCP
docker network connect Reseau_Site_Principal Serveur_DNS
docker network connect Reseau_Entreprise Routeur_SiteP
docker network connect Reseau_Entreprise Routeur_Entreprises

echo "Routeur SiteP, Routeur Entreprises, Serveur DHCP et Serveur DNS démarrés et connectés aux réseaux."
