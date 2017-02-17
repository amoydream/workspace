package com.lauvan.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "t_user_limit")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_User_Limit implements java.io.Serializable {

	private static final long serialVersionUID = -6650994367708677367L;
	/**
	 * 用户名
	 */
	private String user_Code;
	/**
	 * 用户IP
	 */
	private String user_Ip;
	/**
	 * 登录时间
	 */
	private String login_Time;

	public T_User_Limit() {
	}

	@Id
	public String getUser_Code() {
		return this.user_Code;
	}

	public void setUser_Code(String userCode) {
		this.user_Code = userCode;
	}

	@Column(nullable = false, length = 30)
	public String getUser_Ip() {
		return this.user_Ip;
	}

	public void setUser_Ip(String userIp) {
		this.user_Ip = userIp;
	}

	@Column(nullable = false, length = 30)
	public String getLogin_Time() {
		return this.login_Time;
	}

	public void setLogin_Time(String loginTime) {
		this.login_Time = loginTime;
	}

}