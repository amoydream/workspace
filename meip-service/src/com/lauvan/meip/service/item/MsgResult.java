package com.lauvan.meip.service.item;

import java.util.List;

public class MsgResult extends Result {
	private static final long	serialVersionUID	= 1L;
	private MsgItem				item;
	private List<MsgItem>		items;

	public MsgItem getItem() {
		return item;
	}

	public void setItem(MsgItem item) {
		this.item = item;
	}

	public List<MsgItem> getItems() {
		return items;
	}

	public void setItems(List<MsgItem> items) {
		this.items = items;
	}
}