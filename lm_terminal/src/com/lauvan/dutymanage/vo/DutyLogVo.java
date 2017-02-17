package com.lauvan.dutymanage.vo;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class DutyLogVo extends BaseVo {
	private static final long	serialVersionUID	= 1L;
	private Integer				duty_log_id;
	private Integer				duty_sch_id;
	private Integer				pe_id;
	private String				pe_name;
	private String				pe_mobilephone;
	private Integer				or_id;
	private String				or_name;
	private String				duty_prop;
	private String				duty_type;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				duty_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				duty_date_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				duty_date_end;
	private Integer				ev_id;
	private String				ev_name;
	@DateTimeFormat(pattern = "yyyy-MM")
	private Date				duty_month;

	public Integer getDuty_sch_id() {
		return duty_sch_id;
	}

	public void setDuty_sch_id(Integer duty_sch_id) {
		this.duty_sch_id = duty_sch_id;
	}

	public Integer getDuty_log_id() {
		return duty_log_id;
	}

	public void setDuty_log_id(Integer duty_log_id) {
		this.duty_log_id = duty_log_id;
	}

	public Integer getPe_id() {
		return pe_id;
	}

	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}

	public String getPe_name() {
		return pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	public String getPe_mobilephone() {
		return pe_mobilephone;
	}

	public void setPe_mobilephone(String pe_mobilephone) {
		this.pe_mobilephone = pe_mobilephone;
	}

	public Integer getOr_id() {
		return or_id;
	}

	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}

	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
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

	public Date getDuty_date() {
		return duty_date;
	}

	public String getDuty_date_str() {
		if(duty_date == null) {
			return "";
		}

		return DateFormatUtils.format(duty_date, "yyyy-MM-dd");
	}

	public void setDuty_date(Date duty_date) {
		this.duty_date = duty_date;
	}

	public Date getDuty_date_start() {
		return duty_date_start;
	}

	public String getDuty_date_start_str() {
		if(duty_date_start == null) {
			return "";
		}

		return DateFormatUtils.format(duty_date_start, "yyyy-MM-dd");
	}

	public void setDuty_date_start(Date duty_date_start) {
		this.duty_date_start = duty_date_start;
	}

	public Date getDuty_date_end() {
		return duty_date_end;
	}

	public String getDuty_date_end_str() {
		if(duty_date_end == null) {
			return "";
		}

		return DateFormatUtils.format(duty_date_end, "yyyy-MM-dd");
	}

	public void setDuty_date_end(Date duty_date_end) {
		this.duty_date_end = duty_date_end;
	}

	public Integer getEv_id() {
		return ev_id;
	}

	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}

	public String getEv_name() {
		return ev_name;
	}

	public void setEv_name(String ev_name) {
		this.ev_name = ev_name;
	}

	public Date getDuty_month() {
		return duty_month;
	}

	public String getDuty_month_str() {
		if(duty_month == null) {
			return "";
		}

		return DateFormatUtils.format(duty_month, "yyyy-MM");
	}

	public void setDuty_month(Date duty_month) {
		this.duty_month = duty_month;
	}
}
