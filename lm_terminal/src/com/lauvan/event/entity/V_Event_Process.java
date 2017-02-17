package com.lauvan.event.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "v_event_process")
@DynamicInsert(true)
@DynamicUpdate(true)
public class V_Event_Process implements Serializable {
	private static final long	serialVersionUID	= 3366298566953380328L;
	private Integer				pr_id;
	private Date				pr_date;
	private String				pr_content;
	private Integer				pr_phase;
	private Integer				ev_id;
	private String				ev_name;
	private Integer				us_Id;

	@Id
	public Integer getPr_id() {
		return pr_id;
	}

	public void setPr_id(Integer pr_id) {
		this.pr_id = pr_id;
	}

	@Column
	public Date getPr_date() {
		return pr_date;
	}

	public void setPr_date(Date pr_date) {
		this.pr_date = pr_date;
	}

	@Column
	public String getPr_content() {
		return pr_content;
	}

	public void setPr_content(String pr_content) {
		this.pr_content = pr_content;
	}

	@Column
	public Integer getPr_phase() {
		return pr_phase;
	}

	public void setPr_phase(Integer pr_phase) {
		this.pr_phase = pr_phase;
	}

	@Column
	public Integer getEv_id() {
		return ev_id;
	}

	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}

	@Column
	public String getEv_name() {
		return ev_name;
	}

	public void setEv_name(String ev_name) {
		this.ev_name = ev_name;
	}

	@Column
	public Integer getUs_Id() {
		return us_Id;
	}

	public void setUs_Id(Integer us_Id) {
		this.us_Id = us_Id;
	}

}
