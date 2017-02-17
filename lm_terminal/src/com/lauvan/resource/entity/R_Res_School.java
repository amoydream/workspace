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
 * ClassName: R_Res_School 
 * @Description: 学校
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_school")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_School implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer sc_Id;
	/**
	 * 名称
	 */
	private String sc_Name;
	/**
	 * 容纳人数
	 */
	private Integer sc_Galleryful;
	/**
	 * 地址
	 */
	private String sc_Address;
	/**
	 * 占地面积
	 */
	private String sc_Area;
	/**
	 * 经度
	 */
	private String sc_Longitude;
	/**
	 * 纬度
	 */
	private String sc_Latitude;
	/**
	 * 联系人
	 */
	private String sc_Linkman;
	/**
	 * 联系人电话
	 */
	private String sc_Linkmantel;
	/**
	 * 办公室电话
	 */
	private String sc_Officetel;
	/**
	 * 教职工人数
	 */
	private Integer sc_Teachernum;
	/**
	 * 学生人数
	 */
	private Integer sc_Studentnum;
	/**
	 * 校长
	 */
	private String sc_Headmaster ;
	/**
	 * 校长
	 */
	private String sc_Headmastertel ;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getSc_Id() {
		return sc_Id;
	}
	public void setSc_Id(Integer sc_Id) {
		this.sc_Id = sc_Id;
	}
	@Column(length = 20,nullable = false)
	public String getSc_Name() {
		return sc_Name;
	}
	public void setSc_Name(String sc_Name) {
		this.sc_Name = sc_Name;
	}
	public Integer getSc_Galleryful() {
		return sc_Galleryful;
	}
	public void setSc_Galleryful(Integer sc_Galleryful) {
		this.sc_Galleryful = sc_Galleryful;
	}	
	@Column(length = 50,nullable = false)
	public String getSc_Address() {
		return sc_Address;
	}
	public void setSc_Address(String sc_Address) {
		this.sc_Address = sc_Address;
	}
	public String getSc_Area() {
		return sc_Area;
	}
	public void setSc_Area(String sc_Area) {
		this.sc_Area = sc_Area;
	}
	@Column(length = 10)
	public String getSc_Longitude() {
		return sc_Longitude;
	}
	public void setSc_Longitude(String sc_Longitude) {
		this.sc_Longitude = sc_Longitude;
	}
	@Column(length = 10)
	public String getSc_Latitude() {
		return sc_Latitude;
	}
	public void setSc_Latitude(String sc_Latitude) {
		this.sc_Latitude = sc_Latitude;
	}
	@Column(length = 10)
	public String getSc_Linkman() {
		return sc_Linkman;
	}
	public void setSc_Linkman(String sc_Linkman) {
		this.sc_Linkman = sc_Linkman;
	}
	@Column(length = 20)
	public String getSc_Linkmantel() {
		return sc_Linkmantel;
	}
	public void setSc_Linkmantel(String sc_Linkmantel) {
		this.sc_Linkmantel = sc_Linkmantel;
	}
	public String getSc_Officetel() {
		return sc_Officetel;
	}
	public void setSc_Officetel(String sc_Officetel) {
		this.sc_Officetel = sc_Officetel;
	}
	public Integer getSc_Teachernum() {
		return sc_Teachernum;
	}
	public void setSc_Teachernum(Integer sc_Teachernum) {
		this.sc_Teachernum = sc_Teachernum;
	}
	public Integer getSc_Studentnum() {
		return sc_Studentnum;
	}
	public void setSc_Studentnum(Integer sc_Studentnum) {
		this.sc_Studentnum = sc_Studentnum;
	}
	public String getSc_Headmaster() {
		return sc_Headmaster;
	}
	public void setSc_Headmaster(String sc_Headmaster) {
		this.sc_Headmaster = sc_Headmaster;
	}
	public String getSc_Headmastertel() {
		return sc_Headmastertel;
	}
	public void setSc_Headmastertel(String sc_Headmastertel) {
		this.sc_Headmastertel = sc_Headmastertel;
	}
	
	
}
