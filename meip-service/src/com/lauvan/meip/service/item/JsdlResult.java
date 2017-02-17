package com.lauvan.meip.service.item;

import java.util.List;

public class JsdlResult extends Result {
	private static final long	serialVersionUID	= 1L;
	private JsdlItem			item;
	private List<JsdlItem>		items;

	public JsdlItem getItem() {
		return item;
	}

	public void setItem(JsdlItem item) {
		this.item = item;
	}

	public List<JsdlItem> getItems() {
		return items;
	}

	public void setItems(List<JsdlItem> items) {
		this.items = items;
	}
}