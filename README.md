Dockerized [Cloudera Manager](https://www.cloudera.com/content/www/en-us/products/cloudera-manager.html).

## Configuration

Cloudera Manager requires an external mysql/postgresql database. To use an
external `db.properties` file, pass it as a volume and mount to
`/etc/cloudera-scm-server/db.properties`


```sh
docker run -it --rm \
    --name cm \
    -v $PWD/db.properties:/etc/cloudera-scm-server/db.properties \
    scrapinghub/cloudera-manager:6.3.1
```
