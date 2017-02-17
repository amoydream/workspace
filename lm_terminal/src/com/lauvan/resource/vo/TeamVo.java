package com.lauvan.resource.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class TeamVo extends BaseVo implements Serializable{
	
	private static final long serialVersionUID = 7304176561803352479L;
	
	private Integer te_Id;
	/**
	 * 队伍名称
	 */
	private String te_Name;
	/**
	 * 联系人
	 */
	private String te_Linkman;
	/**
	 * 联系人电话
	 */
	private String te_Linkmantel;
	/**
	 * 所属单位
	 */
	private Integer te_Deptid;
	/**
	 * 设备数量
	 */
	private String te_Equipment;
	/**
	 * 成员数量
	 */
	private Integer te_Membernum;
	/**
	 * 队伍类型
	 */
	private String te_Type;
	/**
	 * 负责人
	 */
	private String te_Director;
	/**
	 * 负责人电话
	 */
	private String te_Directortel;
	/**
	 * 负责人手机
	 */
	private String te_Directorphone;
	/**
	 * 负责人职位
	 */
	private String te_Directorjob;
	/**
	 * 值班电话
	 */
	private String te_Dutycall;
	/**
	 * 传真
	 */
	private Integer te_Fax;
	/**
	 * 地址
	 */
	private String te_Address;
	/**
	 * 邮编
	 */
	private Integer te_Postcode;
	/**
	 * 经度
	 */
	private Double te_Longitude;
	/**
	 * 纬度
	 */
	private Double te_Latitude;
	/**
	 * 记录人
	 */
	private Integer te_Recordman;
	/**
	 * 记录时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date te_Recorddate=new Date();
	/**
	 * 队伍职责
	 */
	private String te_Teamjob;
	/**
	 * 队伍描述
	 */
	private String te_Teamscribe;
	/**
	 * 备注
	 */
	private String te_Remark;
	
	public Integer getTe_Id() {
		return te_Id;
	}
	public void setTe_Id(Integer te_Id) {
		this.te_Id = te_Id;
	}
	public String getTe_Name() {
		return te_Name;
	}
	public void setTe_Name(String te_Name) {
		this.te_Name = te_Name;
	}
	public String getTe_Linkman() {
		return te_Linkman;
	}
	public void setTe_Linkman(String te_Linkman) {
		this.te_Linkman = te_Linkman;
	}
	public String getTe_Linkmantel() {
		return te_Linkmantel;
	}
	public void setTe_Linkmantel(String te_Linkmantel) {
		this.te_Linkmantel = te_Linkmantel;
	}
	public Integer getTe_Deptid() {
		return te_Deptid;
	}
	public void setTe_Deptid(Integer te_Deptid) {
		this.te_Deptid = te_Deptid;
	}
	public String getTe_Equipment() {
		return te_Equipment;
	}
	public void setTe_Equipment(String te_Equipment) {
		this.te_Equipment = te_Equipment;
	}
	public Integer getTe_Membernum() {
		return te_Membernum;
	}
	public void setTe_Membernum(Integer te_Membernum) {
		this.te_Membernum = te_Membernum;
	}
	public String getTe_Type() {
		return te_Type;
	}
	public void setTe_Type(String te_Type) {
		this.te_Type = te_Type;
	}
	public String getTe_Director() {
		return te_Director;
	}
	public void setTe_Director(String te_Director) {
		this.te_Director = te_Director;
	}
	public String getTe_Directortel() {
		return te_Directortel;
	}
	public void setTe_Directortel(String te_Directortel) {
		this.te_Directortel = te_Directortel;
	}
	public String getTe_Directorphone() {
		return te_Directorphone;
	}
	public void setTe_Directorphone(String te_Directorphone) {
		this.te_Directorphone = te_Directorphone;
	}
	public String getTe_Directorjob() {
		return te_Directorjob;
	}
	public void setTe_Directorjob(String te_Directorjob) {
		this.te_Directorjob = te_Directorjob;
	}
	public String getTe_Dutycall() {
		return te_Dutycall;
	}
	public void setTe_Dutycall(String te_Dutycall) {
		this.te_Dutycall = te_Dutycall;
	}
	public Integer getTe_Fax() {
		return te_Fax;
	}
	public void setTe_Fax(Integer te_Fax) {
		this.te_Fax = te_Fax;
	}
	public String getTe_Address() {
		return te_Address;
	}
	public void setTe_Address(String te_Address) {
		this.te_Address = te_Address;
	}
	public Integer getTe_Postcode() {
		return te_Postcode;
	}
	public void setTe_Postcode(Integer te_Postcode) {
		this.te_Postcode = te_Postcode;
	}
	public Double getTe_Longitude() {
		return te_Longitude;
	}
	public void setTe_Longitude(Double te_Longitude) {
		this.te_Longitude = te_Longitude;
	}
	public Double getTe_Latitude() {
		return te_Latitude;
	}
	public void setTe_Latitude(Double te_Latitude) {
		this.te_Latitude = te_Latitude;
	}
	public Integer getTe_Recordman() {
		return te_Recordman;
	}
	public void setTe_Recordman(Integer te_Recordman) {
		this.te_Recordman = te_Recordman;
	}
	public Date getTe_Recorddate() {
		return te_Recorddate;
	}
	public void setTe_Recorddate(Date te_Recorddate) {
		this.te_Recorddate = te_Recorddate;
	}
	public String getTe_Teamjob() {
		return te_Teamjob;
	}
	public void setTe_Teamjob(String te_Teamjob) {
		this.te_Teamjob = te_Teamjob;
	}
	public String getTe_Teamscribe() {
		return te_Teamscribe;
	}
	public void setTe_Teamscribe(String te_Teamscribe) {
		this.te_Teamscribe = te_Teamscribe;
	}
	public String getTe_Remark() {
		return te_Remark;
	}
	public void setTe_Remark(String te_Remark) {
		this.te_Remark = te_Remark;
	}
	
	
}