package com.lauvan.meip.service.item;

import java.util.List;

public class DfsdlResult extends Result {
	private static final long	serialVersionUID	= 1L;
	private DfsdlItem			item;
	private List<DfsdlItem>		items;

	public DfsdlItem getItem() {
		return item;
	}

	public void setItem(DfsdlItem item) {
		this.item = item;
	}

	public List<DfsdlItem> getItems() {
		return items;
	}

	public void setItems(List<DfsdlItem> items) {
		this.items = items;
	}
}