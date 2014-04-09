package com.octo.red.happystore.dao;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.model.SaleOperation;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface SaleOperationRepository extends CrudRepository<SaleOperation, Long>, JpaSpecificationExecutor<SaleOperation> {

    @Timed
    @Query("select SUM(op.amount), op.currency from SaleOperation op where op.groupId=:groupId and op.date >= :date group by op.currency order by SUM(op.amount) desc")
    public List<Object[]> aggregateAmount(@Param("groupId") int groupId, @Param("date") Date date);
}
