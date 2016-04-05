# MySQL for DataJoint
This is a docker image of mysql that comes configured for use with DataJoint!

## How to use

### Using `docker-compose`
The simplest and the recommended way to configure and run a MySQL server with Docker is to use the [Docker compose](https://docs.docker.com/compose/). Once you have `docker` and `docker-compose` installed on your system (the one on which you'd want to run the MySQL server), copy this [`docker-compose.yml`](https://raw.githubusercontent.com/datajoint/mysql-docker/master/docker-compose.yml) to a folder, and run `docker-compose up -d` to start the MySQL server. Here is a series of commands to run in the terminal to achieve this:

```shell
$ mkdir mysql-docker
$ cd mysql-docker
$ wget https://raw.githubusercontent.com/datajoint/mysql-docker/master/docker-compose.yml
$ sudo docker-compose up -d
```

Refer to section below for details on the content of the `docker-compose.yml` and how you can customize it to your needs.
