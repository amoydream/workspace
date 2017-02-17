package com.lauvan.dutymanage.entity;

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

import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.organ.entity.C_Organ_Person;

@Entity
@Table(name = "t_call_history")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Call_History implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				call_hist_id;
	private String				is_caller;
	private String				tel_num;
	private Integer				channel_no;
	private Date				call_date;
	private String				record_path;
	private String				status;
	private T_EventInfo			eventInfo;
	private C_Organ_Person		organPerson;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getCall_hist_id() {
		return call_hist_id;
	}

	public void setCall_hist_id(Integer call_hist_id) {
		this.call_hist_id = call_hist_id;
	}

	@Column
	public Integer getChannel_no() {
		return channel_no;
	}

	public void setChannel_no(Integer channel_no) {
		this.channel_no = channel_no;
	}

	@Column(nullable = false)
	public String getIs_caller() {
		return is_caller;
	}

	public void setIs_caller(String is_caller) {
		this.is_caller = is_caller;
	}

	@Column(nullable = false)
	public String getTel_num() {
		return tel_num;
	}

	public void setTel_num(String tel_num) {
		this.tel_num = tel_num;
	}

	@Column(nullable = false)
	public Date getCall_date() {
		return call_date;
	}

	public void setCall_date(Date call_date) {
		this.call_date = call_date;
	}

	@Column
	public String getRecord_path() {
		return record_path;
	}

	public void setRecord_path(String record_path) {
		this.record_path = record_path;
	}

	@Column(nullable = false)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@OneToOne
	@JoinColumn(name = "ev_id")
	public T_EventInfo getEventInfo() {
		return eventInfo;
	}

	public void setEventInfo(T_EventInfo eventInfo) {
		this.eventInfo = eventInfo;
	}

	@OneToOne
	@JoinColumn(name = "pe_id")
	public C_Organ_Person getOrganPerson() {
		return organPerson;
	}

	public void setOrganPerson(C_Organ_Person organPerson) {
		this.organPerson = organPerson;
	}
}
