package com.octo.red.happystore.controller;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.model.TurnoverVo;
import com.octo.red.happystore.services.TurnoverService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class TurnoverController {

	private static final Logger logger = LoggerFactory.getLogger(TurnoverController.class);
	
	@Autowired
	private TurnoverService turnoverService;

    @Timed
    @RequestMapping(value = "/turnover", method = RequestMethod.GET)
    public @ResponseBody List<TurnoverVo> getTurnover(@RequestParam("groupId") int groupId) {
		
		logger.info("Request received [groupId={}] on /turnover", groupId);

        return turnoverService.computeTurnover(groupId);
    }

}
