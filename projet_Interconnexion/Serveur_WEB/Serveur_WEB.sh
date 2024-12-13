#!/bin/bash

# Configuration de la route vers le réseau 120.0.50.0/23 via 120.0.54.2
ip route add 120.0.50.0/23 via 120.0.54.2

# Démarrage du service Apache2
echo "Démarrage du serveur Apache2..."
service apache2 start

# Configuration de l'interface réseau (si nécessaire)
echo "Configuration de l'interface réseau..."
cat <<EOT > /etc/network/interfaces.d/eth1.cfg
auto eth1
allow-hotplug eth1
iface eth1 inet dhcp
EOT

# Appliquer la configuration réseau
echo "Application de la configuration réseau..."
ifdown eth1 && ifup eth1

echo "Serveur Web configuré et opérationnel."
