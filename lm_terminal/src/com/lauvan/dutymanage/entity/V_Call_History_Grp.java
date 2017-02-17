package com.lauvan.dutymanage.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

//@Entity
//@Table(name = "v_call_history_grp")
public class V_Call_History_Grp implements Serializable {
	private static final long	serialVersionUID	= -5838224480276851808L;
	private Integer				vo_id;
	private V_Call_History		callHistory;

	@Id
	public Integer getVo_id() {
		return vo_id;
	}

	public void setVo_id(Integer vo_id) {
		this.vo_id = vo_id;
	}

	@OneToOne
	@JoinColumn(name = "vo_id")
	public V_Call_History getCallHistory() {
		return callHistory;
	}

	public void setCallHistory(V_Call_History callHistory) {
		this.callHistory = callHistory;
	}
}
