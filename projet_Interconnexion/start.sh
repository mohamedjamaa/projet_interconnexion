#!/bin/bash

# Lancer le script de configuration pour le Routeur SiteP
docker exec Routeur_SiteP /Routeur_SiteP.sh

# Lancer le script de configuration pour le Routeur Entreprises
docker exec Routeur_Entreprises /Routeur_Entreprises.sh

# Initialiser le serveur DHCP
docker exec Serveur_DHCP bash -c "touch /var/lib/dhcp/dhcpd.leases && dhcpd"

# Initialiser le serveur DNS
docker exec Serveur_DNS service bind9 start

# Activer le routage IP et les règles NAT sur le Routeur SiteP
docker exec Routeur_SiteP bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
docker exec Routeur_SiteP iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Activer le routage IP et les règles NAT sur le Routeur Entreprises
docker exec Routeur_Entreprises bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
docker exec Routeur_Entreprises iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo "Routeur SiteP, Routeur Entreprises, Serveur DNS et Serveur DHCP sont démarrés."
