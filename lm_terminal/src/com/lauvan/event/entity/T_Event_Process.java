package com.lauvan.event.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.system.entity.T_User_Info;

@Entity
@Table(name = "t_event_process")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Event_Process implements Serializable {
	private static final long	serialVersionUID	= 3366298566953380328L;
	private Integer				pr_id;
	private Date				pr_date;
	private String				pr_content;
	private Integer				pr_phase;
	private T_EventInfo			t_eventinfo			= new T_EventInfo();
	private T_User_Info			t_user_info			= new T_User_Info();

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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

	@Column(nullable=false)
	public Integer getPr_phase() {
		return pr_phase;
	}

	public void setPr_phase(Integer pr_phase) {
		this.pr_phase = pr_phase;
	}

	@OneToOne
	@JoinColumn(name = "ev_id")
	public T_EventInfo getT_eventinfo() {
		return t_eventinfo;
	}

	public void setT_eventinfo(T_EventInfo t_eventinfo) {
		this.t_eventinfo = t_eventinfo;
	}

	@OneToOne
	@JoinColumn(name = "us_Id")
	public T_User_Info getT_user_info() {
		return t_user_info;
	}

	public void setT_user_info(T_User_Info t_user_info) {
		this.t_user_info = t_user_info;
	}

}
