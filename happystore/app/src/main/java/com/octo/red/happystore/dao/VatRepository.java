package com.octo.red.happystore.dao;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.model.VAT;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface VatRepository extends CrudRepository<VAT, Long>, JpaSpecificationExecutor<VAT> {

    @Timed
    @Query("select v from Product p inner join p.categoryFamily as cf inner join cf.vats as v where v.country.alpha3Code = :countryCode and p.id = :productId")
    public VAT findOneByCountryCodeAndProductId(@Param("countryCode") String countryCode, @Param("productId") Long productId);
}
