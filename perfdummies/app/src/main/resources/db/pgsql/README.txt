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
psql -h localhost -U happystore -f src/main/resources/db/pgsql/drop-schema.sql
psql -h localhost -U happystore -f src/main/resources/db/pgsql/schema.sql
psql -h localhost -U happystore -f src/main/resources/db/pgsql/test-data.sql
psql -h localhost -U happystore -f src/main/resources/db/pgsql/import_2.sql
psql -h localhost -U happystore

echo "dataSource.url=jdbc:postgresql://localhost/happystore" >> /etc/happystore/overrides.properties
echo "dataSource.username=happystore"                        >> /etc/happystore/overrides.properties
echo "dataSource.password=happystore"                        >> /etc/happystore/overrides.properties
echo "dataSource.dialect=org.hibernate.dialect.PostgreSQLDialect" >> /etc/happystore/overrides.properties
echo "initialize-database.enabled=false" >> /etc/happystore/overrides.properties


#psql client
#\q for quit
#\d <tablename> to describe



