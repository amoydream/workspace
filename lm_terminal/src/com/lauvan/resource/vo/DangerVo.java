package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class DangerVo extends BaseVo implements Serializable{
	
	private static final long serialVersionUID = -581329979305777624L;
	
	private Integer da_Id;
	/**
	 * 隐患点名称
	 */
	private String da_Name;
	/**
	 * 类型
	 */
	private Integer da_Typeid;
	/**
	 * 危险程度
	 */
	private String da_Level;
	/**
	 * 所属单位
	 */
	private String da_Dept;
	/**
	 * 经度
	 */
	private String da_Longitude;
	/**
	 * 纬度
	 */
	private String da_Latitude;
	/**
	 * 巡查人
	 */
	private String da_Patrolman;
	/**
	 * 巡查人电话
	 */
	private String da_Patrolmantel;
	/**
	 * 隐患点地址
	 */
	private String da_Address;
	/**
	 * 备注
	 */
	private String da_Remark;
	
	
	public Integer getDa_Id() {
		return da_Id;
	}
	public void setDa_Id(Integer da_Id) {
		this.da_Id = da_Id;
	}
	public String getDa_Name() {
		return da_Name;
	}
	public void setDa_Name(String da_Name) {
		this.da_Name = da_Name;
	}
	public Integer getDa_Typeid() {
		return da_Typeid;
	}
	public void setDa_Typeid(Integer da_Typeid) {
		this.da_Typeid = da_Typeid;
	}
	public String getDa_Level() {
		return da_Level;
	}
	public void setDa_Level(String da_Level) {
		this.da_Level = da_Level;
	}
	public String getDa_Dept() {
		return da_Dept;
	}
	public void setDa_Dept(String da_Dept) {
		this.da_Dept = da_Dept;
	}
	public String getDa_Longitude() {
		return da_Longitude;
	}
	public void setDa_Longitude(String da_Longitude) {
		this.da_Longitude = da_Longitude;
	}
	public String getDa_Latitude() {
		return da_Latitude;
	}
	public void setDa_Latitude(String da_Latitude) {
		this.da_Latitude = da_Latitude;
	}
	public String getDa_Patrolman() {
		return da_Patrolman;
	}
	public void setDa_Patrolman(String da_Patrolman) {
		this.da_Patrolman = da_Patrolman;
	}
	public String getDa_Patrolmantel() {
		return da_Patrolmantel;
	}
	public void setDa_Patrolmantel(String da_Patrolmantel) {
		this.da_Patrolmantel = da_Patrolmantel;
	}
	public String getDa_Address() {
		return da_Address;
	}
	public void setDa_Address(String da_Address) {
		this.da_Address = da_Address;
	}
	public String getDa_Remark() {
		return da_Remark;
	}
	public void setDa_Remark(String da_Remark) {
		this.da_Remark = da_Remark;
	}
	

}
