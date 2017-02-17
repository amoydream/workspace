package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResBazaarVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = -4222097316973684918L;
	
	private Integer ba_Id;
	/**
	 * 庇护所名称
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
	 * 备注
	 */
	private String ba_Remark;
	/**
	 * 所属单位
	 */
	private String ba_Dept;
	/**
	 * 经营范围
	 */
	private String ba_Workarea;
	public Integer getBa_Id() {
		return ba_Id;
	}
	public void setBa_Id(Integer ba_Id) {
		this.ba_Id = ba_Id;
	}
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
	public String getBa_Longitude() {
		return ba_Longitude;
	}
	public void setBa_Longitude(String ba_Longitude) {
		this.ba_Longitude = ba_Longitude;
	}
	public String getBa_Latitude() {
		return ba_Latitude;
	}
	public void setBa_Latitude(String ba_Latitude) {
		this.ba_Latitude = ba_Latitude;
	}
	public String getBa_Linkman() {
		return ba_Linkman;
	}
	public void setBa_Linkman(String ba_Linkman) {
		this.ba_Linkman = ba_Linkman;
	}
	public String getBa_Linkmantel() {
		return ba_Linkmantel;
	}
	public void setBa_Linkmantel(String ba_Linkmantel) {
		this.ba_Linkmantel = ba_Linkmantel;
	}
	public String getBa_Remark() {
		return ba_Remark;
	}
	public void setBa_Remark(String ba_Remark) {
		this.ba_Remark = ba_Remark;
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