package com.octo.red.happystore.dao;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.model.Stock;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StockRepository extends CrudRepository<Stock, Long>, JpaSpecificationExecutor<Stock> {

    @Timed
    @Query("select s from Stock s where s.store.id = :storeId and s.product.id = :productId")
    public Stock findOneByStoreAndProductId(@Param("storeId") Long storeId, @Param("productId") Long productId);

    @Timed
    @Query("SELECT cat.label, cat.groupid, p.productLabel, stock.quantity FROM Stock stock INNER JOIN Stock.store as store INNER JOIN Stock.product as p INNER JOIN p.categoryFamily as cat WHERE store.id = :storeId")
    public List<Object[]> getAllProductsByStoreId(@Param("storeId") Long storeId);
}
