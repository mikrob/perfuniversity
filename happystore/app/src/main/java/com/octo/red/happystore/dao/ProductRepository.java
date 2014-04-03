package com.octo.red.happystore.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;

import com.octo.red.happystore.model.Product;

public interface ProductRepository  extends CrudRepository<Product, Long>, JpaSpecificationExecutor<Product> {

}
