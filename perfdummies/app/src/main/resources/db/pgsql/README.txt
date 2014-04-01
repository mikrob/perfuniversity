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

How original data were updated ?
--------------------------------
update SaleOperation set product_id=((id-1500) % 999) + 1500;
update SaleOperation set  saleTransaction_id = ((id-1500)/2) + 1500;
insert into categoryfamily_vat (categoryfamily_id, vats_id)
select id, ((id-1503)/4 + 2500) from categoryfamily where id not in (select categoryfamily_id from categoryfamily_vat);

Note to check the DB schema :
-----------------------------
select store.id, stock.id, product.id, categoryfamily.id, vat.id, country.alpha3code
from saleoperation
inner join product on saleoperation.product_id=product.id
inner join categoryfamily on categoryfamily.id=product.categoryfamily_id
inner join categoryfamily_vat on categoryfamily_vat.categoryfamily_id=categoryfamily.id
inner join vat on categoryfamily_vat.vats_id=vat.id
inner join country on vat.country_alpha3code=country.alpha3code
inner join stock on product.id=stock.product_id
inner join store on stock.store_id=store.id
where saleoperation.saleTransaction_id=1500;


select product.id
from saleoperation
inner join product on saleoperation.product_id=product.id
where saleoperation.saleTransaction_id=1500;
  id
------
 1500
 1501

select store.id as store, stock.id as stock, product.id as product, categoryfamily.id as categoryfamily, vat.id as vat, country.alpha3code as country
from product
left outer join categoryfamily on categoryfamily.id=product.categoryfamily_id
left outer join categoryfamily_vat on categoryfamily_vat.categoryfamily_id=categoryfamily.id
left outer join vat on categoryfamily_vat.vats_id=vat.id
left outer join country on vat.country_alpha3code=country.alpha3code
left outer join stock on product.id=stock.product_id
left outer join store on stock.store_id=store.id
where product.id in (1500, 1501);


select saletransaction.id as tx, saleoperation.id as op, store.id as store, stock.id as stock, product.id as product, categoryfamily.id as categoryfamily, vat.id as vat, country.alpha3code as country
from
saletransaction
left outer join saleoperation on saleoperation.saletransaction_id=saletransaction.id
left outer join product on product.id=saleoperation.product_id
left outer join categoryfamily on categoryfamily.id=product.categoryfamily_id
left outer join categoryfamily_vat on categoryfamily_vat.categoryfamily_id=categoryfamily.id
left outer join vat on categoryfamily_vat.vats_id=vat.id
left outer join country on vat.country_alpha3code=country.alpha3code
left outer join stock on product.id=stock.product_id
left outer join store on stock.store_id=store.id
where saletransaction.id=1500;


