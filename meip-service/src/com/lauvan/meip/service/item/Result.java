package com.lauvan.meip.service.item;

import java.io.Serializable;

public class Result
	implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private boolean				success				= true;
	private String				msg;
	private Integer				total;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}
}