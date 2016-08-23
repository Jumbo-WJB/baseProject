package com.base.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.service.HomeService;
import com.github.pagehelper.PageHelper;

@Controller
@RequestMapping(value="/home")
public class HomeController {
	 private static final Logger LOG = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private HomeService homeService;
    @RequestMapping(value="index")
	public String index(){
      System.out.println(">>>>>>show");
      LOG.info("in to log{},log info:{}","YES","showindex");
      PageHelper.startPage(1, 3);
      homeService.showindexs();
       return "ok";	
    }
}
