package com.lauvan.analysis.vo;

import java.util.List;

public class Series {
	private String name;  
    
	private String type;  
    
	private List<Integer> data;//这里要用int 不能用String 不然前台显示不正常（特别是在做数学运算的时候）  
    
    private String stack;

	public Series() {
		super();
	}

	public Series(String name, String type, List<Integer> data) {
		super();
		this.name = name;
		this.type = type;
		this.data = data;
	}

	public Series(String name, String type, List<Integer> data, String stack) {
		super();
		this.name = name;
		this.type = type;
		this.data = data;
		this.stack = stack;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<Integer> getData() {
		return data;
	}

	public void setData(List<Integer> data) {
		this.data = data;
	}

	public String getStack() {
		return stack;
	}

	public void setStack(String stack) {
		this.stack = stack;
	}
}
