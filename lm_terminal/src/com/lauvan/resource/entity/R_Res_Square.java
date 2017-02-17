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
 * ClassName: R_Res_Square 
 * @Description: 广场
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_square")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_Square implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer sq_Id;
	/**
	 * 名称
	 */
	private String sq_Name;
	/**
	 * 容纳人数
	 */
	private Integer sq_Galleryful;
	/**
	 * 所属单位
	 */
	private String sq_Dept;
	/**
	 * 地址
	 */
	private String sq_Address;
	/**
	 * 占地面积
	 */
	private String sq_Area;
	/**
	 * 经度
	 */
	private String sq_Longitude;
	/**
	 * 纬度
	 */
	private String sq_Latitude;
	/**
	 * 联系人
	 */
	private String sq_Linkman;
	/**
	 * 联系人电话
	 */
	private String sq_Linkmantel;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getSq_Id() {
		return sq_Id;
	}
	public void setSq_Id(Integer sq_Id) {
		this.sq_Id = sq_Id;
	}
	@Column(length = 20,nullable = false)
	public String getSq_Name() {
		return sq_Name;
	}
	public void setSq_Name(String sq_Name) {
		this.sq_Name = sq_Name;
	}
	public Integer getSq_Galleryful() {
		return sq_Galleryful;
	}
	public void setSq_Galleryful(Integer sq_Galleryful) {
		this.sq_Galleryful = sq_Galleryful;
	}
	public String getSq_Dept() {
		return sq_Dept;
	}
	public void setSq_Dept(String sq_Dept) {
		this.sq_Dept = sq_Dept;
	}
	@Column(length = 50,nullable = false)
	public String getSq_Address() {
		return sq_Address;
	}
	public void setSq_Address(String sq_Address) {
		this.sq_Address = sq_Address;
	}
	public String getSq_Area() {
		return sq_Area;
	}
	public void setSq_Area(String sq_Area) {
		this.sq_Area = sq_Area;
	}
	@Column(length = 10)
	public String getSq_Longitude() {
		return sq_Longitude;
	}
	public void setSq_Longitude(String sq_Longitude) {
		this.sq_Longitude = sq_Longitude;
	}
	@Column(length = 10)
	public String getSq_Latitude() {
		return sq_Latitude;
	}
	public void setSq_Latitude(String sq_Latitude) {
		this.sq_Latitude = sq_Latitude;
	}
	@Column(length = 10)
	public String getSq_Linkman() {
		return sq_Linkman;
	}
	public void setSq_Linkman(String sq_Linkman) {
		this.sq_Linkman = sq_Linkman;
	}
	@Column(length = 20)
	public String getSq_Linkmantel() {
		return sq_Linkmantel;
	}
	public void setSq_Linkmantel(String sq_Linkmantel) {
		this.sq_Linkmantel = sq_Linkmantel;
	}
	
	
	
}
