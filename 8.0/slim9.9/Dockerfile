ARG  MYSQL_VER=8.0
FROM mysql:${MYSQL_VER}

LABEL maintainerName="Raphael Guzman" \
      maintainerEmail="raphael.h.guzman@gmail.com" \
      maintainerCompany="DataJoint"
      
ADD my.cnf /etc/mysql/my.cnf

HEALTHCHECK       \
    --timeout=20s \ 
    --retries=20  \
    CMD           \
        mysql --protocol TCP -u"root" -p"$MYSQL_ROOT_PASSWORD" -e "show databases;"
