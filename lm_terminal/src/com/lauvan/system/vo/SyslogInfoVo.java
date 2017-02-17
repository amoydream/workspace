package com.lauvan.system.vo;

import com.lauvan.base.vo.BaseVo;

public class SyslogInfoVo extends BaseVo {

	private static final long serialVersionUID = 1321811765072885599L;
	private Integer lo_Id;
	/**
	 * 操作用户
	 */
	private String lo_Username;
	/**
	 * 操作时间
	 */
	private String lo_Uptime;
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
	public Integer getLo_Id() {
		return lo_Id;
	}
	public void setLo_Id(Integer lo_Id) {
		this.lo_Id = lo_Id;
	}
	public String getLo_Username() {
		return lo_Username;
	}
	public void setLo_Username(String lo_Username) {
		this.lo_Username = lo_Username;
	}
	public String getLo_Uptime() {
		return lo_Uptime;
	}
	public void setLo_Uptime(String lo_Uptime) {
		this.lo_Uptime = lo_Uptime;
	}
	public String getLo_Describe() {
		return lo_Describe;
	}
	public void setLo_Describe(String lo_Describe) {
		this.lo_Describe = lo_Describe;
	}
	public String getLo_Type() {
		return lo_Type;
	}
	public void setLo_Type(String lo_Type) {
		this.lo_Type = lo_Type;
	}
	public String getLo_Usercode() {
		return lo_Usercode;
	}
	public void setLo_Usercode(String lo_Usercode) {
		this.lo_Usercode = lo_Usercode;
	}
	public String getLo_Method() {
		return lo_Method;
	}
	public void setLo_Method(String lo_Method) {
		this.lo_Method = lo_Method;
	}
	public String getLo_Params() {
		return lo_Params;
	}
	public void setLo_Params(String lo_Params) {
		this.lo_Params = lo_Params;
	}
	public String getLo_Exceptioncode() {
		return lo_Exceptioncode;
	}
	public void setLo_Exceptioncode(String lo_Exceptioncode) {
		this.lo_Exceptioncode = lo_Exceptioncode;
	}
	public String getLo_Exceptiondetail() {
		return lo_Exceptiondetail;
	}
	public void setLo_Exceptiondetail(String lo_Exceptiondetail) {
		this.lo_Exceptiondetail = lo_Exceptiondetail;
	}
	public String getLo_Ip() {
		return lo_Ip;
	}
	public void setLo_Ip(String lo_Ip) {
		this.lo_Ip = lo_Ip;
	}
}
