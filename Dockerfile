FROM mysql:5.7

MAINTAINER Raphael Guzman

ADD my.cnf /etc/mysql/my.cnf
ADD init.sql /docker-entrypoint-initdb.d/