package com.lauvan.analysis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @describe 物资统计控制类
 * @author 陈存登
 * @version 1.0 11-12-2015
 */
@RequestMapping("/analysis/suppliesAnalysis")
@Controller
public class SuppliesAnalysisController {
    
	@RequestMapping("/main")
	public String main(){
		return "jsp/analysis/suppliesAnalysis/suppliesAnalysis_main";
	}
	
}


