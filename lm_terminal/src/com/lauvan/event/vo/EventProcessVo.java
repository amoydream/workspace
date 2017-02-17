package com.lauvan.event.vo;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class EventProcessVo extends BaseVo {
	private static final long	serialVersionUID	= 1L;
	private Integer				pr_id;
	private String				pr_content;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date				pr_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date				pr_date_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date				pr_date_end;
	private Integer				pr_phase;

	private Integer				ev_id;
	private String				ev_name;

	private Integer				us_Id;
	private String				us_Name;
	private String				us_Mophone;

	private Integer				pe_id;
	private Integer[]			pe_id_arr;
	private String				rp_content;

	public Integer getPr_id() {
		return pr_id;
	}

	public void setPr_id(Integer pr_id) {
		this.pr_id = pr_id;
	}

	public String getPr_content() {
		return pr_content;
	}

	public void setPr_content(String pr_content) {
		this.pr_content = pr_content;
	}

	public Date getPr_date() {
		return pr_date;
	}

	public String getPr_date_str() {
		if(pr_date == null) {
			return "";
		}

		return DateFormatUtils.format(pr_date, "yyyy-MM-dd HH:mm:ss");
	}

	public void setPr_date(Date pr_date) {
		this.pr_date = pr_date;
	}

	public Date getPr_date_start() {
		return pr_date_start;
	}

	public String getPr_date_start_str() {
		if(pr_date_start == null) {
			return "";
		}

		return DateFormatUtils.format(pr_date_start, "yyyy-MM-dd HH:mm:ss");
	}

	public void setPr_date_start(Date pr_date_start) {
		this.pr_date_start = pr_date_start;
	}

	public Date getPr_date_end() {
		return pr_date_end;
	}

	public String getPr_date_end_str() {
		if(pr_date_end == null) {
			return "";
		}

		return DateFormatUtils.format(pr_date_end, "yyyy-MM-dd HH:mm:ss");
	}

	public void setPr_date_end(Date pr_date_end) {
		this.pr_date_end = pr_date_end;
	}

	public Integer getPr_phase() {
		return pr_phase;
	}

	public void setPr_phase(Integer pr_phase) {
		this.pr_phase = pr_phase;
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

	public Integer getUs_Id() {
		return us_Id;
	}

	public void setUs_Id(Integer us_Id) {
		this.us_Id = us_Id;
	}

	public String getUs_Name() {
		return us_Name;
	}

	public void setUs_Name(String us_Name) {
		this.us_Name = us_Name;
	}

	public String getUs_Mophone() {
		return us_Mophone;
	}

	public void setUs_Mophone(String us_Mophone) {
		this.us_Mophone = us_Mophone;
	}

	public Integer getPe_id() {
		return pe_id;
	}

	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}

	public Integer[] getPe_id_arr() {
		return pe_id_arr;
	}

	public void setPe_id_arr(Integer[] pe_id_arr) {
		this.pe_id_arr = pe_id_arr;
	}

	public String getRp_content() {
		return rp_content;
	}

	public void setRp_content(String rp_content) {
		this.rp_content = rp_content;
	}
}
