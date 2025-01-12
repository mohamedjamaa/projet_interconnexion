FROM frrouting/frr:latest

COPY R_SiteSecondaire.sh /home/

RUN ["chmod", "+x", "/home/R_SiteSecondaire.sh"]

ENTRYPOINT [ "/home/R_SiteSecondaire.sh" ]
