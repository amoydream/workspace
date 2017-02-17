package com.lauvan.dutymanage.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.organ.entity.C_Organ_Person;

//@Entity
//@Table(name = "v_call_history")
public class V_Call_History implements Serializable {
	private static final long	serialVersionUID	= -5838224480276851808L;
	private Integer				vo_id;
	private Integer				vo_callid;
	private String				vo_callerFlag;
	private String				vo_seadid;
	private Integer				vo_channelno;
	private String				vo_thisNo;
	private String				vo_thatNo;
	private String				vo_voicepath;
	private Date				vo_time;
	private String				vo_state;
	private Integer				vo_totalTime;
	private Integer				vo_waitTime;
	private Integer				vo_talkTime;
	private Integer				vo_outCallTime;
	private String				vo_actAs;
	private C_Organ_Person		organPerson			= new C_Organ_Person();
	private T_EventInfo			eventInfo			= new T_EventInfo();

	@Id
	public Integer getVo_id() {
		return vo_id;
	}

	public void setVo_id(Integer vo_id) {
		this.vo_id = vo_id;
	}

	@Column
	public String getVo_callerFlag() {
		return vo_callerFlag;
	}

	public void setVo_callerFlag(String vo_callerFlag) {
		this.vo_callerFlag = vo_callerFlag;
	}

	@Column
	public Integer getVo_callid() {
		return vo_callid;
	}

	@Column
	public void setVo_callid(Integer vo_callid) {
		this.vo_callid = vo_callid;
	}

	public Integer getVo_channelno() {
		return vo_channelno;
	}

	public void setVo_channelno(Integer vo_channelno) {
		this.vo_channelno = vo_channelno;
	}

	@Column(length = 20)

	public String getVo_thisNo() {
		return vo_thisNo;
	}

	public void setVo_thisNo(String vo_thisNo) {
		this.vo_thisNo = vo_thisNo;
	}

	@Column(length = 20)
	public String getVo_thatNo() {
		return vo_thatNo;
	}

	public void setVo_thatNo(String vo_thatNo) {
		this.vo_thatNo = vo_thatNo;
	}

	@Column(length = 100)
	public String getVo_voicepath() {
		return vo_voicepath;
	}

	public void setVo_voicepath(String vo_voicepath) {
		this.vo_voicepath = vo_voicepath;
	}

	@Column(length = 20)
	public String getVo_seadid() {
		return vo_seadid;
	}

	public void setVo_seadid(String vo_seadid) {
		this.vo_seadid = vo_seadid;
	}

	@Column(length = 1)
	public String getVo_state() {
		return vo_state;
	}

	public void setVo_state(String vo_state) {
		this.vo_state = vo_state;
	}

	@Temporal(TemporalType.TIMESTAMP)
	public Date getVo_time() {
		return vo_time;
	}

	public void setVo_time(Date vo_time) {
		this.vo_time = vo_time;
	}

	@Column
	public Integer getVo_totalTime() {
		return vo_totalTime;
	}

	public void setVo_totalTime(Integer vo_totalTime) {
		this.vo_totalTime = vo_totalTime;
	}

	@Column
	public Integer getVo_waitTime() {
		return vo_waitTime;
	}

	public void setVo_waitTime(Integer vo_waitTime) {
		this.vo_waitTime = vo_waitTime;
	}

	@Column
	public Integer getVo_talkTime() {
		return vo_talkTime;
	}

	public void setVo_talkTime(Integer vo_talkTime) {
		this.vo_talkTime = vo_talkTime;
	}

	@Column
	public Integer getVo_outCallTime() {
		return vo_outCallTime;
	}

	public void setVo_outCallTime(Integer vo_outCallTime) {
		this.vo_outCallTime = vo_outCallTime;
	}

	@Column(length = 1)
	public String getVo_actAs() {
		return vo_actAs;
	}

	public void setVo_actAs(String vo_actAs) {
		this.vo_actAs = vo_actAs;
	}

	@ManyToOne
	@JoinColumn(name = "pe_id")
	public C_Organ_Person getOrganPerson() {
		return organPerson;
	}

	public void setOrganPerson(C_Organ_Person organPerson) {
		this.organPerson = organPerson;
	}

	@ManyToOne
	@JoinColumn(name = "ev_id")
	public T_EventInfo getEventInfo() {
		return eventInfo;
	}

	public void setEventInfo(T_EventInfo eventInfo) {
		this.eventInfo = eventInfo;
	}
}
