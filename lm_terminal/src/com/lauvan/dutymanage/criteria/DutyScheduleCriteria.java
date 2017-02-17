package com.lauvan.dutymanage.criteria;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.criteria.BaseCriteria;
import com.lauvan.dutymanage.entity.T_Duty_Schedule;

public class DutyScheduleCriteria extends BaseCriteria<DutyScheduleCriteria, T_Duty_Schedule> {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date	duty_date_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date	duty_date_end;
	private Integer	pe_id;
	private String	pe_name;
	private String	pe_mobilephone;

	public DutyScheduleCriteria() {
		super(new T_Duty_Schedule());
	}

	public Date getDuty_date_start() {
		return duty_date_start;
	}

	public void setDuty_date_start(Date duty_date_start) {
		this.duty_date_start = duty_date_start;
	}

	public Date getDuty_date_end() {
		return duty_date_end;
	}

	public void setDuty_date_end(Date duty_date_end) {
		this.duty_date_end = duty_date_end;
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
}