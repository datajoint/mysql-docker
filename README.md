# MySQL for DataJoint
This is a docker image of mysql that comes configured for use with DataJoint!

## Warning to Mac and Windows users
Please note that there are still some issues running a MySQL Docker container on virtual machines under Mac and Windows, as in particular MySQL image cannot work well with files that are mapped from the host machine (i.e. Mac/Windows) onto the virtual machine on which the Docker container is running. This issue is expected to be resolved once [integrated Docker solution for Mac and Windows gets released](https://blog.docker.com/2016/03/docker-for-mac-windows-beta/). Until then, users are recommended to use Docker based MySQL deployment on Mac and Windows only for testing purposes. Refer to instructions below to modify the content of `docker-compose.yml` such that you can run the container on Mac/Windows. Please be aware that after the modificatio of the `docker-compose.yml`, the data you store in MySQL container on Mac/Windows should generally be considered **not properly backed up** and thus users are strongly discouraged to store any important data in the MySQL server running this way!! Until the integrated Docker becomes available, please consider running MySQL container on a Linux machine.

## How to use

### Using `docker-compose`
The simplest and the recommended way to configure and run a MySQL server with Docker is to use the [Docker compose](https://docs.docker.com/compose/). Once you have `docker` and `docker-compose` installed on your system (the one on which you'd want to run the MySQL server), copy this [`docker-compose.yml`](https://raw.githubusercontent.com/datajoint/mysql-docker/master/docker-compose.yml) to a folder, and run `docker-compose up -d` to start the MySQL server. Here is a series of commands to run in the terminal to achieve this:

```shell
$ mkdir mysql-docker
$ cd mysql-docker
$ wget https://raw.githubusercontent.com/datajoint/mysql-docker/master/docker-compose.yml
$ sudo docker-compose up -d
```

This will start the MySQL server mapped to localhost's port `3306`, and any MySQL data will be stored in the direction `./data`, on if you followed the above instructions, `mysql-docker/data` directory. 

Read on to find out the details about the content of the `docker-compose.yml` and how you can customize it to fit your needs.

### What's in `docker-compose.yml`?
The content of the `docker-compose.yml` is rather simple:

```yml
version: '2'
services:
  db:
    image: datajoint/mysql
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=simple
    volumes:
      - ./data:/var/lib/mysql
```
