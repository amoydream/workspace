package com.lauvan.meip.service.item;

import java.util.List;

public class StatuReportResult extends Result {
	private static final long		serialVersionUID	= 1L;
	private StatuReportItem			item;
	private List<StatuReportItem>	items;

	public StatuReportItem getItem() {
		return item;
	}

	public void setItem(StatuReportItem item) {
		this.item = item;
	}

	public List<StatuReportItem> getItems() {
		return items;
	}

	public void setItems(List<StatuReportItem> items) {
		this.items = items;
	}
}