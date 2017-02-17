package com.lauvan.meip.service.item;

public class Item
	implements ItemInteface {
	private static final long	serialVersionUID	= 1L;
	private Integer				currentPage;
	private Integer				firstResult;
	private Integer				maxResults;

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getFirstResult() {
		return firstResult;
	}

	public void setFirstResult(Integer firstResult) {
		this.firstResult = firstResult;
	}

	public Integer getMaxResults() {
		return maxResults;
	}

	public void setMaxResults(Integer maxResults) {
		this.maxResults = maxResults;
	}
}