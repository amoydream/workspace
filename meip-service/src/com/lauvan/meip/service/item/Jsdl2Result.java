package com.lauvan.meip.service.item;

import java.util.List;

public class Jsdl2Result extends Result {
	private static final long	serialVersionUID	= 1L;
	private Jsdl2Item			item;
	private List<Jsdl2Item>		items;

	public Jsdl2Item getItem() {
		return item;
	}

	public void setItem(Jsdl2Item item) {
		this.item = item;
	}

	public List<Jsdl2Item> getItems() {
		return items;
	}

	public void setItems(List<Jsdl2Item> items) {
		this.items = items;
	}
}