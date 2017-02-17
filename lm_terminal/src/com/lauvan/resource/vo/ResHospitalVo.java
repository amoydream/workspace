package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResHospitalVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 3764020124597135917L;
	
	private Integer ho_Id;
	/**
	 * 名称
	 */
	private String ho_Name;
	/**
	 * 类型
	 */
	private String ho_Type;
	/**
	 * 地址
	 */
	private String ho_Address;
	/**
	 * 经度
	 */
	private String ho_Longitude;
	/**
	 * 纬度
	 */
	private String ho_Latitude;
	/**
	 * 联系人
	 */
	private String ho_Linkman;
	/**
	 * 联系人电话
	 */
	private String ho_Linkmantel;
	/**
	 * 院长姓名
	 */
	private String ho_Dean;
	/**
	 * 院长电话
	 */
	private String ho_Deantel;
	/**
	 * 办公室电话
	 */
	private String ho_Officetel;
	/**
	 * 床位数
	 */
	private Integer ho_Bednum;
	/**
	 * 职工人数
	 */
	private Integer ho_Workernum;
	/**
	 * 设备
	 */
	private String ho_Equipment;
	public Integer getHo_Id() {
		return ho_Id;
	}
	public void setHo_Id(Integer ho_Id) {
		this.ho_Id = ho_Id;
	}
	public String getHo_Name() {
		return ho_Name;
	}
	public void setHo_Name(String ho_Name) {
		this.ho_Name = ho_Name;
	}
	public String getHo_Type() {
		return ho_Type;
	}
	public void setHo_Type(String ho_Type) {
		this.ho_Type = ho_Type;
	}
	public String getHo_Address() {
		return ho_Address;
	}
	public void setHo_Address(String ho_Address) {
		this.ho_Address = ho_Address;
	}
	public String getHo_Longitude() {
		return ho_Longitude;
	}
	public void setHo_Longitude(String ho_Longitude) {
		this.ho_Longitude = ho_Longitude;
	}
	public String getHo_Latitude() {
		return ho_Latitude;
	}
	public void setHo_Latitude(String ho_Latitude) {
		this.ho_Latitude = ho_Latitude;
	}
	public String getHo_Linkman() {
		return ho_Linkman;
	}
	public void setHo_Linkman(String ho_Linkman) {
		this.ho_Linkman = ho_Linkman;
	}
	public String getHo_Linkmantel() {
		return ho_Linkmantel;
	}
	public void setHo_Linkmantel(String ho_Linkmantel) {
		this.ho_Linkmantel = ho_Linkmantel;
	}
	public String getHo_Dean() {
		return ho_Dean;
	}
	public void setHo_Dean(String ho_Dean) {
		this.ho_Dean = ho_Dean;
	}
	public String getHo_Deantel() {
		return ho_Deantel;
	}
	public void setHo_Deantel(String ho_Deantel) {
		this.ho_Deantel = ho_Deantel;
	}
	public String getHo_Officetel() {
		return ho_Officetel;
	}
	public void setHo_Officetel(String ho_Officetel) {
		this.ho_Officetel = ho_Officetel;
	}
	public Integer getHo_Bednum() {
		return ho_Bednum;
	}
	public void setHo_Bednum(Integer ho_Bednum) {
		this.ho_Bednum = ho_Bednum;
	}
	public Integer getHo_Workernum() {
		return ho_Workernum;
	}
	public void setHo_Workernum(Integer ho_Workernum) {
		this.ho_Workernum = ho_Workernum;
	}
	public String getHo_Equipment() {
		return ho_Equipment;
	}
	public void setHo_Equipment(String ho_Equipment) {
		this.ho_Equipment = ho_Equipment;
	}
	
	

}
