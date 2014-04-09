package com.octo.red.happystore.services;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.dao.StockRepository;
import com.octo.red.happystore.model.InventoryRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InventoryService {

	@Autowired
	StockRepository stockRepository;

    @Timed
    public List<InventoryRecord> list(long storeId) {
        List<InventoryRecord> result = new ArrayList<InventoryRecord>();
		List<Object[]> lines = stockRepository.getAllProductsByStoreId(storeId);
		if(lines != null) {
			for(Object[] l : lines) {
				result.add(new InventoryRecord((String) l[0], (Integer) l[1], (String) l[2], (Integer) l[3]));
			}
		}
		return result;
	}
}