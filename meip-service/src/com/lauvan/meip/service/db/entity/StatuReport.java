package com.lauvan.meip.service.db.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "statureport")
public class StatuReport
	implements BaseEntity {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				content;
	private String				eid;
	private String				userid;
	private Integer				smsstatu;
	private Date				updateTime;
	private String				client_id;
	private String				receiver;
	private Integer				deleted;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(nullable = false, length = 255)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(length = 20, nullable = false)
	public String getEid() {
		return eid;
	}

	public void setEid(String eid) {
		this.eid = eid;
	}

	@Column(length = 20, nullable = false)
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(nullable = false, length = 6)
	public Integer getSmsstatu() {
		return smsstatu;
	}

	public void setSmsstatu(Integer smsstatu) {
		this.smsstatu = smsstatu;
	}

	@Column
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@Column(nullable = false, length = 15)
	public String getClient_id() {
		return client_id;
	}

	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}

	@Column(nullable = false, length = 15)
	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	@Column(length = 1)
	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}