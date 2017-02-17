package com.lauvan.event.entity;

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

import com.lauvan.organ.entity.C_Organ;
import com.lauvan.system.entity.T_User_Info;
/**
 * 
 * ClassName: T_EventInfo 
 * @Description: 日常事件信息
 * @author 钮炜炜
 * @date 2015年12月3日 下午4:55:37
 */
@Entity
@Table(name = "t_baseevent")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_BaseEvent implements Serializable{

	private static final long serialVersionUID = 3366298566953380328L;
	private Integer be_id;
	/**
	 * 事件名称
	 */
	private String be_name;
	/**
	 * 事件地点
	 */
	private String be_address;
	/**
	 * 事发时间
	 */
	private Date be_date;
	/**
	 * 接报时间
	 */
	private Date be_reportDate;
	/**
	 * 事件类型
	 */
	private T_Event_Type eventType;
	/**
	 * 事发单位
	 */
	private C_Organ organ;
	/**
	 * 接报方式
	 */
	private String be_reportMode;
	/**
	 * 报告人姓名
	 */
	private String be_reportName;
	/**
	 * 报告人电话 
	 */
	private String be_reportPhone;
	/**
	 * 事件基本情况
	 */
	private String be_basicSituation;
	/**
	 * 记录人
	 */
	private T_User_Info user;
	/**
	 * 记录时间
	 */
	private Date be_createDate = new Date();
	
	/**
	 * 事件状态(1:新登记2：处置中4：完成)
	 */
	private String be_status = "1";
	
	private String be_del;
	
	@Id
	public Integer getBe_id() {
		return be_id;
	}
	public void setBe_id(Integer be_id) {
		this.be_id = be_id;
	}
	@Column(length=100,nullable=false)
	public String getBe_name() {
		return be_name;
	}
	public void setBe_name(String be_name) {
		this.be_name = be_name;
	}
	@Column(length=100,nullable=false)
	public String getBe_address() {
		return be_address;
	}
	public void setBe_address(String be_address) {
		this.be_address = be_address;
	}
	public Date getBe_date() {
		return be_date;
	}
	public void setBe_date(Date be_date) {
		this.be_date = be_date;
	}
	public Date getBe_reportDate() {
		return be_reportDate;
	}
	public void setBe_reportDate(Date be_reportDate) {
		this.be_reportDate = be_reportDate;
	}
	@ManyToOne
	@JoinColumn(name = "et_id")
	public T_Event_Type getEventType() {
		return eventType;
	}
	public void setEventType(T_Event_Type eventType) {
		this.eventType = eventType;
	}
	@ManyToOne
	@JoinColumn(name = "or_id")
	public C_Organ getOrgan() {
		return organ;
	}
	public void setOrgan(C_Organ organ) {
		this.organ = organ;
	}
	@Column(length=1,nullable=false)
	public String getBe_reportMode() {
		return be_reportMode;
	}
	public void setBe_reportMode(String be_reportMode) {
		this.be_reportMode = be_reportMode;
	}
	@Column(length=10,nullable=false)
	public String getBe_reportName() {
		return be_reportName;
	}
	public void setBe_reportName(String be_reportName) {
		this.be_reportName = be_reportName;
	}
	@Column(length=12,nullable=false)
	public String getBe_reportPhone() {
		return be_reportPhone;
	}
	public void setBe_reportPhone(String be_reportPhone) {
		this.be_reportPhone = be_reportPhone;
	}
	@Column(length=1000)
	public String getBe_basicSituation() {
		return be_basicSituation;
	}
	public void setBe_basicSituation(String be_basicSituation) {
		this.be_basicSituation = be_basicSituation;
	}
	@ManyToOne
	@JoinColumn(name = "us_Id")
	public T_User_Info getUser() {
		return user;
	}
	public void setUser(T_User_Info user) {
		this.user = user;
	}
	public Date getBe_createDate() {
		return be_createDate;
	}
	public void setBe_createDate(Date be_createDate) {
		this.be_createDate = be_createDate;
	}
	
	@Column(length=1)
	public String getBe_status() {
		return be_status;
	}
	public void setBe_status(String be_status) {
		this.be_status = be_status;
	}
	@Column(length=1)
	public String getBe_del() {
		return be_del;
	}
	public void setBe_del(String be_del) {
		this.be_del = be_del;
	}
	
	
	
}
