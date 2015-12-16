#!/bin/bash
set -e -x
apt-get update -qq && apt-get install -qy apt-transport-https
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 90E2741A
cat >/etc/apt/sources.list.d/provision.list <<!
deb https://repo:K0xx7igY!@archive.scrapinghub.com/ubuntu precise main
deb http://archive.scrapy.org/ubuntu precise main
!
cat <<! >/etc/apt/apt.conf.d/99notranslations
Acquire::Languages "none";
!

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8756C4F765C9AC3CB6B85D62379CE192D401AB61
echo "deb https://dl.bintray.com/scrapinghub/cdh5 precise main" > /etc/apt/sources.list.d/cdh5.list

apt-get update -q

# Install Oracle Java7
mkdir -p /var/cache/apt/archives
cat <<! |debconf-set-selections
debconf shared/accepted-oracle-license-v1-1 select true
debconf shared/accepted-oracle-license-v1-1 seen true
oracle-java7-installer oracle-java7-installer/local string /var/cache/apt/archives
oracle-java7-installer oracle-java7-installer/local seen true
!
apt-get install -qy oracle-java7-installer
cp -fu /var/cache/oracle-jdk7-installer/jdk*tar.gz /var/cache/apt/archives/
ln -sf java-7-oracle /usr/lib/jvm/default-java
# see the following link for why this is needed:  http://askubuntu.com/questions/21131
apt-get purge -y openjdk-\* icedtea-\* icedtea6-\*

apt-get install -y vim htop libmysql-java

# cloudera manager need root access
echo root:root | chpasswd
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
service ssh restart

cat >/etc/hosts<<EOF
127.0.0.1 localhost.localdomain localhost
33.33.33.61 cmhost1
33.33.33.62 cmhost2
33.33.33.63 cmhost3
EOF
