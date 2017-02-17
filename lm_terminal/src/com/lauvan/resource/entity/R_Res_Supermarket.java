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
 * ClassName: R_Res_Surpermarket 
 * @Description: 商场
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_surpermarket")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_Supermarket implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer su_Id;
	/**
	 * 名称
	 */
	private String su_Name;
	/**
	 * 容纳人数
	 */
	private Integer su_Galleryful;
	/**
	 * 地址
	 */
	private String su_Address;
	/**
	 * 占地面积
	 */
	private String su_Area;
	/**
	 * 经度
	 */
	private String su_Longitude;
	/**
	 * 纬度
	 */
	private String su_Latitude;
	/**
	 * 联系人
	 */
	private String su_Linkman;
	/**
	 * 联系人电话
	 */
	private String su_Linkmantel;
	/**
	 * 经营范围
	 */
	private String su_Workarea;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getSu_Id() {
		return su_Id;
	}
	public void setSu_Id(Integer su_Id) {
		this.su_Id = su_Id;
	}
	@Column(length = 20,nullable = false)
	public String getSu_Name() {
		return su_Name;
	}
	public void setSu_Name(String su_Name) {
		this.su_Name = su_Name;
	}
	public Integer getSu_Galleryful() {
		return su_Galleryful;
	}
	public void setSu_Galleryful(Integer su_Galleryful) {
		this.su_Galleryful = su_Galleryful;
	}
	@Column(length = 50,nullable = false)
	public String getSu_Address() {
		return su_Address;
	}
	public void setSu_Address(String su_Address) {
		this.su_Address = su_Address;
	}
	public String getSu_Area() {
		return su_Area;
	}
	public void setSu_Area(String su_Area) {
		this.su_Area = su_Area;
	}
	@Column(length = 10)
	public String getSu_Longitude() {
		return su_Longitude;
	}
	public void setSu_Longitude(String su_Longitude) {
		this.su_Longitude = su_Longitude;
	}
	@Column(length = 10)
	public String getSu_Latitude() {
		return su_Latitude;
	}
	public void setSu_Latitude(String su_Latitude) {
		this.su_Latitude = su_Latitude;
	}
	@Column(length = 10)
	public String getSu_Linkman() {
		return su_Linkman;
	}
	public void setSu_Linkman(String su_Linkman) {
		this.su_Linkman = su_Linkman;
	}
	@Column(length = 20)
	public String getSu_Linkmantel() {
		return su_Linkmantel;
	}
	public void setSu_Linkmantel(String su_Linkmantel) {
		this.su_Linkmantel = su_Linkmantel;
	}
	public String getSu_Workarea() {
		return su_Workarea;
	}
	public void setSu_Workarea(String su_Workarea) {
		this.su_Workarea = su_Workarea;
	}
	
	
	
	
}
