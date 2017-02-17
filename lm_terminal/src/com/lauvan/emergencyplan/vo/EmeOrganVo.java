package com.lauvan.emergencyplan.vo;

public class EmeOrganVo{

	private Integer eo_id;
	/**
	 * 机构名称
	 */
	private String eo_name;
	/**
	 * 机构简称
	 */
	private String eo_sname;
	/**
	 * 英文名称
	 */
	private String eo_englishname;
	/**
	 * 序号
	 */
	private Integer eo_no;
	/**
	 * 邮编
	 */
	private String eo_zipcode;
	/**
	 * 地址
	 */
	private String eo_address;
	/**
	 * 经度
	 */
	private Double eo_longitude;
	/**
	 * 纬度
	 */
	private Double eo_latitude;
	private Integer pid;
	/**
	 * 办公电话
	 */
	private String officephone;
	/**
	 * 传真
	 */
	private String fax;
	/**
	 * 邮箱
	 */
	private String email;
	public Integer getEo_id() {
		return eo_id;
	}
	public void setEo_id(Integer eo_id) {
		this.eo_id = eo_id;
	}
	public String getEo_name() {
		return eo_name;
	}
	public void setEo_name(String eo_name) {
		this.eo_name = eo_name;
	}
	public String getEo_sname() {
		return eo_sname;
	}
	public void setEo_sname(String eo_sname) {
		this.eo_sname = eo_sname;
	}
	public String getEo_englishname() {
		return eo_englishname;
	}
	public void setEo_englishname(String eo_englishname) {
		this.eo_englishname = eo_englishname;
	}
	public Integer getEo_no() {
		return eo_no;
	}
	public void setEo_no(Integer eo_no) {
		this.eo_no = eo_no;
	}
	public String getEo_zipcode() {
		return eo_zipcode;
	}
	public void setEo_zipcode(String eo_zipcode) {
		this.eo_zipcode = eo_zipcode;
	}
	public String getEo_address() {
		return eo_address;
	}
	public void setEo_address(String eo_address) {
		this.eo_address = eo_address;
	}
	public Double getEo_longitude() {
		return eo_longitude;
	}
	public void setEo_longitude(Double eo_longitude) {
		this.eo_longitude = eo_longitude;
	}
	public Double getEo_latitude() {
		return eo_latitude;
	}
	public void setEo_latitude(Double eo_latitude) {
		this.eo_latitude = eo_latitude;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getOfficephone() {
		return officephone;
	}
	public void setOfficephone(String officephone) {
		this.officephone = officephone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
