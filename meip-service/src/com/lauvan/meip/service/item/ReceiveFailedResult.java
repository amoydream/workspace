package com.lauvan.meip.service.item;

import java.util.List;

public class ReceiveFailedResult extends Result {
	private static final long		serialVersionUID	= 1L;
	private ReceiveFailedItem		item;
	private List<ReceiveFailedItem>	items;

	public ReceiveFailedItem getItem() {
		return item;
	}

	public void setItem(ReceiveFailedItem item) {
		this.item = item;
	}

	public List<ReceiveFailedItem> getItems() {
		return items;
	}

	public void setItems(List<ReceiveFailedItem> items) {
		this.items = items;
	}
}