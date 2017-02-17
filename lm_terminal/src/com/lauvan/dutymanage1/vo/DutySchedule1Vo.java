package com.lauvan.dutymanage1.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class DutySchedule1Vo {
	private Integer duty_id;
	/**
	 * 值班日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date duty_date;
	/**
	 * 值班性质
	 */
	private String duty_prop;
	/**
	 * 值班类型
	 */
	private String duty_type;
	/**
	 * 是否模板（1）
	 */
	private String duty_temp;
	/**
	 * 是否上级领导（1是，0不是）
	 */
	private String duty_ifleader;
	/**
	 * 人员ID
	 */
	private Integer pe_id;
	/**
	 * 拖动天数
	 */
	private Integer days;
	public Integer getDuty_id() {
		return duty_id;
	}
	public void setDuty_id(Integer duty_id) {
		this.duty_id = duty_id;
	}
	public Date getDuty_date() {
		return duty_date;
	}
	public void setDuty_date(Date duty_date) {
		this.duty_date = duty_date;
	}
	public String getDuty_prop() {
		return duty_prop;
	}
	public void setDuty_prop(String duty_prop) {
		this.duty_prop = duty_prop;
	}
	public String getDuty_type() {
		return duty_type;
	}
	public void setDuty_type(String duty_type) {
		this.duty_type = duty_type;
	}
	public String getDuty_temp() {
		return duty_temp;
	}
	public void setDuty_temp(String duty_temp) {
		this.duty_temp = duty_temp;
	}
	public Integer getPe_id() {
		return pe_id;
	}
	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}
	public Integer getDays() {
		return days;
	}
	public void setDays(Integer days) {
		this.days = days;
	}
	public String getDuty_ifleader() {
		return duty_ifleader;
	}
	public void setDuty_ifleader(String duty_ifleader) {
		this.duty_ifleader = duty_ifleader;
	}

	
}
