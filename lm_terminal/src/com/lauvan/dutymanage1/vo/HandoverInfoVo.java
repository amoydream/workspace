package com.lauvan.dutymanage1.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HandoverInfoVo{
	private Integer ha_Id;
	/**
	 * 交班人ID
	 */
	private Integer us_Handid;
	
	/**
	 * 接班人ID
	 */
	private Integer us_Overid;
	/**
	 * 交接事宜
	 */
	private String ha_Content;
	/**
	 * 交接时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date ha_Date;
	/**
	 * 交班1，接班2
	 */
	private String hoType;
	
	private String us_name;
	
	public Integer getHa_Id() {
		return ha_Id;
	}
	public void setHa_Id(Integer ha_Id) {
		this.ha_Id = ha_Id;
	}
	public Integer getUs_Handid() {
		return us_Handid;
	}
	public void setUs_Handid(Integer us_Handid) {
		this.us_Handid = us_Handid;
	}
	public Integer getUs_Overid() {
		return us_Overid;
	}
	public void setUs_Overid(Integer us_Overid) {
		this.us_Overid = us_Overid;
	}
	public String getHa_Content() {
		return ha_Content;
	}
	public void setHa_Content(String ha_Content) {
		this.ha_Content = ha_Content;
	}
	public Date getHa_Date() {
		return ha_Date;
	}
	public void setHa_Date(Date ha_Date) {
		this.ha_Date = ha_Date;
	}
	public String getHoType() {
		return hoType;
	}
	public void setHoType(String hoType) {
		this.hoType = hoType;
	}
	public String getUs_name() {
		return us_name;
	}
	public void setUs_name(String us_name) {
		this.us_name = us_name;
	}
}
