package com.lauvan.dutymanage.vo;

import com.lauvan.base.vo.BaseVo;

public class SmsTmplVo extends BaseVo {
	private static final long	serialVersionUID	= 1L;
	private Integer				sms_tmpl_id;
	private String				tmpl_content;
	private String				grp_code;
	private String				grp_desc;
	private Integer				ev_id;
	private String				ev_name;

	public Integer getSms_tmpl_id() {
		return sms_tmpl_id;
	}

	public void setSms_tmpl_id(Integer sms_tmpl_id) {
		this.sms_tmpl_id = sms_tmpl_id;
	}

	public String getTmpl_content() {
		return tmpl_content;
	}

	public void setTmpl_content(String tmpl_content) {
		this.tmpl_content = tmpl_content;
	}

	public String getGrp_code() {
		return grp_code;
	}

	public void setGrp_code(String grp_code) {
		this.grp_code = grp_code;
	}

	public String getGrp_desc() {
		return grp_desc;
	}

	public void setGrp_desc(String grp_desc) {
		this.grp_desc = grp_desc;
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

}
