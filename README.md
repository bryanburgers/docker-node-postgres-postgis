# Node/Postgres/Postgis docker image

A docker image for [BitBucket Pipelines][pipelines] that contains node,
postgres, and postgis. While (as far as I understand it) it is not good form to
include so much in a single image, BitBucket Pipelines only allows using one
image.

Having all three of these components in a single docker image allows me to run a
full integration test of a node application against a postgresql database.

This image is available on Docker Hub at
[bryanburgers/node-postgres-postgis][dh].


## Starting postgres

This image does not start postgres automatically. Upon getting a bash prompt,
run `/start-postgres.sh` to start postgres.


## Example bitbucket-pipelines.yml

```
image: bryanburgers/node-postgres-postgis:latest

pipelines:
  default:
    - step:
        script:
          # Start the postgres server
          - /start-postgres.sh

          # Create the database schema.
          - psql -U postgres -h localhost -a -f sql/schema.sql -v ON_ERROR_STOP=1

          # Get all of the modules
          - npm install

          # And finally, run tests! This is what we actually came here for, you
          # know.
          - npm test
```


## Node

This image inherits from [node:6.9.1][node].


## Postgres

This image uses much of the docker file from [postgres:9.6.1][postgres], copy
and pasted into the docker file.


## Postgis

Because the application also uses Postgis, this image copy/pastes some of the
docker file from [mdillon/postgis:9.6][postgis].


[dh]: https://hub.docker.com/r/bryanburgers/node-postgres-postgis/
[pipelines]: https://confluence.atlassian.com/bitbucket/configure-bitbucket-pipelines-yml-792298910.html
[node]: https://hub.docker.com/_/node/
[postgres]: https://github.com/docker-library/postgres/blob/03f4064a045114f56fa445eb602339faaf79eeec/9.6/Dockerfile
[postgis]: https://github.com/appropriate/docker-postgis/blob/c61373c6e1bc173318c02a8ccf62b9c4a2c221b6/9.6-2.3/Dockerfile
