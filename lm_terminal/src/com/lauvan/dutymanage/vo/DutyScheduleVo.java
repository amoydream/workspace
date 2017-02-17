package com.lauvan.dutymanage.vo;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;
import com.lauvan.util.DateCompareType;
import com.lauvan.util.DateUtil;
import com.lauvan.util.ValidateUtil;

public class DutyScheduleVo extends BaseVo {
	private static final long	serialVersionUID	= 1L;
	private Integer				duty_sch_id;
	private Integer				duty_sch_tmpl_id;
	private Integer				pe_id;
	private String				pe_name;
	private String				pe_mobilephone;
	private Integer				or_id;
	private String				or_name;
	private String				duty_prop;
	private String				duty_type;
	private String				is_tmpl;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				duty_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				duty_date_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				duty_date_end;

	public Integer getDuty_sch_id() {
		return duty_sch_id;
	}

	public void setDuty_sch_id(Integer duty_sch_id) {
		this.duty_sch_id = duty_sch_id;
	}

	public Integer getDuty_sch_tmpl_id() {
		return duty_sch_tmpl_id;
	}

	public void setDuty_sch_tmpl_id(Integer duty_sch_tmpl_id) {
		this.duty_sch_tmpl_id = duty_sch_tmpl_id;
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

	public String getDuty_prop_desc() {
		String duty_prop_desc = "";
		if(!ValidateUtil.isEmpty(duty_prop)) {
			switch(duty_prop) {
			case "1":
				duty_prop_desc = "带班领导";
				break;
			case "2":
				duty_prop_desc = "值班领导";
				break;
			case "3":
				duty_prop_desc = "值班干部";
				break;
			default:
				break;
			}
		}

		return duty_prop_desc;
	}

	public String getIs_tmpl() {
		return is_tmpl;
	}

	public void setIs_tmpl(String is_tmpl) {
		this.is_tmpl = is_tmpl;
	}

	public String getDuty_type() {
		return duty_type;
	}

	public String getDuty_type_desc() {
		String duty_type_desc = "";
		if(!ValidateUtil.isEmpty(duty_type)) {
			switch(duty_type) {
			case "1":
				duty_type_desc = "工作日";
				break;
			case "2":
				duty_type_desc = "休息日";
				break;
			default:
				break;
			}
		}

		return duty_type_desc;
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

	public String getExpried() {
		Date now = new Date();
		int result = DateUtil.compare(now, duty_date, DateCompareType.Day);

		return result >= 0 ? "N" : "Y";
	}
}
