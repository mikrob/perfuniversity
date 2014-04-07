TO extract groups_big.csv
select groupid from (select distinct groupid from SaleOperation) as dg order by random() limit 100000;

To extract products_big.csv
select it.countryCode, it.productId, st.store_id as storeId
from
(
select c.alpha3Code as countryCode, p.id as productId, count(vat.id) cpt
from Product p
inner join CategoryFamily cf on p.categoryFamily_id=cf.id
inner join CategoryFamily_VAT cfv on cf.id=cfv.categoryFamily_id
inner join VAT vat on cfv.vats_id=vat.id
inner join Country c on c.alpha3Code=vat.country_alpha3Code
group by countryCode, productId
having count(vat.id)=1
) as it,
(
select stock.product_id as productId, stock.store_id, count(stock.id)
from
Stock
group by stock.product_id, stock.store_id
having count(stock.id) = 1
) as st
where it.productId=st.productId
order by random() limit 1000;


58 line of stocks out of 10016 have several lines for a given product.