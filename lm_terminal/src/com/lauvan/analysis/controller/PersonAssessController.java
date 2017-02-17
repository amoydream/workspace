package com.lauvan.analysis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @describe 值班人员考核控制类
 * @author 陈存登
 * @version 1.0 10-12-2015
 */
@RequestMapping("/analysis/personassess")
@Controller
public class PersonAssessController {
	
	@RequestMapping("/main")
	public String main(){
	  return "jsp/analysis/personAssess/personAssess_main";	
	}
	
}


