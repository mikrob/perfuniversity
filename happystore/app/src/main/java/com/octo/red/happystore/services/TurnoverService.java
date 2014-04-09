package com.octo.red.happystore.services;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.dao.SaleOperationRepository;
import com.octo.red.happystore.model.TurnoverVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class TurnoverService {
	
	@Autowired
	private SaleOperationRepository saleOperationRepository;
	
	//For test purpose only
	private Date actualTestDate;
	
	void setActualTestDate(Date date) {
		actualTestDate = date;
	}
	
	/**
	 * Compute the turnover of the group for the previous month
     * @param groupId : turnover is grouped by id
     * @return : turnovers grouped by ids
     */
    @Timed
    public List<TurnoverVo> computeTurnover(int groupId) {
        Date actualDate = actualTestDate == null ? new Date() : actualTestDate;
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(actualDate);
		calendar.add(Calendar.YEAR, -4);
		Date minDate = calendar.getTime();
		List<Object[]> lines = saleOperationRepository.aggregateAmount(groupId, minDate);
		List<TurnoverVo> result = new ArrayList<TurnoverVo>(lines.size());
        for(Object[] l : lines) {
            result.add(new TurnoverVo(groupId, (BigDecimal)l[0], (String)l[1]));
        }
		return result;
	}
}
