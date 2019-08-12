#
# MySQL Dockerfile
#
#FROM mysql:latest
FROM mysql:5.7

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_DATABASE_USER
ARG MYSQL_DATABASE_PASSWORD

ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_USER=$MYSQL_DATABASE_USER
ENV MYSQL_PASSWORD=$MYSQL_DATABASE_PASSWORD

ADD ./db_seed.sql /docker-entrypoint-initdb.d/db_seed.sql

#RUN echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf
RUN sed -i -e"s/.*bind-address.*=.*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
#RUN sleep 30 && mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_DB}. * TO ${MYSQL_DATABASE_USER}"

# Port 3306 on host and MySQL Port in container
EXPOSE 3306:3306
