package com.it.lylj.tetController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class testController {
	private static final Logger logger = LoggerFactory.getLogger(testController.class);

	@RequestMapping("/index")
	public void test() {
		logger.info("test 화면 보여주기");
		
	}
	
	@RequestMapping("/electronic/electronicMain")
	public void test_2() {
		logger.info("test 화면 보여주기");
		
	}


}
