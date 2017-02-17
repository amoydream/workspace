package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResSupermarketVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 4431901913739901469L;
	
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
	public Integer getSu_Id() {
		return su_Id;
	}
	public void setSu_Id(Integer su_Id) {
		this.su_Id = su_Id;
	}
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
	public String getSu_Longitude() {
		return su_Longitude;
	}
	public void setSu_Longitude(String su_Longitude) {
		this.su_Longitude = su_Longitude;
	}
	public String getSu_Latitude() {
		return su_Latitude;
	}
	public void setSu_Latitude(String su_Latitude) {
		this.su_Latitude = su_Latitude;
	}
	public String getSu_Linkman() {
		return su_Linkman;
	}
	public void setSu_Linkman(String su_Linkman) {
		this.su_Linkman = su_Linkman;
	}
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
