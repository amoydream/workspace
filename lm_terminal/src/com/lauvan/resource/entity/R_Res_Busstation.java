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
 * ClassName: R_Res_Busstation
 * @Description: 汽车站
 * @author 周志高
 * @date 2015年11月23日 下午4:00:41
 */
@Entity
@Table(name = "r_res_busstation")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Res_Busstation implements java.io.Serializable{

	private static final long serialVersionUID = -6146256724145491647L;
	
	private Integer bu_Id;
	/**
	 * 名称
	 */
	private String bu_Name;
	/**
	 * 地址
	 */
	private String bu_Address;
	/**
	 * 占地面积
	 */
	private String bu_Area;
	/**
	 * 经度
	 */
	private String bu_Longitude;
	/**
	 * 纬度
	 */
	private String bu_Latitude;
	/**
	 * 联系人
	 */
	private String bu_Linkman;
	/**
	 * 联系人电话
	 */
	private String bu_Linkmantel;
	/**
	 * 所属单位
	 */
	private String bu_Dept;
	/**
	 * 日发旅客量
	 */
	private Integer bu_Sendnum;
	/**
	 * 车辆数
	 */
	private Integer bu_Busnum;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getBu_Id() {
		return bu_Id;
	}
	public void setBu_Id(Integer bu_Id) {
		this.bu_Id = bu_Id;
	}
	@Column(length = 20,nullable = false)
	public String getBu_Name() {
		return bu_Name;
	}
	public void setBu_Name(String bu_Name) {
		this.bu_Name = bu_Name;
	}
	@Column(length = 50,nullable = false)
	public String getBu_Address() {
		return bu_Address;
	}
	public void setBu_Address(String bu_Address) {
		this.bu_Address = bu_Address;
	}
	public String getBu_Area() {
		return bu_Area;
	}
	public void setBu_Area(String bu_Area) {
		this.bu_Area = bu_Area;
	}
	@Column(length = 10)
	public String getBu_Longitude() {
		return bu_Longitude;
	}
	public void setBu_Longitude(String bu_Longitude) {
		this.bu_Longitude = bu_Longitude;
	}
	@Column(length = 10)
	public String getBu_Latitude() {
		return bu_Latitude;
	}
	public void setBu_Latitude(String bu_Latitude) {
		this.bu_Latitude = bu_Latitude;
	}
	@Column(length = 10)
	public String getBu_Linkman() {
		return bu_Linkman;
	}
	public void setBu_Linkman(String bu_Linkman) {
		this.bu_Linkman = bu_Linkman;
	}
	@Column(length = 20)
	public String getBu_Linkmantel() {
		return bu_Linkmantel;
	}
	public void setBu_Linkmantel(String bu_Linkmantel) {
		this.bu_Linkmantel = bu_Linkmantel;
	}
	public String getBu_Dept() {
		return bu_Dept;
	}
	public void setBu_Dept(String bu_Dept) {
		this.bu_Dept = bu_Dept;
	}
	public Integer getBu_Sendnum() {
		return bu_Sendnum;
	}
	public void setBu_Sendnum(Integer bu_Sendnum) {
		this.bu_Sendnum = bu_Sendnum;
	}
	public Integer getBu_Busnum() {
		return bu_Busnum;
	}
	public void setBu_Busnum(Integer bu_Busnum) {
		this.bu_Busnum = bu_Busnum;
	}
	
	
}
