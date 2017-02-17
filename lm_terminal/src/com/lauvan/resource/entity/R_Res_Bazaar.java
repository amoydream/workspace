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
 * ClassName: R_Res_Bazaar
 * @Description: 市场
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_bazaar")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_Bazaar implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer ba_Id;
	/**
	 * 名称
	 */
	private String ba_Name;
	/**
	 * 容纳人数
	 */
	private Integer ba_Galleryful;
	/**
	 * 地址
	 */
	private String ba_Address;
	/**
	 * 占地面积
	 */
	private String ba_Area;
	/**
	 * 经度
	 */
	private String ba_Longitude;
	/**
	 * 纬度
	 */
	private String ba_Latitude;
	/**
	 * 联系人
	 */
	private String ba_Linkman;
	/**
	 * 联系人电话
	 */
	private String ba_Linkmantel;
	/**
	 * 所属单位
	 */
	private String ba_Dept;
	/**
	 * 经营范围
	 */
	private String ba_Workarea;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getBa_Id() {
		return ba_Id;
	}
	public void setBa_Id(Integer ba_Id) {
		this.ba_Id = ba_Id;
	}
	@Column(length = 20,nullable = false)
	public String getBa_Name() {
		return ba_Name;
	}
	public void setBa_Name(String ba_Name) {
		this.ba_Name = ba_Name;
	}
	public Integer getBa_Galleryful() {
		return ba_Galleryful;
	}
	public void setBa_Galleryful(Integer ba_Galleryful) {
		this.ba_Galleryful = ba_Galleryful;
	}
	@Column(length = 50,nullable = false)
	public String getBa_Address() {
		return ba_Address;
	}
	public void setBa_Address(String ba_Address) {
		this.ba_Address = ba_Address;
	}
	public String getBa_Area() {
		return ba_Area;
	}
	public void setBa_Area(String ba_Area) {
		this.ba_Area = ba_Area;
	}
	@Column(length = 10)
	public String getBa_Longitude() {
		return ba_Longitude;
	}
	public void setBa_Longitude(String ba_Longitude) {
		this.ba_Longitude = ba_Longitude;
	}
	@Column(length = 10)
	public String getBa_Latitude() {
		return ba_Latitude;
	}
	public void setBa_Latitude(String ba_Latitude) {
		this.ba_Latitude = ba_Latitude;
	}
	@Column(length = 10)
	public String getBa_Linkman() {
		return ba_Linkman;
	}
	public void setBa_Linkman(String ba_Linkman) {
		this.ba_Linkman = ba_Linkman;
	}
	@Column(length = 20)
	public String getBa_Linkmantel() {
		return ba_Linkmantel;
	}
	public void setBa_Linkmantel(String ba_Linkmantel) {
		this.ba_Linkmantel = ba_Linkmantel;
	}
	public String getBa_Dept() {
		return ba_Dept;
	}
	public void setBa_Dept(String ba_Dept) {
		this.ba_Dept = ba_Dept;
	}
	public String getBa_Workarea() {
		return ba_Workarea;
	}
	public void setBa_Workarea(String ba_Workarea) {
		this.ba_Workarea = ba_Workarea;
	}
	
	
}
