package com.lauvan.emergencyplan.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class EmeOrganPersonVo {

	private Integer eop_id;
	/**
	 * 名字
	 */
	private String eop_name;
	/**
	 * 所属组织
	 */
	private Integer eoId;
	/**
	 * 岗位
	 */
	private String eop_jobs;
	/**
	 * 手机
	 */
	private String eop_mobilephone;
	/**
	 * 性别（M:女，F:男）
	 */
	private String eop_sex;
	/**
	 * 出生年月
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date eop_birthday;
	/**
	 * 学历
	 */
	private String eop_educational;
	/**
	 * 籍贯
	 */
	private String eop_nativeplace;
	/**
	 * 民族
	 */
	private String eop_nationality;
	/**
	 * 政治面貌
	 */
	private String eop_political;
	/**
	 * 身份证
	 */
	private String eop_identity;
	/**
	 * 工作时间
	 */
	private Date eop_workdate;
	/**
	 * 专业
	 */
	private String eop_profession;
	/**
	 * 家庭住址
	 */
	private String eop_homeaddress;
	/**
	 * 现住住址
	 */
	private String eop_address;
	/**
	 * 邮编
	 */
	private String eop_zipcode;
	/**
	 * 备注
	 */
	private String eop_remark;

	private String eop_favorite;
	/**
	 * 办公电话
	 */
	private String officephone;
	/**
	 * 手机
	 */
	private String mobilephone;
	/**
	 * 住宅电话
	 */
	private String homephone;
	/**
	 * 邮箱
	 */
	private String email;
	public Integer getEop_id() {
		return eop_id;
	}
	public void setEop_id(Integer eop_id) {
		this.eop_id = eop_id;
	}
	public String getEop_name() {
		return eop_name;
	}
	public void setEop_name(String eop_name) {
		this.eop_name = eop_name;
	}
	public Integer getEoId() {
		return eoId;
	}
	public void setEoId(Integer eoId) {
		this.eoId = eoId;
	}
	public String getEop_jobs() {
		return eop_jobs;
	}
	public void setEop_jobs(String eop_jobs) {
		this.eop_jobs = eop_jobs;
	}
	public String getEop_mobilephone() {
		return eop_mobilephone;
	}
	public void setEop_mobilephone(String eop_mobilephone) {
		this.eop_mobilephone = eop_mobilephone;
	}
	public String getEop_sex() {
		return eop_sex;
	}
	public void setEop_sex(String eop_sex) {
		this.eop_sex = eop_sex;
	}
	public Date getEop_birthday() {
		return eop_birthday;
	}
	public void setEop_birthday(Date eop_birthday) {
		this.eop_birthday = eop_birthday;
	}
	public String getEop_educational() {
		return eop_educational;
	}
	public void setEop_educational(String eop_educational) {
		this.eop_educational = eop_educational;
	}
	public String getEop_nativeplace() {
		return eop_nativeplace;
	}
	public void setEop_nativeplace(String eop_nativeplace) {
		this.eop_nativeplace = eop_nativeplace;
	}
	public String getEop_nationality() {
		return eop_nationality;
	}
	public void setEop_nationality(String eop_nationality) {
		this.eop_nationality = eop_nationality;
	}
	public String getEop_political() {
		return eop_political;
	}
	public void setEop_political(String eop_political) {
		this.eop_political = eop_political;
	}
	public String getEop_identity() {
		return eop_identity;
	}
	public void setEop_identity(String eop_identity) {
		this.eop_identity = eop_identity;
	}
	public Date getEop_workdate() {
		return eop_workdate;
	}
	public void setEop_workdate(Date eop_workdate) {
		this.eop_workdate = eop_workdate;
	}
	public String getEop_profession() {
		return eop_profession;
	}
	public void setEop_profession(String eop_profession) {
		this.eop_profession = eop_profession;
	}
	public String getEop_homeaddress() {
		return eop_homeaddress;
	}
	public void setEop_homeaddress(String eop_homeaddress) {
		this.eop_homeaddress = eop_homeaddress;
	}
	public String getEop_address() {
		return eop_address;
	}
	public void setEop_address(String eop_address) {
		this.eop_address = eop_address;
	}
	public String getEop_zipcode() {
		return eop_zipcode;
	}
	public void setEop_zipcode(String eop_zipcode) {
		this.eop_zipcode = eop_zipcode;
	}
	public String getEop_remark() {
		return eop_remark;
	}
	public void setEop_remark(String eop_remark) {
		this.eop_remark = eop_remark;
	}
	public String getEop_favorite() {
		return eop_favorite;
	}
	public void setEop_favorite(String eop_favorite) {
		this.eop_favorite = eop_favorite;
	}
	public String getOfficephone() {
		return officephone;
	}
	public void setOfficephone(String officephone) {
		this.officephone = officephone;
	}
	public String getMobilephone() {
		return mobilephone;
	}
	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public String getHomephone() {
		return homephone;
	}
	public void setHomephone(String homephone) {
		this.homephone = homephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
