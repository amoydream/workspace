package com.lauvan.system.vo;

public class VoiceVo {
	/**
	 * 接听状态
	 */
	private Integer caseNo;
	/**
	 * 坐席ID
	 */
	private Integer seatId;
	private Integer seatCallId;
	/**
	 * 唯一ID
	 */
	private Integer callId;
	/**
	 * 通道
	 */
	private Integer channelNO;
	/**
	 * 被叫号
	 */
	private String ceId;
    /**
     * 主叫号
     */
	private String ccId;
	private Integer callVocNo;
	private Integer businessId;
	private String guestName;
	private Integer userId;
	private String userName;
	private String ugrpNo;
	private String seatIp;
	/**
	 * 转接人工服务时等待时长（秒）
	 */
	private Integer waitTime;
	/**
	 * 人工服务通话时长（秒）
	 */
	private Integer talkTime;
	public Integer getCaseNo() {
		return caseNo;
	}
	public void setCaseNo(Integer caseNo) {
		this.caseNo = caseNo;
	}
	public Integer getSeatId() {
		return seatId;
	}
	public void setSeatId(Integer seatId) {
		this.seatId = seatId;
	}
	public Integer getSeatCallId() {
		return seatCallId;
	}
	public void setSeatCallId(Integer seatCallId) {
		this.seatCallId = seatCallId;
	}
	public Integer getCallId() {
		return callId;
	}
	public void setCallId(Integer callId) {
		this.callId = callId;
	}
	public Integer getChannelNO() {
		return channelNO;
	}
	public void setChannelNO(Integer channelNO) {
		this.channelNO = channelNO;
	}
	public String getCeId() {
		return ceId;
	}
	public void setCeId(String ceId) {
		this.ceId = ceId;
	}
	public String getCcId() {
		return ccId;
	}
	public void setCcId(String ccId) {
		this.ccId = ccId;
	}
	public Integer getCallVocNo() {
		return callVocNo;
	}
	public void setCallVocNo(Integer callVocNo) {
		this.callVocNo = callVocNo;
	}
	public Integer getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUgrpNo() {
		return ugrpNo;
	}
	public void setUgrpNo(String ugrpNo) {
		this.ugrpNo = ugrpNo;
	}
	public String getSeatIp() {
		return seatIp;
	}
	public void setSeatIp(String seatIp) {
		this.seatIp = seatIp;
	}
	public Integer getWaitTime() {
		return waitTime;
	}
	public void setWaitTime(Integer waitTime) {
		this.waitTime = waitTime;
	}
	public Integer getTalkTime() {
		return talkTime;
	}
	public void setTalkTime(Integer talkTime) {
		this.talkTime = talkTime;
	}
	
}
