package com.lauvan.meip.service.db.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "receivefailed")
public class ReceiveFailed
	implements BaseEntity {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				fmobile;
	private String				fcontent;
	private Date				fsendtime;
	private Integer				fstate;
	private String				remark;
	private Integer				deleted;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(nullable = false, length = 15)
	public String getFmobile() {
		return fmobile;
	}

	public void setFmobile(String fmobile) {
		this.fmobile = fmobile;
	}

	@Column(nullable = false, length = 255)
	public String getFcontent() {
		return fcontent;
	}

	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}

	@Column(nullable = false)
	public Date getFsendtime() {
		return fsendtime;
	}

	public void setFsendtime(Date fsendtime) {
		this.fsendtime = fsendtime;
	}

	@Column(nullable = false, length = 6)
	public Integer getFstate() {
		return fstate;
	}

	public void setFstate(Integer fstate) {
		this.fstate = fstate;
	}

	@Column(length = 255)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(length = 1)
	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}