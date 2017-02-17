package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResSquareVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 3491262990142532802L;
	
	private Integer sq_Id;
	/**
	 * 庇护所名称
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
	/**
	 * 备注
	 */
	private String sq_Remark;
	public Integer getSq_Id() {
		return sq_Id;
	}
	public void setSq_Id(Integer sq_Id) {
		this.sq_Id = sq_Id;
	}
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
	public String getSq_Longitude() {
		return sq_Longitude;
	}
	public void setSq_Longitude(String sq_Longitude) {
		this.sq_Longitude = sq_Longitude;
	}
	public String getSq_Latitude() {
		return sq_Latitude;
	}
	public void setSq_Latitude(String sq_Latitude) {
		this.sq_Latitude = sq_Latitude;
	}
	public String getSq_Linkman() {
		return sq_Linkman;
	}
	public void setSq_Linkman(String sq_Linkman) {
		this.sq_Linkman = sq_Linkman;
	}
	public String getSq_Linkmantel() {
		return sq_Linkmantel;
	}
	public void setSq_Linkmantel(String sq_Linkmantel) {
		this.sq_Linkmantel = sq_Linkmantel;
	}
	public String getSq_Remark() {
		return sq_Remark;
	}
	public void setSq_Remark(String sq_Remark) {
		this.sq_Remark = sq_Remark;
	}
	
	
	
	

}