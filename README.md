Dockerized [Cloudera Manager](https://www.cloudera.com/content/www/en-us/products/cloudera-manager.html).

## Configuration

Cloudera Manager requires an external mysql/postgresql database. To use an
external `db.properties` file, pass it as a volume and set the `CM_DB_CONFIG`
environment variable, e.g.:


```sh
docker run -it --rm \
    --name cm \
	-v $PWD/db.properties:/mnt/mesos/sandbox/db.properties \
    -e CM_DB_CONFIG=/mnt/mesos/sandbox/db.properties \
    scrapinghub/cloudera-manager:5.4
    start
```
