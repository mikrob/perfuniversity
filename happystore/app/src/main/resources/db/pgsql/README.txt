sudo -i -u postgres
postgres@mbo-VirtualBox:~$ createuser -P happystore
Enter password for new role: happystore
Enter it again: happystore
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) y
Shall the new role be allowed to create more new roles? (y/n) y
createdb -O happystore -E UTF8 happystore
exit
#Password authentication is not allowed by default on peer connection, use socket
vim /etc/postgresql/9.1/main/pg_hba.conf
#Uncomment IPv4 local connections: to enable connecting with a different user with passwords
#host    all             all             127.0.0.1/32            md5

psql -h localhost -U happystore -f src/main/resources/db/pgsql/drop-schema.sql
psql -h localhost -U happystore -f src/main/resources/db/pgsql/schema.sql
psql -h localhost -U happystore -f src/main/resources/db/pgsql/test-data.sql
psql -h localhost -U happystore -f src/main/resources/db/pgsql/import.sql
psql -h localhost -U happystore

echo "dataSource.driverClassName=org.postgresql.Driver"      >> /etc/happystore/overrides.properties
echo "dataSource.url=jdbc:postgresql://localhost/happystore" >> /etc/happystore/overrides.properties
echo "dataSource.username=happystore"                        >> /etc/happystore/overrides.properties
echo "dataSource.password=happystore"                        >> /etc/happystore/overrides.properties
echo "dataSource.dialect=org.hibernate.dialect.PostgreSQLDialect" >> /etc/happystore/overrides.properties
echo "initialize-database.enabled=false" >> /etc/happystore/overrides.properties


#psql client
#\q for quit
#\d <tablename> to describe

#For backup
#sudo su postgres
#pgdump_all | gzip > /opt/postgresql/9.1/backup/happystore_bck_201401041530.gz
# for restore
#createdb -O happystore -E UTF8 happystore
#psql -h localhost -U happystore -f /opt/postgresql/9.1/backup/happystore_bck_201401041530

#For Benerator
sudo -i -u postgres
createdb -O happystore -E UTF8 benerator
psql -h localhost -d benerator -U happystore -f src/main/resources/db/pgsql/drop-schema.sql
psql -h localhost -d benerator -U happystore -f src/main/resources/db/pgsql/schema.sql