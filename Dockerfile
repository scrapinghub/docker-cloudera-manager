FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

# Accept oracle license in debconf
ADD java7.debconf /tmp/java7.debconf
# Add webupdate8 apt repo
ADD java7.list /etc/apt/sources.list.d/java7.list
# Add webupdate8 signing key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7B2C3B0889BF5709A105D03AC2518248EEA14886

RUN cat /tmp/java7.debconf |debconf-set-selections

# Install Oracle Java7
RUN apt-get update -qq \
    && apt-get install -qy oracle-java7-installer curl \
    && rm -f /var/cache/oracle-jdk7-installer/jdk*tar.gz \
    && ln -sf java-7-oracle /usr/lib/jvm/default-java \
    && apt-get purge -y openjdk-\* icedtea-\* icedtea6-\* \
    && curl -s https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key | apt-key add - \
    && wget -q -O /etc/apt/sources.list.d/cloudera.list "https://archive.cloudera.com/cm5/ubuntu/trusty/amd64/cm/cloudera.list" \
    && apt-get update -qq \
    && apt-get install -y cloudera-manager-daemons cloudera-manager-server libmysql-java \
    && rm -rf /var/lib/apt/lists
