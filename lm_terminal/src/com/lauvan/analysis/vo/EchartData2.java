package com.lauvan.analysis.vo;

import java.util.ArrayList;
import java.util.List;

public class EchartData2 {
	/**
	 * 数据分组  
	 */
	public List<String> legend = new ArrayList<String>();
	/**
	 * 横坐标  
	 */
    public List<Integer> category = new ArrayList<Integer>();
    /**
     * 纵坐标 
     */
    public List<Series> series = new ArrayList<Series>();
    
	public EchartData2() {
		super();
	}
	public EchartData2(List<String> legend, List<Integer> category,
			List<Series> series) {
		super();
		this.legend = legend;
		this.category = category;
		this.series = series;
	}
	public List<String> getLegend() {
		return legend;
	}
	public void setLegend(List<String> legend) {
		this.legend = legend;
	}
	public List<Integer> getCategory() {
		return category;
	}
	public void setCategory(List<Integer> category) {
		this.category = category;
	}
	public List<Series> getSeries() {
		return series;
	}
	public void setSeries(List<Series> series) {
		this.series = series;
	}
}
