\copy VAT from 'data/VAT.csv' DELIMITER ',' CSV;
\copy STORE  FROM 'data/Store.csv' DELIMITER ',' CSV;
\copy CATEGORYFAMILY FROM 'data/CategoryFamily.csv' DELIMITER ',' CSV;
\copy CATEGORYFAMILY_VAT FROM 'data/CategoryFamily_VAT.csv' DELIMITER ',' CSV;
\copy PRODUCT  FROM 'data/Product.csv' DELIMITER ',' CSV;
\copy STOCK  FROM 'data/Stock.csv' DELIMITER ',' CSV;
\copy SALETRANSACTION FROM 'data/SaleTransaction.csv' DELIMITER ',' CSV;
\copy SALEOPERATION FROM 'data/SaleOperation.csv' DELIMITER ',' CSV;

