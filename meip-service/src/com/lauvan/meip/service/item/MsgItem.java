package com.lauvan.meip.service.item;

import java.util.Date;

public class MsgItem extends Item {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				mobile;
	private String[]			mobiles;
	private String				content;
	private Integer				msgtype;
	private Date				msgtime;
	private Date				msgtimeStart;
	private Date				msgtimeEnd;
	private Integer				count;
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

	public Integer getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(Integer msgtype) {
		this.msgtype = msgtype;
	}

	public Date getMsgtime() {
		return msgtime;
	}

	public void setMsgtime(Date msgtime) {
		this.msgtime = msgtime;
	}

	public Date getMsgtimeStart() {
		return msgtimeStart;
	}

	public void setMsgtimeStart(Date msgtimeStart) {
		this.msgtimeStart = msgtimeStart;
	}

	public Date getMsgtimeEnd() {
		return msgtimeEnd;
	}

	public void setMsgtimeEnd(Date msgtimeEnd) {
		this.msgtimeEnd = msgtimeEnd;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}