package com.lauvan.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 
 * ClassName: E_EventReport 
 * @Description: 专报
 * @author 钮炜炜
 * @date 2016年4月12日 上午9:58:37
 */
public class EventReportVo {

	private Integer er_id;
	private Integer ev_id;
	/**
	 * 编号年
	 */
	private String er_noyear;
	/**
	 * 编号
	 */
	private String er_no;
	/**
	 * 报告时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date er_date;
	/**
	 * 报告单位
	 */
	private String er_unit;
	/**
	 * 上报单位
	 */
	private String er_reportUnit;
	/**
	 * 签发人
	 */
	private String er_issuer;
	/**
	 * 签发单位
	 */
	private String er_issueUnit;
	/**
	 * 签发日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date er_issueDate;
	/**
	 * 主送
	 */
	private String er_mainSupply;
	/**
	 * 抄送
	 */
	private String er_copySupply;
	/**
	 * 联系人
	 */
	private String er_contact;
	/**
	 * 联系电话
	 */
	private String er_contactPhone;
	
	public Integer getEr_id() {
		return er_id;
	}

	public void setEr_id(Integer er_id) {
		this.er_id = er_id;
	}

	public Integer getEv_id() {
		return ev_id;
	}

	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}

	public String getEr_noyear() {
		return er_noyear;
	}

	public void setEr_noyear(String er_noyear) {
		this.er_noyear = er_noyear;
	}

	public String getEr_no() {
		return er_no;
	}

	public void setEr_no(String er_no) {
		this.er_no = er_no;
	}

	public Date getEr_date() {
		return er_date;
	}

	public void setEr_date(Date er_date) {
		this.er_date = er_date;
	}

	public String getEr_unit() {
		return er_unit;
	}

	public void setEr_unit(String er_unit) {
		this.er_unit = er_unit;
	}

	public String getEr_reportUnit() {
		return er_reportUnit;
	}

	public void setEr_reportUnit(String er_reportUnit) {
		this.er_reportUnit = er_reportUnit;
	}

	public String getEr_issuer() {
		return er_issuer;
	}

	public void setEr_issuer(String er_issuer) {
		this.er_issuer = er_issuer;
	}

	public String getEr_issueUnit() {
		return er_issueUnit;
	}

	public void setEr_issueUnit(String er_issueUnit) {
		this.er_issueUnit = er_issueUnit;
	}

	public Date getEr_issueDate() {
		return er_issueDate;
	}

	public void setEr_issueDate(Date er_issueDate) {
		this.er_issueDate = er_issueDate;
	}

	public String getEr_mainSupply() {
		return er_mainSupply;
	}

	public void setEr_mainSupply(String er_mainSupply) {
		this.er_mainSupply = er_mainSupply;
	}

	public String getEr_copySupply() {
		return er_copySupply;
	}

	public void setEr_copySupply(String er_copySupply) {
		this.er_copySupply = er_copySupply;
	}

	public String getEr_contact() {
		return er_contact;
	}

	public void setEr_contact(String er_contact) {
		this.er_contact = er_contact;
	}

	public String getEr_contactPhone() {
		return er_contactPhone;
	}

	public void setEr_contactPhone(String er_contactPhone) {
		this.er_contactPhone = er_contactPhone;
	}

}
