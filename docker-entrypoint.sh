#!/bin/bash
set -e

if [ "$1" = 'start' ]; then

  DB_CONFIG_FILE=/etc/cloudera-scm-server/db.properties
  CM_USER="cloudera-scm"
  CM_GROUP="cloudera-scm"

  if [[ "$CM_DB_CONFIG" != "" ]]; then
      cp -f $CM_DB_CONFIG $DB_CONFIG_FILE
  fi

  # Fix rights on db.properties config file
  chown $CM_USER:$CM_GROUP $DB_CONFIG_FILE

  set CLOUDERA_ROOT=/opt/cloudera
  set CMF_DEFAULTS=/etc/default/cloudera-scm-server

  /opt/cloudera/cm/bin/cm-server-pre
  exec runuser -u $CM_USER -g $CM_GROUP /opt/cloudera/cm/bin/cm-server
fi

exec "$@"