package com.lauvan.dutymanage.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class HandoverVo extends BaseVo implements java.io.Serializable{
	
	private static final long serialVersionUID = -5364206962160737032L;
	private Integer ha_Id;
	/**
	 * 交班人
	 */
	private Integer ha_Handman;
	/**
	 * 接班人
	 */
	private Integer ha_Takeman;
	/**
	 * 交班时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date ha_Handdate;
	/**
	 * 接班时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date ha_Takedate;
	/**
	 * 交班备注
	 */
	private String ha_Remark;
	
	public Integer getHa_Id() {
		return ha_Id;
	}
	public void setHa_Id(Integer ha_Id) {
		this.ha_Id = ha_Id;
	}
	public Integer getHa_Handman() {
		return ha_Handman;
	}
	public void setHa_Handman(Integer ha_Handman) {
		this.ha_Handman = ha_Handman;
	}
	public Integer getHa_Takeman() {
		return ha_Takeman;
	}
	public void setHa_Takeman(Integer ha_Takeman) {
		this.ha_Takeman = ha_Takeman;
	}
	public Date getHa_Handdate() {
		return ha_Handdate;
	}
	public void setHa_Handdate(Date ha_Handdate) {
		this.ha_Handdate = ha_Handdate;
	}
	public Date getHa_Takedate() {
		return ha_Takedate;
	}
	public void setHa_Takedate(Date ha_Takedate) {
		this.ha_Takedate = ha_Takedate;
	}
	public String getHa_Remark() {
		return ha_Remark;
	}
	public void setHa_Remark(String ha_Remark) {
		this.ha_Remark = ha_Remark;
	}
	

}
