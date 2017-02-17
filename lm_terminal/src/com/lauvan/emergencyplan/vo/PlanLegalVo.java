package com.lauvan.emergencyplan.vo;

public class PlanLegalVo {
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 法律法规ID
	 */
	private Integer le_id;
	
	/**
	 * 法律法规标题
	 */
	private String le_Name;

	public PlanLegalVo() {
		super();
	}

	public PlanLegalVo(Integer pi_id, Integer le_id, String le_Name) {
		super();
		this.pi_id = pi_id;
		this.le_id = le_id;
		this.le_Name = le_Name;
	}

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}

	public Integer getLe_id() {
		return le_id;
	}

	public void setLe_id(Integer le_id) {
		this.le_id = le_id;
	}

	public String getLe_Name() {
		return le_Name;
	}

	public void setLe_Name(String le_Name) {
		this.le_Name = le_Name;
	}
}
