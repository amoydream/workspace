package com.lauvan.resource.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


/**
 * 
 * ClassName: R_Res_Reservoir
 * @Description: 水库
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_reservoir")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_Reservoir implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer re_Id;
	/**
	 * 名称
	 */
	private String re_Name;
	/**
	 * 地址
	 */
	private String re_Address;
	/**
	 * 占地面积
	 */
	private String re_Area;
	/**
	 * 经度
	 */
	private String re_Longitude;
	/**
	 * 纬度
	 */
	private String re_Latitude;
	/**
	 * 联系人
	 */
	private String re_Linkman;
	/**
	 * 联系人电话
	 */
	private String re_Linkmantel;
	/**
	 * 所属单位
	 */
	private String re_Dept;
	/**
	 * 储水量
	 */
	private String re_Capacity;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getRe_Id() {
		return re_Id;
	}
	public void setRe_Id(Integer re_Id) {
		this.re_Id = re_Id;
	}
	@Column(length = 20,nullable = false)
	public String getRe_Name() {
		return re_Name;
	}
	public void setRe_Name(String re_Name) {
		this.re_Name = re_Name;
	}
	@Column(length = 50,nullable = false)
	public String getRe_Address() {
		return re_Address;
	}
	public void setRe_Address(String re_Address) {
		this.re_Address = re_Address;
	}
	public String getRe_Area() {
		return re_Area;
	}
	public void setRe_Area(String re_Area) {
		this.re_Area = re_Area;
	}
	@Column(length = 10)
	public String getRe_Longitude() {
		return re_Longitude;
	}
	public void setRe_Longitude(String re_Longitude) {
		this.re_Longitude = re_Longitude;
	}
	@Column(length = 10)
	public String getRe_Latitude() {
		return re_Latitude;
	}
	public void setRe_Latitude(String re_Latitude) {
		this.re_Latitude = re_Latitude;
	}
	@Column(length = 10)
	public String getRe_Linkman() {
		return re_Linkman;
	}
	public void setRe_Linkman(String re_Linkman) {
		this.re_Linkman = re_Linkman;
	}
	@Column(length = 20)
	public String getRe_Linkmantel() {
		return re_Linkmantel;
	}
	public void setRe_Linkmantel(String re_Linkmantel) {
		this.re_Linkmantel = re_Linkmantel;
	}
	public String getRe_Dept() {
		return re_Dept;
	}
	public void setRe_Dept(String re_Dept) {
		this.re_Dept = re_Dept;
	}
	public String getRe_Capacity() {
		return re_Capacity;
	}
	public void setRe_Capacity(String re_Capacity) {
		this.re_Capacity = re_Capacity;
	}
	
	
	
}
