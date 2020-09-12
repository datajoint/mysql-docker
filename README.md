# MySQL for DataJoint
This is a docker image of mysql that comes configured for use with DataJoint!


## Administering the MySQL server

**NOTE** for 8.0.x Users** 8.0.x series images are currently version-pinned to 8.0.18 while CI issues are being investigated - please keep this in mind this may mean important security or reliability patches may not be available for users running the 8.0.x image until this is resolved.

**WARNING** Whether hosted via Docker or directly on a machine, the MySQL server needs to be administered properly. Please refer to an [appropriate reference](https://dev.mysql.com/doc/refman/5.7/en/server-administration.html) to administer the server safely and efficiently.

## How to use

### Using `docker-compose`
The simplest and the recommended way to configure and run a MySQL server with Docker is to use the [Docker compose](https://docs.docker.com/compose/). Once you have `docker` and `docker-compose` installed on your system (the one on which you'd want to run the MySQL server), copy this [`docker-compose.yml`](https://raw.githubusercontent.com/datajoint/mysql-docker/master/slim/docker-compose.yml) to a folder, and run `docker-compose up -d` to start the MySQL server. Here is a series of commands to run in the terminal to achieve this:

```bash
$ mkdir mysql-docker
$ cd mysql-docker
$ wget https://raw.githubusercontent.com/datajoint/mysql-docker/master/slim/docker-compose.yml
$ sudo docker-compose up -d
```

This will start the MySQL server mapped to localhost's port `3306`, and any MySQL data will be stored in the directory `./data`, or if you followed the above instructions, `mysql-docker/data` directory. 

By default the database sets up user `root` with password `simple` (refer to below on how to change this at the startup). You can access your locally running MySQL server using `mysql` client. On Ubuntu system, you can obtain this by installing `apt` package `mysql-client` as follows:

```bash
$ sudo apt-get install mysql-client
```

Once `mysql` client is installed, you can access the running server:

```bash
$ mysql -h 127.0.0.1 -u root -p
Enter password: [type in your password here: default is "simple"]

mysql >
```

Read on to find out the details about the content of the `docker-compose.yml` and how you can customize it to fit your needs.

### What's in `docker-compose.yml`?
The content of the `docker-compose.yml` is rather simple:

```yml
version: '2.4'
services:
  db:
    image: datajoint/mysql:5.7
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=simple
    volumes:
      - ./data:/var/lib/mysql
```

Let's step through the parts you might want to customize. The line

```yml
- MYSQL_ROOT_PASSWORD=simple
```

configures the default password. If you would like to use something else, you can modify this prior to starting your server with `docker-compose up`.

The lines:

```yml
volumes:
  - ./data:/var/lib/mysql
```

maps the local directory `./data` to the `/var/lib/mysql` inside the container where MySQL stores all of its data by default.

**WARNING**: If you decide to map volume `/var/lib/mysql` (like in the example), then settings for your MySQL server will persist across separate Docker `mysql` instances. In particular, this means that the `MYSQL_ROOT_PASSWORD` setting will be used only when the very first `mysql` Docker container is created. To change the `root` password on an alredy created `mysql` Docker instance, access the database via `mysql` client as `root` and run:

```bash
$ mysql -h 127.0.0.1 -u root -p
Enter password: [type in your old password]

mysql > SET PASSWORD FOR root = PASSWORD('your_new_password');
```

replacing the `'your_new_password'` with your new desired password surrounded by quotes (`'`).

## Backup

If you wish to take a disk-based backup of the database, simply back up the local directory matching the ':/var/lib/mysql' volume in your compose file when the database is stopped. To restore, simply copy the backed up data into place before launching the container. Please note that this type of backup is version-specific to the mysql version used with this container.

To take a backup without stopping the container, you can run:

```bash
mysql> flush tables with read lock;
```

prior to taking the backup, and

```bash
mysql> unlock tables;
```

after taking the backup. Please note that this will prevent all write activity in the database while the backup is running, and may not provide a consistent state in some environments (e.g. docker-machine or virtualization environments such as docker for windows). Be sure to check related volume mount documentation for your platform and perform regular recovery checks for your environment before relying on any backup strategy.

More advanced methods for backup such as mysqldump and xtrabackup can also be used to backup the database; please see relevent documentation for further details.

