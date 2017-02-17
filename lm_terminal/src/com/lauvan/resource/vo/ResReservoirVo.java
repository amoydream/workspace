package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResReservoirVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 265983916274452491L;
	
	private Integer re_Id;
	/**
	 * 名称
	 */
	private String re_Name;
	/**
	 * 地址
	 */
	private String re_Address;
	/**
	 * 占地面积
	 */
	private String re_Area;
	/**
	 * 经度
	 */
	private String re_Longitude;
	/**
	 * 纬度
	 */
	private String re_Latitude;
	/**
	 * 联系人
	 */
	private String re_Linkman;
	/**
	 * 联系人电话
	 */
	private String re_Linkmantel;
	/**
	 * 所属单位
	 */
	private String re_Dept;
	/**
	 * 储水量
	 */
	private String re_Capacity;
	public Integer getRe_Id() {
		return re_Id;
	}
	public void setRe_Id(Integer re_Id) {
		this.re_Id = re_Id;
	}
	public String getRe_Name() {
		return re_Name;
	}
	public void setRe_Name(String re_Name) {
		this.re_Name = re_Name;
	}
	public String getRe_Address() {
		return re_Address;
	}
	public void setRe_Address(String re_Address) {
		this.re_Address = re_Address;
	}
	public String getRe_Area() {
		return re_Area;
	}
	public void setRe_Area(String re_Area) {
		this.re_Area = re_Area;
	}
	public String getRe_Longitude() {
		return re_Longitude;
	}
	public void setRe_Longitude(String re_Longitude) {
		this.re_Longitude = re_Longitude;
	}
	public String getRe_Latitude() {
		return re_Latitude;
	}
	public void setRe_Latitude(String re_Latitude) {
		this.re_Latitude = re_Latitude;
	}
	public String getRe_Linkman() {
		return re_Linkman;
	}
	public void setRe_Linkman(String re_Linkman) {
		this.re_Linkman = re_Linkman;
	}
	public String getRe_Linkmantel() {
		return re_Linkmantel;
	}
	public void setRe_Linkmantel(String re_Linkmantel) {
		this.re_Linkmantel = re_Linkmantel;
	}
	public String getRe_Dept() {
		return re_Dept;
	}
	public void setRe_Dept(String re_Dept) {
		this.re_Dept = re_Dept;
	}
	public String getRe_Capacity() {
		return re_Capacity;
	}
	public void setRe_Capacity(String re_Capacity) {
		this.re_Capacity = re_Capacity;
	}
	
	

}
