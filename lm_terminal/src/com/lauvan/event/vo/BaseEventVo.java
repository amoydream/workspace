package com.lauvan.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class BaseEventVo {

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
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date be_date;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date be_dateBegin;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date be_dateEnd;
	/**
	 * 接报时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date be_reportDate;
	/**
	 * 事件类型
	 */
	private Integer eventTypeId;
	private String eventTypeName;
	/**
	 * 事发单位
	 */
	private Integer organId;
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
	
	private Integer CallID;
	private String be_del;
	
	public Integer getBe_id() {
		return be_id;
	}
	public void setBe_id(Integer be_id) {
		this.be_id = be_id;
	}
	public String getBe_name() {
		return be_name;
	}
	public void setBe_name(String be_name) {
		this.be_name = be_name;
	}
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
	public Integer getEventTypeId() {
		return eventTypeId;
	}
	public void setEventTypeId(Integer eventTypeId) {
		this.eventTypeId = eventTypeId;
	}
	public Integer getOrganId() {
		return organId;
	}
	public void setOrganId(Integer organId) {
		this.organId = organId;
	}
	public String getBe_reportMode() {
		return be_reportMode;
	}
	public void setBe_reportMode(String be_reportMode) {
		this.be_reportMode = be_reportMode;
	}
	public String getBe_reportName() {
		return be_reportName;
	}
	public void setBe_reportName(String be_reportName) {
		this.be_reportName = be_reportName;
	}
	public String getBe_reportPhone() {
		return be_reportPhone;
	}
	public void setBe_reportPhone(String be_reportPhone) {
		this.be_reportPhone = be_reportPhone;
	}
	public String getBe_basicSituation() {
		return be_basicSituation;
	}
	public void setBe_basicSituation(String be_basicSituation) {
		this.be_basicSituation = be_basicSituation;
	}
	public Date getBe_dateBegin() {
		return be_dateBegin;
	}
	public void setBe_dateBegin(Date be_dateBegin) {
		this.be_dateBegin = be_dateBegin;
	}
	public Date getBe_dateEnd() {
		return be_dateEnd;
	}
	public void setBe_dateEnd(Date be_dateEnd) {
		this.be_dateEnd = be_dateEnd;
	}
	public Integer getCallID() {
		return CallID;
	}
	public void setCallID(Integer callID) {
		CallID = callID;
	}
	public String getEventTypeName() {
		return eventTypeName;
	}
	public void setEventTypeName(String eventTypeName) {
		this.eventTypeName = eventTypeName;
	}
	public String getBe_del() {
		return be_del;
	}
	public void setBe_del(String be_del) {
		this.be_del = be_del;
	}
		
}
