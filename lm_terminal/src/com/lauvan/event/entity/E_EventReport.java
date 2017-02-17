package com.lauvan.event.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.system.entity.T_User_Info;
/**
 * 
 * ClassName: E_EventReport 
 * @Description: 专报
 * @author 钮炜炜
 * @date 2016年4月12日 上午9:58:37
 */
@Entity
@Table(name = "e_eventreport")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_EventReport implements Serializable{

	private static final long serialVersionUID = -2834449816779409111L;
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
	
	private T_User_Info user;
	private Date er_createDate = new Date();
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
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
	@Column(length=10)
	public String getEr_noyear() {
		return er_noyear;
	}
	public void setEr_noyear(String er_noyear) {
		this.er_noyear = er_noyear;
	}
	@Column(length=5)
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
	@Column(length=100)
	public String getEr_unit() {
		return er_unit;
	}
	public void setEr_unit(String er_unit) {
		this.er_unit = er_unit;
	}
	@Column(length=100)
	public String getEr_reportUnit() {
		return er_reportUnit;
	}
	public void setEr_reportUnit(String er_reportUnit) {
		this.er_reportUnit = er_reportUnit;
	}
	@Column(length=10)
	public String getEr_issuer() {
		return er_issuer;
	}
	public void setEr_issuer(String er_issuer) {
		this.er_issuer = er_issuer;
	}
	@Column(length=100)
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
	@Column(length=100)
	public String getEr_mainSupply() {
		return er_mainSupply;
	}
	public void setEr_mainSupply(String er_mainSupply) {
		this.er_mainSupply = er_mainSupply;
	}
	@Column(length=100)
	public String getEr_copySupply() {
		return er_copySupply;
	}
	public void setEr_copySupply(String er_copySupply) {
		this.er_copySupply = er_copySupply;
	}
	@Column(length=10)
	public String getEr_contact() {
		return er_contact;
	}
	public void setEr_contact(String er_contact) {
		this.er_contact = er_contact;
	}
	@Column(length=15)
	public String getEr_contactPhone() {
		return er_contactPhone;
	}
	public void setEr_contactPhone(String er_contactPhone) {
		this.er_contactPhone = er_contactPhone;
	}
	@ManyToOne
	@JoinColumn(name = "user_id")
	public T_User_Info getUser() {
		return user;
	}
	public void setUser(T_User_Info user) {
		this.user = user;
	}
	public Date getEr_createDate() {
		return er_createDate;
	}
	public void setEr_createDate(Date er_createDate) {
		this.er_createDate = er_createDate;
	}
}
