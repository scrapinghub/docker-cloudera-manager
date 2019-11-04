FROM ubuntu:18.04
LABEL MAINTAINER=root@scrapinghub.com

ENV DEBIAN_FRONTEND=noninteractive \
    CM_MAJOR_VERSION=6 \
    CM_MINOR_VERSION=3 \
    CM_PATCH_VERSION=1

ENV CM_VERSION=${CM_MAJOR_VERSION}.${CM_MINOR_VERSION}.${CM_PATCH_VERSION}
ENV CLOUDERA_BASE_URL=https://archive.cloudera.com/cm${CM_MAJOR_VERSION}/${CM_VERSION}/ubuntu1804/apt/

# Install Java8(OpenJDK), MySQL JDBC driver and configure Cloudera Repo
RUN apt-get update &&\
    apt-get install --quiet --no-install-recommends --yes \
        wget \
        gnupg2 \
        ca-certificates \
        openjdk-8-jdk \
        libmysql-java &&\
    wget -q ${CLOUDERA_BASE_URL}/cloudera-manager.list -P /etc/apt/sources.list.d &&\
    wget -q ${CLOUDERA_BASE_URL}/archive.key -O - | apt-key add - &&\
    rm -rf /var/lib/apt/lists/*

# Install cloudera-manager-{server,daemons}
RUN apt-get update &&\
    apt-get install --quiet --yes cloudera-manager-daemons cloudera-manager-server &&\
    rm -rf /var/lib/apt/lists/*

EXPOSE 7180 7182

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
