package com.lauvan.meip.service.db.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "jsdl2")
public class Jsdl2
	implements BaseEntity {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				mobile;
	private String				content;
	private Date				recetime;
	private Integer				status;
	private String				eid;
	private String				userid;
	private String				password;
	private String				userport;
	private Integer				deleted;

	@Id
	@Column(nullable = false, length = 11)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(nullable = false, length = 15)
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(nullable = false, length = 255)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column
	public Date getRecetime() {
		return recetime;
	}

	public void setRecetime(Date recetime) {
		this.recetime = recetime;
	}

	@Column(length = 1, nullable = false)
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	@Column(length = 20, nullable = false)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(length = 20)
	public String getUserport() {
		return userport;
	}

	public void setUserport(String userport) {
		this.userport = userport;
	}

	@Column(length = 1)
	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}