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
 * ClassName: R_Res_Entertainment
 * @Description: 娱乐场所
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_entertainment")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_Entertainment implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer en_Id;
	/**
	 * 名称
	 */
	private String en_Name;
	/**
	 * 容纳人数
	 */
	private Integer en_Galleryful;
	/**
	 * 地址
	 */
	private String en_Address;
	/**
	 * 占地面积
	 */
	private String en_Area;
	/**
	 * 经度
	 */
	private String en_Longitude;
	/**
	 * 纬度
	 */
	private String en_Latitude;
	/**
	 * 联系人
	 */
	private String en_Linkman;
	/**
	 * 联系人电话
	 */
	private String en_Linkmantel;
	/**
	 * 经营范围
	 */
	private String en_Workarea;
	/**
	 * 营业时间
	 */
	private String en_Businesshours;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEn_Id() {
		return en_Id;
	}
	public void setEn_Id(Integer en_Id) {
		this.en_Id = en_Id;
	}
	@Column(length = 20,nullable = false)
	public String getEn_Name() {
		return en_Name;
	}
	public void setEn_Name(String en_Name) {
		this.en_Name = en_Name;
	}
	public Integer getEn_Galleryful() {
		return en_Galleryful;
	}
	public void setEn_Galleryful(Integer en_Galleryful) {
		this.en_Galleryful = en_Galleryful;
	}
	@Column(length = 50,nullable = false)
	public String getEn_Address() {
		return en_Address;
	}
	public void setEn_Address(String en_Address) {
		this.en_Address = en_Address;
	}
	public String getEn_Area() {
		return en_Area;
	}
	public void setEn_Area(String en_Area) {
		this.en_Area = en_Area;
	}
	@Column(length = 10)
	public String getEn_Longitude() {
		return en_Longitude;
	}
	public void setEn_Longitude(String en_Longitude) {
		this.en_Longitude = en_Longitude;
	}
	@Column(length = 10)
	public String getEn_Latitude() {
		return en_Latitude;
	}
	public void setEn_Latitude(String en_Latitude) {
		this.en_Latitude = en_Latitude;
	}
	@Column(length = 10)
	public String getEn_Linkman() {
		return en_Linkman;
	}
	public void setEn_Linkman(String en_Linkman) {
		this.en_Linkman = en_Linkman;
	}
	@Column(length = 20)
	public String getEn_Linkmantel() {
		return en_Linkmantel;
	}
	public void setEn_Linkmantel(String en_Linkmantel) {
		this.en_Linkmantel = en_Linkmantel;
	}
	public String getEn_Workarea() {
		return en_Workarea;
	}
	public void setEn_Workarea(String en_Workarea) {
		this.en_Workarea = en_Workarea;
	}
	public String getEn_Businesshours() {
		return en_Businesshours;
	}
	public void setEn_Businesshours(String en_Businesshours) {
		this.en_Businesshours = en_Businesshours;
	}
	
	
}
