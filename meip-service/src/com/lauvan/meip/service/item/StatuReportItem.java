package com.lauvan.meip.service.item;

import java.util.Date;

public class StatuReportItem extends Item {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				content;
	private String				eid;
	private String				userid;
	private String[]			mobiles;
	private Integer				smsstatu;
	private Date				updateTime;
	private Date				updateTimeStart;
	private Date				updateTimeEnd;
	private String				client_id;
	private String				receiver;
	private Integer				deleted;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String[] getMobiles() {
		return mobiles;
	}

	public void setMobiles(String[] mobiles) {
		this.mobiles = mobiles;
	}

	public Integer getSmsstatu() {
		return smsstatu;
	}

	public void setSmsstatu(Integer smsstatu) {
		this.smsstatu = smsstatu;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getUpdateTimeStart() {
		return updateTimeStart;
	}

	public void setUpdateTimeStart(Date updateTimeStart) {
		this.updateTimeStart = updateTimeStart;
	}

	public Date getUpdateTimeEnd() {
		return updateTimeEnd;
	}

	public void setUpdateTimeEnd(Date updateTimeEnd) {
		this.updateTimeEnd = updateTimeEnd;
	}

	public String getClient_id() {
		return client_id;
	}

	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}