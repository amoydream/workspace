package com.lauvan.analysis.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.analysis.vo.EchartData;
import com.lauvan.analysis.vo.EchartData2;
import com.lauvan.analysis.vo.Series;
import com.lauvan.event.service.EventInfoService;

/**
 * @describe 事务统计分析控制类
 * @author 钮炜炜
 * @version 1.0 10-12-2015
 */
@Controller
@RequestMapping("analysis/eventAnalysis")
public class EventAnalysisController {
    @Autowired
	private EventInfoService eventInfoService;
    @RequestMapping("/main")
	public String main(){
		return "jsp/analysis/eventAnalysis/eventAnalysis_main"; 
	}
    /**
	 * 按年统计事件数
	 * @return
	 */
    @RequestMapping("/year")
	public String year(){
		return "jsp/analysis/eventAnalysis/eventAnalysis_year"; 
	}
    /**
     * 按月统计事件数
     * @return
     */
    @RequestMapping("/month")
    public String month(){
    	return "jsp/analysis/eventAnalysis/eventAnalysis_month"; 
    }
	/**
	 * 按年统计事件数
	 * @return
	 */
	@RequestMapping("/listYear")
	@ResponseBody
	public EchartData listYear(){
		List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"事件年度事故数统计"}));//数据分组
		List<String> category = new ArrayList<String>();//横坐标
		List<Series> series = new ArrayList<Series>();//纵坐标
		List<Integer> data = new ArrayList<Integer>();
		List<Object> list = eventInfoService.year();
		for (int i = 0,h=list.size(); i < h; i++) {
			Object[] obj = (Object[]) list.get(i);
			category.add(((Integer)obj[0]).toString());
			data.add(((BigInteger)obj[1]).intValue());
		}
		series.add(new Series("事件年度事故数统计", "bar", data));
		EchartData echartData = new EchartData(legend, category, series);
		return echartData;
	}
	/**
	 * 按月统计事件数
	 * @return
	 */
	@RequestMapping("/listMonth")
	@ResponseBody
	public EchartData2 listMonth(){
		List<String> legend = new ArrayList<>();//数据分组
		List<Integer> category = new ArrayList<>();//横坐标
		List<Series> series = new ArrayList<Series>();//纵坐标
		List<Integer> data = null;
		List<Object> list = eventInfoService.month();
		for (int i = 0,h=list.size(); i < h; i++) {
			Object[] obj = (Object[]) list.get(i);
			legend.add(((Integer)obj[0]).toString());
			category.add((Integer)obj[1]);
			//data.add(((BigInteger)obj[2]).intValue());
		}
		legend = new ArrayList<>(new HashSet<>(legend));
		Collections.sort(legend);
		
		category = new ArrayList<>(new HashSet<>(category));
		Collections.sort(category);
		
		for (String y : legend) {
			data = new ArrayList<Integer>();
			for (Integer c : category) {
				boolean cf = false;
				for (int i = 0,h=list.size(); i < h; i++) {
					Object[] obj = (Object[]) list.get(i);
					String year = ((Integer)obj[0]).toString();
					Integer month = (Integer)obj[1];
					if (year.equals(y) && c.equals(month)) {
						data.add(((BigInteger)obj[2]).intValue());
						cf = false;
						break;
					}
					cf = true;
				}
				if (cf) {
					data.add(0);
				}
			}
			series.add(new Series(y, "bar", data,"总数"));
		}
		EchartData2 echartData = new EchartData2(legend, category, series);
        return echartData;
	}
	/**
	 * 按事件级别统计事件数
	 * @return
	 */
    @RequestMapping("/level")
	public String level(){
		return "jsp/analysis/eventAnalysis/eventAnalysis_level"; 
	}
    @RequestMapping("/listLevel")
    @ResponseBody
    public EchartData listLevel() {
    	List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"Ⅰ级事件(特别重大)","Ⅱ级事件(重大)","Ⅲ级事件(较大)","Ⅳ级事件(一般)","Ⅳ级以下事件"}));
    	List<String> category = new ArrayList<String>();//横坐标
    	List<Series> series = new ArrayList<Series>();//纵坐标
    	
    	List<Object> list = eventInfoService.getListLevels();
    	List<Integer> listYears = new ArrayList<>();
    	for (int i = 0,h=list.size(); i < h; i++) {
			Object[] obj = (Object[]) list.get(i);
			listYears.add((Integer)obj[0]);
		}
    	listYears = new ArrayList<>(new HashSet<>(listYears));
    	for (Integer m : listYears) {
			category.add(m.toString());
		}
    	List<Integer> data1 = new ArrayList<Integer>();
    	for (String s : category) {
    		int total = 0;
    		for (int i = 0,h=list.size(); i < h; i++) {
    			Object[] obj = (Object[]) list.get(i);
    			//System.out.println(((Integer)obj[0]).toString().equals(s));
    			if (((Integer)obj[0]).toString().equals(s)) {
					if (obj[1]!=null && ((String)obj[1]).equals("1")) {
						total = ((BigInteger)obj[2]).intValue();
						break;
					}
				}
    		}
    		data1.add(total);
		}
    	series.add(new Series("Ⅰ级事件(特别重大)", "line", data1, "总数"));
    	List<Integer> data2 = new ArrayList<Integer>();
    	for (String s : category) {
    		int total = 0;
    		for (int i = 0,h=list.size(); i < h; i++) {
    			Object[] obj = (Object[]) list.get(i);
    			if (((Integer)obj[0]).toString().equals(s)) {
    				if (obj[1]!=null && ((String)obj[1]).equals("2")) {
    					total = ((BigInteger)obj[2]).intValue();
    					break;
    				}
    			}
    		}
    		data2.add(total);
    	}
    	series.add(new Series("Ⅱ级事件(重大)", "line", data2, "总数"));
    	List<Integer> data3 = new ArrayList<Integer>();
    	for (String s : category) {
    		int total = 0;
    		for (int i = 0,h=list.size(); i < h; i++) {
    			Object[] obj = (Object[]) list.get(i);
    			if (((Integer)obj[0]).toString().equals(s)) {
    				if (obj[1]!=null && ((String)obj[1]).equals("3")) {
    					total = ((BigInteger)obj[2]).intValue();
    					break;
    				}
    			}
    		}
    		data3.add(total);
    	}
    	series.add(new Series("Ⅲ级事件(较大)", "line", data3, "总数"));
    	List<Integer> data4 = new ArrayList<Integer>();
    	for (String s : category) {
    		int total = 0;
    		for (int i = 0,h=list.size(); i < h; i++) {
    			Object[] obj = (Object[]) list.get(i);
    			if (((Integer)obj[0]).toString().equals(s)) {
    				if (obj[1]!=null && ((String)obj[1]).equals("4")) {
    					total = ((BigInteger)obj[2]).intValue();
    					break;
    				}
    			}
    		}
    		data4.add(total);
    	}
    	series.add(new Series("Ⅳ级事件(一般)", "line", data4, "总数"));
    	List<Integer> data5 = new ArrayList<Integer>();
    	for (String s : category) {
    		int total = 0;
    		for (int i = 0,h=list.size(); i < h; i++) {
    			Object[] obj = (Object[]) list.get(i);
    			if (((Integer)obj[0]).toString().equals(s)) {
    				if (obj[1]!=null && ((String)obj[1]).equals("5")) {
    					total = ((BigInteger)obj[2]).intValue();
    					break;
    				}
    			}
    		}
    		data5.add(total);
    	}
    	series.add(new Series("Ⅳ级以下事件", "line", data5, "总数"));
    	EchartData echartData = new EchartData(legend, category, series);
    	return echartData;
	}
    
    /**
	 * 按事件区域统计事件数
	 * @return
	 */
    @RequestMapping("/town")
	public String town(){
		return "jsp/analysis/eventAnalysis/eventAnalysis_town"; 
	}
    @RequestMapping("/listTown")
    @ResponseBody
    public EchartData listTown(){
    	List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"事件区域事故数统计"}));//数据分组
		List<String> category = new ArrayList<String>();//横坐标
		List<Series> series = new ArrayList<Series>();//纵坐标
		List<Integer> data = new ArrayList<Integer>();
		List<Object> list = eventInfoService.town();
		for (int i = 0,h=list.size(); i < h; i++) {
			Object[] obj = (Object[]) list.get(i);
			if (obj[0]!=null) {
				category.add((String)obj[0]);
				data.add(((BigInteger)obj[1]).intValue());
			}
		}
		series.add(new Series("事件区域事故数统计", "bar", data));
		EchartData echartData = new EchartData(legend, category, series);
		return echartData;
    }
}
