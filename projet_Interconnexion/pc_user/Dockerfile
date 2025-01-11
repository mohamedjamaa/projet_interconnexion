FROM alpine:latest

# Installer FRR depuis les sources
RUN apk add --no-cache git build-base readline-dev && \\
    git clone https://github.com/FRRouting/frr.git && \\
    cd frr && ./bootstrap.sh && ./configure --prefix=/usr && make && make install && \\
    apk del git build-base readline-dev && rm -rf /frr

# Ajouter des fichiers de configuration
COPY frr.conf /etc/frr/frr.conf
COPY zebra.conf /etc/frr/zebra.conf

# Exposer les ports nécessaires
EXPOSE 2601 2602 2603 2604

# Commande pour démarrer FRR
CMD ["/usr/lib/frr/frrinit.sh", "start"]
