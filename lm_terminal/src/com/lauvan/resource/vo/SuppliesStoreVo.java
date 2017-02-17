package com.lauvan.resource.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;
import com.lauvan.system.entity.T_User_Info;

public class SuppliesStoreVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = -8772794928295127392L;
	
	private Integer st_Id;
	/**
	 * 物资Id
	 */
	private Integer st_Suppliesid;
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
	 * 存放日期
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
	
	public Integer getSt_Id() {
		return st_Id;
	}
	public void setSt_Id(Integer st_Id) {
		this.st_Id = st_Id;
	}
	public Integer getSt_Suppliesid() {
		return st_Suppliesid;
	}
	public void setSt_Suppliesid(Integer st_Suppliesid) {
		this.st_Suppliesid = st_Suppliesid;
	}
	public String getSt_Managedept() {
		return st_Managedept;
	}
	public void setSt_Managedept(String st_Managedept) {
		this.st_Managedept = st_Managedept;
	}
	public String getSt_Address() {
		return st_Address;
	}
	public void setSt_Address(String st_Address) {
		this.st_Address = st_Address;
	}
	public Double getSt_Longitude() {
		return st_Longitude;
	}
	public void setSt_Longitude(Double st_Longitude) {
		this.st_Longitude = st_Longitude;
	}
	public Double getSt_Latitude() {
		return st_Latitude;
	}
	public void setSt_Latitude(Double st_Latitude) {
		this.st_Latitude = st_Latitude;
	}
	public String getSt_Storetel() {
		return st_Storetel;
	}
	public void setSt_Storetel(String st_Storetel) {
		this.st_Storetel = st_Storetel;
	}
	public String getSt_Manageman() {
		return st_Manageman;
	}
	public void setSt_Manageman(String st_Manageman) {
		this.st_Manageman = st_Manageman;
	}
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
