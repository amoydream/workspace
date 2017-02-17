package com.lauvan.meip.service.item;

import java.util.Date;

public class YfsdlItem extends Item {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				mobile;
	private String[]			mobiles;
	private String				content;
	private Date				deadtime;
	private Date				deadtimeStart;
	private Date				deadtimeEnd;
	private Integer				status;
	private String				eid;
	private String				userid;
	private String				password;
	private String				userport;
	private Integer				msgid;
	private Integer				deleted;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String[] getMobiles() {
		return mobiles;
	}

	public void setMobiles(String[] mobiles) {
		this.mobiles = mobiles;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDeadtime() {
		return deadtime;
	}

	public void setDeadtime(Date deadtime) {
		this.deadtime = deadtime;
	}

	public Date getDeadtimeStart() {
		return deadtimeStart;
	}

	public void setDeadtimeStart(Date deadtimeStart) {
		this.deadtimeStart = deadtimeStart;
	}

	public Date getDeadtimeEnd() {
		return deadtimeEnd;
	}

	public void setDeadtimeEnd(Date deadtimeEnd) {
		this.deadtimeEnd = deadtimeEnd;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getEid() {
		return eid;
	}

	public void setEid(String eid) {
		this.eid = eid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserport() {
		return userport;
	}

	public void setUserport(String userport) {
		this.userport = userport;
	}

	public Integer getMsgid() {
		return msgid;
	}

	public void setMsgid(Integer msgid) {
		this.msgid = msgid;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}