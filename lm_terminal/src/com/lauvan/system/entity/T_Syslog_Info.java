package com.lauvan.system.entity;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "t_syslog_info")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Syslog_Info implements java.io.Serializable {

	private static final long serialVersionUID = 115705324149405102L;
	private Integer lo_Id;
	/**
	 * 操作用户
	 */
	private String lo_Username;
	/**
	 * 操作时间
	 */
	private Date lo_Uptime = new Date();
	/**
	 * 事务描述
	 */
	private String lo_Describe;
	/**
	 * 类型(0:请求，1：异常)
	 */
	private String lo_Type;
	/**
	 * 用户编码
	 */
	private String lo_Usercode;
	/**
	 * 请求方法
	 */
	private String lo_Method;
	/**
	 * 请求参数
	 */
	private String lo_Params;
	/**
	 * 异常代码
	 */
	private String lo_Exceptioncode;
	/**
	 * 异常信息
	 */
	private String lo_Exceptiondetail;
	/**
	 * 请求的IP
	 */
	private String lo_Ip;
	public T_Syslog_Info() {
	}

	public T_Syslog_Info(Integer loId, String loType, String loUsercode) {
		this.lo_Id = loId;
		this.lo_Type = loType;
		this.lo_Usercode = loUsercode;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getLo_Id() {
		return this.lo_Id;
	}

	public void setLo_Id(Integer loId) {
		this.lo_Id = loId;
	}

	@Column(length = 20)
	public String getLo_Username() {
		return this.lo_Username;
	}

	public void setLo_Username(String loUsername) {
		this.lo_Username = loUsername;
	}

	public Date getLo_Uptime() {
		return this.lo_Uptime;
	}

	public void setLo_Uptime(Date loUptime) {
		this.lo_Uptime = loUptime;
	}

	@Column(length = 200)
	public String getLo_Describe() {
		return this.lo_Describe;
	}

	public void setLo_Describe(String loDescribe) {
		this.lo_Describe = loDescribe;
	}

	@Column(nullable = false, length = 20)
	public String getLo_Type() {
		return this.lo_Type;
	}

	public void setLo_Type(String loType) {
		this.lo_Type = loType;
	}

	@Column(nullable = false, length = 20)
	public String getLo_Usercode() {
		return this.lo_Usercode;
	}

	public void setLo_Usercode(String loUsercode) {
		this.lo_Usercode = loUsercode;
	}
	@Column(length = 100)
	public String getLo_Method() {
		return lo_Method;
	}

	public void setLo_Method(String lo_Method) {
		this.lo_Method = lo_Method;
	}
	@Column(length = 1000)
	public String getLo_Params() {
		return lo_Params;
	}

	public void setLo_Params(String lo_Params) {
		this.lo_Params = lo_Params;
	}
	@Column(length = 100)
	public String getLo_Exceptioncode() {
		return lo_Exceptioncode;
	}

	public void setLo_Exceptioncode(String lo_Exceptioncode) {
		this.lo_Exceptioncode = lo_Exceptioncode;
	}
	@Column(length = 500)
	public String getLo_Exceptiondetail() {
		return lo_Exceptiondetail;
	}

	public void setLo_Exceptiondetail(String lo_Exceptiondetail) {
		this.lo_Exceptiondetail = lo_Exceptiondetail;
	}
	@Column(length = 30)
	public String getLo_Ip() {
		return lo_Ip;
	}

	public void setLo_Ip(String lo_Ip) {
		this.lo_Ip = lo_Ip;
	}

}