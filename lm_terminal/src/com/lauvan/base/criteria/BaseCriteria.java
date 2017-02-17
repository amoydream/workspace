package com.lauvan.base.criteria;

import org.springframework.beans.BeanUtils;

public abstract class BaseCriteria<C, E> {
	private int		page;
	private int		rows;
	private E		entity;
	private boolean	likeEnabled	= true;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public BaseCriteria(E entity) {
		this.entity = entity;
	}

	public E getEntity() {
		return entity;
	}

	public void setEntity(E entity) {
		this.entity = entity;
	}

	public int getFirstResult() {
		return (page - 1) * rows;
	}

	public boolean isLikeEnabled() {
		return likeEnabled;
	}

	public void setLikeEnabled(boolean likeEnabled) {
		this.likeEnabled = likeEnabled;
	}

	@SuppressWarnings("unchecked")
	public C copyProperties(Object obj) {
		if(obj != null) {
			BeanUtils.copyProperties(obj, this);
			BeanUtils.copyProperties(obj, this.entity);
		}

		return (C)this;
	}
}