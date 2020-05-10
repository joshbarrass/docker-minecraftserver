FROM openjdk:8-jre-slim

ARG version=latest
ENV VERSION=$version

WORKDIR /buildtools

# install buildtools prerequesites
# download and run buildtools
# copy server files
# clean up buildtools files
# remove unneeded prerequisites
RUN  apt-get update \
  && apt-get install -y wget git \
  
  && wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
  && git config --global --unset core.autocrlf; \
  java -jar BuildTools.jar --rev "$VERSION" \
  
  && mkdir /spigot \
  && mv spigot-*.jar /spigot \
  
  && rm -rf /buildtools \
  
  && apt-get remove -y --purge wget git \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /spigot
COPY run-server.sh run-server.sh
RUN chmod +x run-server.sh
VOLUME /server

EXPOSE 25565

CMD ["/spigot/run-server.sh"]
