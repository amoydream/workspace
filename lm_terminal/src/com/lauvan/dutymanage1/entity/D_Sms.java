package com.lauvan.dutymanage1.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.system.entity.T_User_Info;

@Entity
@Table(name = "D_Sms")
@DynamicInsert(true)
@DynamicUpdate(true)
public class D_Sms implements Serializable{

	private static final long serialVersionUID = 7821611936906955185L;
	private Integer sms_id;
	/**
	 * 发送号码
	 */
	private String sms_sendNo;
	/**
	 * 接受号码
	 */
	private String sms_acceptNo;
	/**
	 * 内容
	 */
	private String sms_content;
	/**
	 * 回复内容
	 */
	private String sms_replyContent;
	
	/**
	 * 状态（正在发送0，发送成功1，发送失败3）
	 */
	private String sms_state = "0";
	/**
	 * 类型（个人短信1，群发短信2，定时短信3）
	 */
	private String sms_type;
	/**
	 * 发送时间
	 */
	private Date sms_date;
	/**
	 * 定时发送
	 */
	private Date sms_timingDate;
	/**
	 * 备注
	 */
	private String sms_remark;
	
	private T_User_Info user;
	/**
	 * 是否设为模板（是1，否0）
	 */
	private String sms_temp="0";
	
	@Id
	public Integer getSms_id() {
		return sms_id;
	}
	public void setSms_id(Integer sms_id) {
		this.sms_id = sms_id;
	}
	@Column(length = 1000)
	public String getSms_sendNo() {
		return sms_sendNo;
	}
	public void setSms_sendNo(String sms_sendNo) {
		this.sms_sendNo = sms_sendNo;
	}
	@Column(length = 1000)
	public String getSms_acceptNo() {
		return sms_acceptNo;
	}
	public void setSms_acceptNo(String sms_acceptNo) {
		this.sms_acceptNo = sms_acceptNo;
	}
	@Column(length = 200)
	public String getSms_content() {
		return sms_content;
	}
	public void setSms_content(String sms_content) {
		this.sms_content = sms_content;
	}
	@Column(length = 1)
	public String getSms_state() {
		return sms_state;
	}
	public void setSms_state(String sms_state) {
		this.sms_state = sms_state;
	}
	public Date getSms_date() {
		return sms_date;
	}
	public void setSms_date(Date sms_date) {
		this.sms_date = sms_date;
	}
	@Column(length = 100)
	public String getSms_remark() {
		return sms_remark;
	}
	public void setSms_remark(String sms_remark) {
		this.sms_remark = sms_remark;
	}
	public Date getSms_timingDate() {
		return sms_timingDate;
	}
	public void setSms_timingDate(Date sms_timingDate) {
		this.sms_timingDate = sms_timingDate;
	}
	@Column(length = 100)
	public String getSms_replyContent() {
		return sms_replyContent;
	}
	public void setSms_replyContent(String sms_replyContent) {
		this.sms_replyContent = sms_replyContent;
	}
	@Column(length = 1)
	public String getSms_type() {
		return sms_type;
	}
	public void setSms_type(String sms_type) {
		this.sms_type = sms_type;
	}
	@ManyToOne
	@JoinColumn(name="user_id")
	public T_User_Info getUser() {
		return user;
	}
	public void setUser(T_User_Info user) {
		this.user = user;
	}
	public String getSms_temp() {
		return sms_temp;
	}
	public void setSms_temp(String sms_temp) {
		this.sms_temp = sms_temp;
	}
}
