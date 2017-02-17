package com.lauvan.meip.service.item;

import java.util.List;

public class YfsdlResult extends Result {
	private static final long	serialVersionUID	= 1L;
	private YfsdlItem			item;
	private List<YfsdlItem>		items;

	public YfsdlItem getItem() {
		return item;
	}

	public void setItem(YfsdlItem item) {
		this.item = item;
	}

	public List<YfsdlItem> getItems() {
		return items;
	}

	public void setItems(List<YfsdlItem> items) {
		this.items = items;
	}
}