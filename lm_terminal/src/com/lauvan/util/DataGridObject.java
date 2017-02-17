package com.lauvan.util;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class DataGridObject {

	private Long total = 0L;
	public List<Hashtable<String, Object>> rows = new ArrayList<Hashtable<String, Object>>();
	public DataGridObject() {
		super();
	}

	public DataGridObject(Long total, List<Hashtable<String, Object>> rows) {
		super();
		this.total = total;
		this.rows = rows;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List<Hashtable<String, Object>> getRows() {
		return rows;
	}

	public void setRows(List<Hashtable<String, Object>> rows) {
		this.rows = rows;
	}

}
