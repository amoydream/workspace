package com.lauvan.emergencyplan.vo;

public class EmeAddressBookVo{

	private Integer eab_id;
	/**
	 * 组织人员
	 */
	private Integer personId;
	/**
	 * 组织
	 */
	private Integer eoId;
	/**
	 * 通讯类型
	 */
	private String eab_type;
	/**
	 * 用户类型（1：个人，2：单位）
	 */
	private String eab_usertype;
	/**
	 * 排序
	 */
	private Integer eab_index;
	/**
	 * 通讯号码
	 */
	private String eab_number;
	/**
	 * 状态（0：启用，1：停用）
	 */
	private String eab_state;
	/**
	 * 备注
	 */
	private String eab_remark;
	
	private String organName;
	private String personName;
	public Integer getEab_id() {
		return eab_id;
	}
	public void setEab_id(Integer eab_id) {
		this.eab_id = eab_id;
	}
	public Integer getPersonId() {
		return personId;
	}
	public void setPersonId(Integer personId) {
		this.personId = personId;
	}
	public Integer getEoId() {
		return eoId;
	}
	public void setEoId(Integer eoId) {
		this.eoId = eoId;
	}
	public String getEab_type() {
		return eab_type;
	}
	public void setEab_type(String eab_type) {
		this.eab_type = eab_type;
	}
	public String getEab_usertype() {
		return eab_usertype;
	}
	public void setEab_usertype(String eab_usertype) {
		this.eab_usertype = eab_usertype;
	}
	public Integer getEab_index() {
		return eab_index;
	}
	public void setEab_index(Integer eab_index) {
		this.eab_index = eab_index;
	}
	public String getEab_number() {
		return eab_number;
	}
	public void setEab_number(String eab_number) {
		this.eab_number = eab_number;
	}
	public String getEab_state() {
		return eab_state;
	}
	public void setEab_state(String eab_state) {
		this.eab_state = eab_state;
	}
	public String getEab_remark() {
		return eab_remark;
	}
	public void setEab_remark(String eab_remark) {
		this.eab_remark = eab_remark;
	}
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
}
