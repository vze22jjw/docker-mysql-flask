docker build -t sre-mysql --build-arg MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --build-arg MYSQL_DATABASE_PASSWORD=$MYSQL_DATABASE_PASSWORD \
--build-arg MYSQL_DATABASE_DB=$MYSQL_DATABASE_DB --build-arg MYSQL_DATABASE_HOST=$MYSQL_DATABASE_HOST .
#docker run --rm -e MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE_PASSWORD -e MYSQL_DATABASE_DB -e MYSQL_DATABASE_HOST --privileged=true --name sremysql

docker build -t mysqlsre --build-arg MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --build-arg MYSQL_DATABASE_PASSWORD=$MYSQL_DATABASE_PASSWORD --build-arg MYSQL_DATABASE_USER=$MYSQL_DATABASE_USER .

docker run --rm --privileged=true --name sre-mysql

docker run --rm --name=sre-mysql -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE_PASSWORD=$MYSQL_DATABASE_PASSWORD -e MYSQL_DATABASE_DB=$MYSQL_DATABASE_DB -e MYSQL_DATABASE_HOST=$MYSQL_DATABASE_HOST

#############
docker pull mysql/mysql-server:latest

export MYSQL_ROOT_PASSWORD=$(docker logs mysqlsre 2>&1 | grep GENERATED | awk -F: '{ print $2 }' )

docker exec -it mysqlsre mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE ${MYSQL_DATABASE_DB}" && \
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${MYSQL_DATABASE_USER}'@'localhost' IDENTIFIED BY '${MYSQL_DATABASE_PASSWORD}' " && \
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_DB}. * TO '${MYSQL_DATABASE_USER}'@'localhost' "  && \
mysql -u root -p${MYSQL_ROOT_PASSWORD} -D ${MYSQL_DATABASE_DB} < ./db_seed.sql


## Run those boxes
docker run --rm -t -i --name=mysqlsre57 -p33060:3306 -d mysqlsre57
docker run --rm -t -i --name=pythonsre --link mysqlsre57 -p5000:5000 -d pythonsre

##Logs
docker logs mysqlsre57 2>&1
docker logs pythonsre 2>&1

##MySQL Connect
docker exec -it mysqlsre57 mysql -uroot -p
docker exec -it mysqlsre57 mysql -udbUser -p

##build those
docker build -t mysqlsre57 --build-arg MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --build-arg MYSQL_DATABASE_PASSWORD=$MYSQL_DATABASE_PASSWORD --build-arg MYSQL_DATABASE_USER=$MYSQL_DATABASE_USER --build-arg MYSQL_DATABASE_DB=$MYSQL_DATABASE_DB .

docker build -t pythonsre .
