package com.lauvan.resource.entity;

import java.util.Date;

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
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.system.entity.T_User_Info;

/**
 * 物资存储表实体
* @ClassName: R_Supplies_Store
* @Description: TODO
* @author zhou
* @date 2016年1月22日 下午3:58:40
*
 */
@Entity
@Table(name = "r_supplies_store")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Supplies_Store implements java.io.Serializable{

	private static final long serialVersionUID = 3827919886279124676L;
	
	private Integer st_Id;
	/**
	 * 物资Id
	 */
	private R_Supplies st_Suppliesid;
	/**
	 * 管理单位
	 */
	private String st_Managedept;
	/**
	 * 地址
	 */
	private String st_Address;
	/**
	 * 经度
	 */
	private Double st_Longitude;
	/**
	 * 纬度
	 */
	private Double st_Latitude;
    /**
     * 存放地电话
     */
	private String st_Storetel;
	/**
	 * 负责人
	 */
	private String st_Manageman;
	/**
	 * 负责人电话
	 */
	private String st_Managemantel;
	/**
	 * 数量
	 */
	private String st_Count;
	/**
	 * 
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date st_Storedate;
	/**
	 * 记录人
	 */
	private T_User_Info st_Recordman;
	/**
	 * 记录时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date st_Recorddate=new Date();
	
	public R_Supplies_Store() {
		super();
	}
	public R_Supplies_Store(Integer st_Id) {
		super();
		this.st_Id = st_Id;
	}


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getSt_Id() {
		return st_Id;
	}
	public void setSt_Id(Integer st_Id) {
		this.st_Id = st_Id;
	}
	@ManyToOne
	@JoinColumn(name="st_Suppliesid")
	public R_Supplies getSt_Suppliesid() {
		return st_Suppliesid;
	}
	public void setSt_Suppliesid(R_Supplies st_Suppliesid) {
		this.st_Suppliesid = st_Suppliesid;
	}
	@Column(length=20)
	public String getSt_Managedept() {
		return st_Managedept;
	}
	public void setSt_Managedept(String st_Managedept) {
		this.st_Managedept = st_Managedept;
	}
	@Column(length=50)
	public String getSt_Address() {
		return st_Address;
	}
	public void setSt_Address(String st_Address) {
		this.st_Address = st_Address;
	}
	@Column(length=10)
	public Double getSt_Longitude() {
		return st_Longitude;
	}
	public void setSt_Longitude(Double st_Longitude) {
		this.st_Longitude = st_Longitude;
	}
	@Column(length=10)
	public Double getSt_Latitude() {
		return st_Latitude;
	}
	public void setSt_Latitude(Double st_Latitude) {
		this.st_Latitude = st_Latitude;
	}
	@Column(length=20)
	public String getSt_Storetel() {
		return st_Storetel;
	}
	public void setSt_Storetel(String st_Storetel) {
		this.st_Storetel = st_Storetel;
	}
	@Column(length=10)
	public String getSt_Manageman() {
		return st_Manageman;
	}
	public void setSt_Manageman(String st_Manageman) {
		this.st_Manageman = st_Manageman;
	}
	@Column(length=20)
	public String getSt_Managemantel() {
		return st_Managemantel;
	}
	public void setSt_Managemantel(String st_Managemantel) {
		this.st_Managemantel = st_Managemantel;
	}
	public String getSt_Count() {
		return st_Count;
	}
	public void setSt_Count(String st_Count) {
		this.st_Count = st_Count;
	}
	public Date getSt_Storedate() {
		return st_Storedate;
	}
	public void setSt_Storedate(Date st_Storedate) {
		this.st_Storedate = st_Storedate;
	}
	@ManyToOne
	@JoinColumn(name="st_Recordman")
	public T_User_Info getSt_Recordman() {
		return st_Recordman;
	}
	public void setSt_Recordman(T_User_Info st_Recordman) {
		this.st_Recordman = st_Recordman;
	}
	public Date getSt_Recorddate() {
		return st_Recorddate;
	}
	public void setSt_Recorddate(Date st_Recorddate) {
		this.st_Recorddate = st_Recorddate;
	}
	
}
