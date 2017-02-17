package com.lauvan.dutymanage.vo;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class CallHistoryVo extends BaseVo {
	private static final long	serialVersionUID	= 1L;
	private Integer				vo_id;
	private Integer				vo_callid;
	private String				vo_callerFlag;
	private String				vo_seadid;
	private Integer				vo_channelno;
	private String				vo_thisNo;
	private String				vo_thatNo;
	private String				vo_voicepath;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				vo_time;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				vo_time_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date				vo_time_end;
	private String				vo_state;
	private Integer				vo_totalTime;
	private Integer				vo_waitTime;
	private Integer				vo_talkTime;
	private Integer				vo_outCallTime;
	private String				vo_actAs;
	private Integer				pe_id;
	private String				pe_name;
	private String				or_name;
	private Integer				ev_id;
	private String				ev_name;
	private Integer				grp_count;

	public Integer getVo_id() {
		return vo_id;
	}

	public void setVo_id(Integer vo_id) {
		this.vo_id = vo_id;
	}

	public Integer getVo_callid() {
		return vo_callid;
	}

	public void setVo_callid(Integer vo_callid) {
		this.vo_callid = vo_callid;
	}

	public String getVo_callerFlag() {
		return vo_callerFlag;
	}

	public void setVo_callerFlag(String vo_callerFlag) {
		this.vo_callerFlag = vo_callerFlag;
	}

	public String getVo_seadid() {
		return vo_seadid;
	}

	public void setVo_seadid(String vo_seadid) {
		this.vo_seadid = vo_seadid;
	}

	public Integer getVo_channelno() {
		return vo_channelno;
	}

	public void setVo_channelno(Integer vo_channelno) {
		this.vo_channelno = vo_channelno;
	}

	public String getVo_thisNo() {
		return vo_thisNo;
	}

	public void setVo_thisNo(String vo_thisNo) {
		this.vo_thisNo = vo_thisNo;
	}

	public String getVo_thatNo() {
		return vo_thatNo;
	}

	public void setVo_thatNo(String vo_thatNo) {
		this.vo_thatNo = vo_thatNo;
	}

	public String getVo_voicepath() {
		return vo_voicepath;
	}

	public void setVo_voicepath(String vo_voicepath) {
		this.vo_voicepath = vo_voicepath;
	}

	public Date getVo_time() {
		return vo_time;
	}

	public String getVo_time_str() {
		if(vo_time == null) {
			return "";
		}

		return DateFormatUtils.format(vo_time, "yyyy-MM-dd HH:mm:ss");
	}

	public void setVo_time(Date vo_time) {
		this.vo_time = vo_time;
	}

	public Date getVo_time_start() {
		return vo_time_start;
	}

	public String getVo_time_start_str() {
		if(vo_time_start == null) {
			return "";
		}

		return DateFormatUtils.format(vo_time_start, "yyyy-MM-dd");
	}

	public void setVo_time_start(Date vo_time_start) {
		this.vo_time_start = vo_time_start;
	}

	public Date getVo_time_end() {
		return vo_time_end;
	}

	public String getVo_time_end_str() {
		if(vo_time_end == null) {
			return "";
		}

		return DateFormatUtils.format(vo_time_end, "yyyy-MM-dd");
	}

	public void setVo_time_end(Date vo_time_end) {
		this.vo_time_end = vo_time_end;
	}

	public String getVo_state() {
		return vo_state;
	}

	public void setVo_state(String vo_state) {
		this.vo_state = vo_state;
	}

	public String getVo_state_desc() {
		if("1".equals(vo_state)) {
			return "已接听";
		}

		return "未接听";
	}

	public Integer getVo_totalTime() {
		return vo_totalTime;
	}

	public void setVo_totalTime(Integer vo_totalTime) {
		this.vo_totalTime = vo_totalTime;
	}

	public Integer getVo_waitTime() {
		return vo_waitTime;
	}

	public void setVo_waitTime(Integer vo_waitTime) {
		this.vo_waitTime = vo_waitTime;
	}

	public Integer getVo_talkTime() {
		return vo_talkTime;
	}

	public void setVo_talkTime(Integer vo_talkTime) {
		this.vo_talkTime = vo_talkTime;
	}

	public Integer getVo_outCallTime() {
		return vo_outCallTime;
	}

	public void setVo_outCallTime(Integer vo_outCallTime) {
		this.vo_outCallTime = vo_outCallTime;
	}

	public String getVo_actAs() {
		return vo_actAs;
	}

	public void setVo_actAs(String vo_actAs) {
		this.vo_actAs = vo_actAs;
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

	public String getPe_name_ne() {
		return pe_name == null ? "陌生人" : pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
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

	public Integer getGrp_count() {
		return grp_count;
	}

	public void setGrp_count(Integer grp_count) {
		this.grp_count = grp_count;
	}
}
