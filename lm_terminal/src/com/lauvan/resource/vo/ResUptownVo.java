package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResUptownVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 8568588303043655781L;
	
	private Integer up_Id;
	/**
	 * 名称
	 */
	private String up_Name;
	/**
	 * 容纳人数
	 */
	private Integer up_Galleryful;
	/**
	 * 地址
	 */
	private String up_Address;
	/**
	 * 占地面积
	 */
	private String up_Area;
	/**
	 * 经度
	 */
	private String up_Longitude;
	/**
	 * 纬度
	 */
	private String up_Latitude;
	/**
	 * 联系人
	 */
	private String up_Linkman;
	/**
	 * 联系人电话
	 */
	private String up_Linkmantel;
	/**
	 * 所属单位
	 */
	private String up_Dept;
	public Integer getUp_Id() {
		return up_Id;
	}
	public void setUp_Id(Integer up_Id) {
		this.up_Id = up_Id;
	}
	public String getUp_Name() {
		return up_Name;
	}
	public void setUp_Name(String up_Name) {
		this.up_Name = up_Name;
	}
	public Integer getUp_Galleryful() {
		return up_Galleryful;
	}
	public void setUp_Galleryful(Integer up_Galleryful) {
		this.up_Galleryful = up_Galleryful;
	}
	public String getUp_Address() {
		return up_Address;
	}
	public void setUp_Address(String up_Address) {
		this.up_Address = up_Address;
	}
	public String getUp_Area() {
		return up_Area;
	}
	public void setUp_Area(String up_Area) {
		this.up_Area = up_Area;
	}
	public String getUp_Longitude() {
		return up_Longitude;
	}
	public void setUp_Longitude(String up_Longitude) {
		this.up_Longitude = up_Longitude;
	}
	public String getUp_Latitude() {
		return up_Latitude;
	}
	public void setUp_Latitude(String up_Latitude) {
		this.up_Latitude = up_Latitude;
	}
	public String getUp_Linkman() {
		return up_Linkman;
	}
	public void setUp_Linkman(String up_Linkman) {
		this.up_Linkman = up_Linkman;
	}
	public String getUp_Linkmantel() {
		return up_Linkmantel;
	}
	public void setUp_Linkmantel(String up_Linkmantel) {
		this.up_Linkmantel = up_Linkmantel;
	}
	public String getUp_Dept() {
		return up_Dept;
	}
	public void setUp_Dept(String up_Dept) {
		this.up_Dept = up_Dept;
	}
	
}
