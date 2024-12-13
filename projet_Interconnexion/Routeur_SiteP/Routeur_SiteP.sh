#!/bin/bash

# Ajout des routes statiques nécessaires
ip route add 120.0.96.0/23 via 120.0.98.2
ip route add 120.0.98.0/23 via 120.0.98.2
ip route add 120.0.101.0/23 via 120.0.100.4

# Création du fichier de baux DHCP s'il n'existe pas
touch /var/lib/dhcp/dhcpd.leases

# Démarrage du serveur DHCP
dhcpd
service isc-dhcp-server start
