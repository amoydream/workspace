package com.lauvan.dutymanage1.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 
 * ClassName: VVoiceRecord 
 * @Description: 语音视图
 * @author 钮炜炜
 * @date 2016年3月4日 上午8:26:09
 */
@Entity
@Table(name="v_voice_record")
public class VVoiceRecord  implements java.io.Serializable {
	
	private static final long serialVersionUID = -1818834820685509840L;
	private Integer voId;
	private String voActAs;
	private Integer voCallid;
	private String voCcid;
	private String voCeid;
	private Integer voChannelno;
	private Integer voOutCallTime;
	private String voSeadid;
	private String voState;
	private Integer voTalkTime;
	private Date voTime;
	private Integer voTotalTime;
	private String voVoicepath;
	private Integer voWaitTime;
	/**
	 * 电话号码
	 */
	private String boNumber;
	/**
	 * 人员名称
	 */
	private String peName;
	/**
	 * 组织名称
	 */
	private String orName;
	/**
	 * 日常事件ID
	 */
	private Integer beId;
	/**
	 * 日常事件名称
	 */
	private String beName;
	/**
	 * 突发事件ID
	 */
	private Integer evId;
	/**
	 * 突发事件名称
	 */
	private String evName;
	
	@Id
	@Column(name = "vo_id", nullable = false)
	public Integer getVoId() {
		return this.voId;
	}

	public void setVoId(Integer voId) {
		this.voId = voId;
	}

	@Column(name = "vo_actAs", length = 1)
	public String getVoActAs() {
		return this.voActAs;
	}

	public void setVoActAs(String voActAs) {
		this.voActAs = voActAs;
	}

	@Column(name = "vo_callid")
	public Integer getVoCallid() {
		return this.voCallid;
	}

	public void setVoCallid(Integer voCallid) {
		this.voCallid = voCallid;
	}

	@Column(name = "vo_ccid", nullable = false, length = 20)
	public String getVoCcid() {
		return this.voCcid;
	}

	public void setVoCcid(String voCcid) {
		this.voCcid = voCcid;
	}

	@Column(name = "vo_ceid", nullable = false, length = 20)
	public String getVoCeid() {
		return this.voCeid;
	}

	public void setVoCeid(String voCeid) {
		this.voCeid = voCeid;
	}

	@Column(name = "vo_channelno")
	public Integer getVoChannelno() {
		return this.voChannelno;
	}

	public void setVoChannelno(Integer voChannelno) {
		this.voChannelno = voChannelno;
	}

	@Column(name = "vo_outCallTime")
	public Integer getVoOutCallTime() {
		return this.voOutCallTime;
	}

	public void setVoOutCallTime(Integer voOutCallTime) {
		this.voOutCallTime = voOutCallTime;
	}

	@Column(name = "vo_seadid", length = 20)
	public String getVoSeadid() {
		return this.voSeadid;
	}

	public void setVoSeadid(String voSeadid) {
		this.voSeadid = voSeadid;
	}

	@Column(name = "vo_state", length = 1)
	public String getVoState() {
		return this.voState;
	}

	public void setVoState(String voState) {
		this.voState = voState;
	}

	@Column(name = "vo_talkTime")
	public Integer getVoTalkTime() {
		return this.voTalkTime;
	}

	public void setVoTalkTime(Integer voTalkTime) {
		this.voTalkTime = voTalkTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "vo_time")
	public Date getVoTime() {
		return this.voTime;
	}

	public void setVoTime(Date voTime) {
		this.voTime = voTime;
	}

	@Column(name = "vo_totalTime")
	public Integer getVoTotalTime() {
		return this.voTotalTime;
	}

	public void setVoTotalTime(Integer voTotalTime) {
		this.voTotalTime = voTotalTime;
	}

	@Column(name = "vo_voicepath", length = 100)
	public String getVoVoicepath() {
		return this.voVoicepath;
	}

	public void setVoVoicepath(String voVoicepath) {
		this.voVoicepath = voVoicepath;
	}

	@Column(name = "vo_waitTime")
	public Integer getVoWaitTime() {
		return this.voWaitTime;
	}

	public void setVoWaitTime(Integer voWaitTime) {
		this.voWaitTime = voWaitTime;
	}

	@Column(name = "pe_name", length = 20)
	public String getPeName() {
		return this.peName;
	}

	public void setPeName(String peName) {
		this.peName = peName;
	}

	@Column(name = "or_name", length = 50)
	public String getOrName() {
		return this.orName;
	}

	public void setOrName(String orName) {
		this.orName = orName;
	}

	@Column(name = "be_id")
	public Integer getBeId() {
		return this.beId;
	}

	public void setBeId(Integer beId) {
		this.beId = beId;
	}

	@Column(name = "be_name", length = 100)
	public String getBeName() {
		return this.beName;
	}

	public void setBeName(String beName) {
		this.beName = beName;
	}

	@Column(name = "ev_id")
	public Integer getEvId() {
		return this.evId;
	}

	public void setEvId(Integer evId) {
		this.evId = evId;
	}

	@Column(name = "ev_name", length = 100)
	public String getEvName() {
		return this.evName;
	}

	public void setEvName(String evName) {
		this.evName = evName;
	}
	@Column(name = "bo_number", length = 20)
	public String getBoNumber() {
		return this.boNumber;
	}

	public void setBoNumber(String boNumber) {
		this.boNumber = boNumber;
	}
}