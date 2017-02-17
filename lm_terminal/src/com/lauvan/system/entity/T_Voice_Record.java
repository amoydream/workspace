package com.lauvan.system.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: T_Voice_Record 
 * @Description: 语音记录
 * @author 钮炜炜
 * @date 2016年1月12日 上午11:19:22
 */
@Entity
@Table(name = "t_voice_record")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Voice_Record implements Serializable{
	
	private static final long serialVersionUID = -5838224480276851808L;
	private Integer vo_id;
	/**
	 * 电话记录ID
	 */
	private Integer vo_callid;
	/**
	 * 通道
	 */
	private Integer vo_channelno;
	/**
	 * 被叫号
	 */
	private String vo_ceid;
	/**
	 * 坐席
	 */
	private String vo_seadid;
	/**
	 * 主叫号
	 */
	private String vo_ccid;
	/**
	 * 录音路径
	 */
	private String vo_voicepath;
	/**
	 * 电话记录时间
	 */
	private Date vo_time=new Date();
	/**
	 * 电话状态(0:未接，1：已接)
	 */
	private String vo_state="0";
	
	/**
	 * 总时长（秒）
	 */
	private Integer vo_totalTime;
	/**
	 * 转接人工服务时等待时长（秒）
	 */
	private Integer vo_waitTime;
	/**
	 * 人工服务通话时长（秒）
	 */
	private Integer vo_talkTime;
	/**
	 * 电路外呼时长（秒）
	 */
	private Integer vo_outCallTime;
	/**
	 * 电路方向（功能）识别
	 */
	private String vo_actAs;
	
	@Id
	public Integer getVo_id() {
		return vo_id;
	}
	public void setVo_id(Integer vo_id) {
		this.vo_id = vo_id;
	}
	@Column(unique=true)
	public Integer getVo_callid() {
		return vo_callid;
	}
	
	@Column(nullable=false)
	public void setVo_callid(Integer vo_callid) {
		this.vo_callid = vo_callid;
	}
	public Integer getVo_channelno() {
		return vo_channelno;
	}
	public void setVo_channelno(Integer vo_channelno) {
		this.vo_channelno = vo_channelno;
	}
	@Column(nullable=false,length=20)
	public String getVo_ceid() {
		return vo_ceid;
	}
	public void setVo_ceid(String vo_ceid) {
		this.vo_ceid = vo_ceid;
	}
	@Column(nullable=false,length=20)
	public String getVo_ccid() {
		return vo_ccid;
	}	
	public void setVo_ccid(String vo_ccid) {
		this.vo_ccid = vo_ccid;
	}
	@Column(length=100)
	public String getVo_voicepath() {
		return vo_voicepath;
	}
	public void setVo_voicepath(String vo_voicepath) {
		this.vo_voicepath = vo_voicepath;
	}
	@Column(length=20)
	public String getVo_seadid() {
		return vo_seadid;
	}
	public void setVo_seadid(String vo_seadid) {
		this.vo_seadid = vo_seadid;
	}
	@Column(length=1)
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
	@Column(length=1)
	public String getVo_actAs() {
		return vo_actAs;
	}
	public void setVo_actAs(String vo_actAs) {
		this.vo_actAs = vo_actAs;
	}

}
