package com.lauvan.resource.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
* @ClassName: R_Danger
* @Description: 危险隐患表实体
* @author zhou
* @date 2015年12月23日 上午11:47:12
*
 */
@Entity
@Table(name = "r_danger")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Danger implements java.io.Serializable {

	private static final long serialVersionUID = -7955655214767174090L;
	
	private Integer da_Id;
	/**
	 * 隐患点名称
	 */
	private String da_Name;
	/**
	 * 类型
	 */
	private R_Danger_Type da_Typeid;
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
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getDa_Id() {
		return da_Id;
	}
	public void setDa_Id(Integer da_Id) {
		this.da_Id = da_Id;
	}
	@Column(length = 20,nullable = false)
	public String getDa_Name() {
		return da_Name;
	}
	public void setDa_Name(String da_Name) {
		this.da_Name = da_Name;
	}
	@ManyToOne
	@JoinColumn(name="da_Typeid",nullable = false)
	public R_Danger_Type getDa_Typeid() {
		return da_Typeid;
	}
	public void setDa_Typeid(R_Danger_Type da_Typeid) {
		this.da_Typeid = da_Typeid;
	}
	@Column(length = 10)
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
	@Column(length = 10)
	public String getDa_Longitude() {
		return da_Longitude;
	}
	public void setDa_Longitude(String da_Longitude) {
		this.da_Longitude = da_Longitude;
	}
	@Column(length = 10)
	public String getDa_Latitude() {
		return da_Latitude;
	}
	public void setDa_Latitude(String da_Latitude) {
		this.da_Latitude = da_Latitude;
	}
	@Column(length = 50)
	public String getDa_Patrolman() {
		return da_Patrolman;
	}
	public void setDa_Patrolman(String da_Patrolman) {
		this.da_Patrolman = da_Patrolman;
	}
	@Column(length = 20)
	public String getDa_Patrolmantel() {
		return da_Patrolmantel;
	}
	public void setDa_Patrolmantel(String da_Patrolmantel) {
		this.da_Patrolmantel = da_Patrolmantel;
	}
	@Column(length = 100)
	public String getDa_Address() {
		return da_Address;
	}
	public void setDa_Address(String da_Address) {
		this.da_Address = da_Address;
	}
	@Column(length = 100)
	public String getDa_Remark() {
		return da_Remark;
	}
	public void setDa_Remark(String da_Remark) {
		this.da_Remark = da_Remark;
	}

}
