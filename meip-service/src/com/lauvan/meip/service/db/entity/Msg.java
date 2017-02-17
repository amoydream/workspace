package com.lauvan.meip.service.db.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "msg")
public class Msg
	implements BaseEntity {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				mobile;
	private String				content;
	private Integer				msgtype;
	private Date				msgtime;
	private Integer				deleted;

	@Id
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column
	public Integer getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(Integer msgtype) {
		this.msgtype = msgtype;
	}

	@Column
	public Date getMsgtime() {
		return msgtime;
	}

	public void setMsgtime(Date msgtime) {
		this.msgtime = msgtime;
	}

	@Column
	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}