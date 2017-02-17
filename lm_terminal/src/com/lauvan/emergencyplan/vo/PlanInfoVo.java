package com.lauvan.emergencyplan.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PlanInfoVo{
	private Integer pi_id;
	/**
	 * 预案名称
	 */
	private String pi_name;
	/**
	 * 所属机构
	 */
	private String pi_subOrgan;
	/**
	 * 发布机构
	 */
	private String pi_issOrgan;
	/**
	 * 编制机构
	 */
	private String pi_estOrgan;
	/**
	 * 审批机构
	 */
	private String pi_appOrgan;
	/**
	 * 版本号
	 */
	private Integer pi_no;
	/**
	 * 层级
	 */
	private String pi_level;
	/**
	 * 发布日期
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date pi_createDate;
	/**
	 * 说明
	 */
	private String pi_note;
	/**
	 * 描述
	 */
	private String pi_desc;
	/**
	 * 适用范围
	 */
	private String pi_scope;
	/**
	 * 备注
	 */
	private String pi_remark;
//	private Integer planTypeId;
	private Integer eventTypeId;
	private String pi_del;

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}

	public String getPi_name() {
		return pi_name;
	}

	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}

	public String getPi_subOrgan() {
		return pi_subOrgan;
	}

	public void setPi_subOrgan(String pi_subOrgan) {
		this.pi_subOrgan = pi_subOrgan;
	}

	public String getPi_issOrgan() {
		return pi_issOrgan;
	}

	public void setPi_issOrgan(String pi_issOrgan) {
		this.pi_issOrgan = pi_issOrgan;
	}

	public String getPi_estOrgan() {
		return pi_estOrgan;
	}

	public void setPi_estOrgan(String pi_estOrgan) {
		this.pi_estOrgan = pi_estOrgan;
	}

	public String getPi_appOrgan() {
		return pi_appOrgan;
	}

	public void setPi_appOrgan(String pi_appOrgan) {
		this.pi_appOrgan = pi_appOrgan;
	}

	public Integer getPi_no() {
		return pi_no;
	}

	public void setPi_no(Integer pi_no) {
		this.pi_no = pi_no;
	}

	public String getPi_level() {
		return pi_level;
	}

	public void setPi_level(String pi_level) {
		this.pi_level = pi_level;
	}

	public Date getPi_createDate() {
		return pi_createDate;
	}

	public void setPi_createDate(Date pi_createDate) {
		this.pi_createDate = pi_createDate;
	}

	public String getPi_note() {
		return pi_note;
	}

	public void setPi_note(String pi_note) {
		this.pi_note = pi_note;
	}

	public String getPi_desc() {
		return pi_desc;
	}

	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}

	public String getPi_scope() {
		return pi_scope;
	}

	public void setPi_scope(String pi_scope) {
		this.pi_scope = pi_scope;
	}

	public String getPi_remark() {
		return pi_remark;
	}

	public void setPi_remark(String pi_remark) {
		this.pi_remark = pi_remark;
	}

	public Integer getEventTypeId() {
		return eventTypeId;
	}

	public void setEventTypeId(Integer eventTypeId) {
		this.eventTypeId = eventTypeId;
	}

	public String getPi_del() {
		return pi_del;
	}

	public void setPi_del(String pi_del) {
		this.pi_del = pi_del;
	}
		
}
