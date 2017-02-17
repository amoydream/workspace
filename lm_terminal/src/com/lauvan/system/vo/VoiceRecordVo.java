package com.lauvan.system.vo;

public class VoiceRecordVo{

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
	private String vo_time;
	/**
	 * 电话状态
	 */
	private String vo_state;
	/**
	 * 坐席
	 */
	private String vo_seadid;
	
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
	/**
	 * 传真功能检测(值中有（F）则是传真)
	 */
	private String vo_actions;
	/**
	 * 本机坐席
	 */
	private String vo_Code;
	/**
	 * 传真返回值（8888则为发送成功，9999则为接收成功）
	 */
	private String vo_CallFEER;
	/**
	 * 语音文件名(传真时，则为传真文件号)
	 */
	private Integer callVocNO;
	private Integer eventId;
	
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
	public Integer getVo_channelno() {
		return vo_channelno;
	}
	public void setVo_channelno(Integer vo_channelno) {
		this.vo_channelno = vo_channelno;
	}
	public String getVo_ceid() {
		return vo_ceid;
	}
	public void setVo_ceid(String vo_ceid) {
		this.vo_ceid = vo_ceid;
	}
	public String getVo_ccid() {
		return vo_ccid;
	}
	public void setVo_ccid(String vo_ccid) {
		this.vo_ccid = vo_ccid;
	}
	public String getVo_voicepath() {
		return vo_voicepath;
	}
	public void setVo_voicepath(String vo_voicepath) {
		this.vo_voicepath = vo_voicepath;
	}
	public String getVo_time() {
		return vo_time;
	}
	public void setVo_time(String vo_time) {
		this.vo_time = vo_time;
	}
	public String getVo_state() {
		return vo_state;
	}
	public void setVo_state(String vo_state) {
		this.vo_state = vo_state;
	}
	public String getVo_seadid() {
		return vo_seadid;
	}
	public void setVo_seadid(String vo_seadid) {
		this.vo_seadid = vo_seadid;
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
	public String getVo_actions() {
		return vo_actions;
	}
	public void setVo_actions(String vo_actions) {
		this.vo_actions = vo_actions;
	}
	public String getVo_Code() {
		return vo_Code;
	}
	public void setVo_Code(String vo_Code) {
		this.vo_Code = vo_Code;
	}
	public String getVo_CallFEER() {
		return vo_CallFEER;
	}
	public void setVo_CallFEER(String vo_CallFEER) {
		this.vo_CallFEER = vo_CallFEER;
	}
	public Integer getCallVocNO() {
		return callVocNO;
	}
	public void setCallVocNO(Integer callVocNO) {
		this.callVocNO = callVocNO;
	}
	public Integer getEventId() {
		return eventId;
	}
	public void setEventId(Integer eventId) {
		this.eventId = eventId;
	}

}
