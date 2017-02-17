package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ResCompanyVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = -9190462499679051597L;
	
	private Integer co_Id;
	/**
	 * 名称
	 */
	private String co_Name;
	/**
	 * 地址
	 */
	private String co_Address;
	/**
	 * 经度
	 */
	private String co_Longitude;
	/**
	 * 纬度
	 */
	private String co_Latitude;
	/**
	 * 联系人
	 */
	private String co_Linkman;
	/**
	 * 联系人电话
	 */
	private String co_Linkmantel;
	/**
	 * 经营范围
	 */
	private String co_Workarea;
	/**
	 * 主要产品
	 */
	private String co_Product;
	/**
	 * 员工数
	 */
	private Integer co_Workernum;
	/**
	 * 法人
	 */
	private String co_Legalman;
	/**
	 * 负责人
	 */
	private String co_Director;
	/**
	 * 负责人电话
	 */
	private String co_Directortel;
	/**
	 * 经济类型
	 */
	private String co_Type;
	public Integer getCo_Id() {
		return co_Id;
	}
	public void setCo_Id(Integer co_Id) {
		this.co_Id = co_Id;
	}
	public String getCo_Name() {
		return co_Name;
	}
	public void setCo_Name(String co_Name) {
		this.co_Name = co_Name;
	}
	public String getCo_Address() {
		return co_Address;
	}
	public void setCo_Address(String co_Address) {
		this.co_Address = co_Address;
	}
	public String getCo_Longitude() {
		return co_Longitude;
	}
	public void setCo_Longitude(String co_Longitude) {
		this.co_Longitude = co_Longitude;
	}
	public String getCo_Latitude() {
		return co_Latitude;
	}
	public void setCo_Latitude(String co_Latitude) {
		this.co_Latitude = co_Latitude;
	}
	public String getCo_Linkman() {
		return co_Linkman;
	}
	public void setCo_Linkman(String co_Linkman) {
		this.co_Linkman = co_Linkman;
	}
	public String getCo_Linkmantel() {
		return co_Linkmantel;
	}
	public void setCo_Linkmantel(String co_Linkmantel) {
		this.co_Linkmantel = co_Linkmantel;
	}
	public String getCo_Workarea() {
		return co_Workarea;
	}
	public void setCo_Workarea(String co_Workarea) {
		this.co_Workarea = co_Workarea;
	}
	public String getCo_Product() {
		return co_Product;
	}
	public void setCo_Product(String co_Product) {
		this.co_Product = co_Product;
	}
	public Integer getCo_Workernum() {
		return co_Workernum;
	}
	public void setCo_Workernum(Integer co_Workernum) {
		this.co_Workernum = co_Workernum;
	}
	public String getCo_Legalman() {
		return co_Legalman;
	}
	public void setCo_Legalman(String co_Legalman) {
		this.co_Legalman = co_Legalman;
	}
	public String getCo_Director() {
		return co_Director;
	}
	public void setCo_Director(String co_Director) {
		this.co_Director = co_Director;
	}
	public String getCo_Directortel() {
		return co_Directortel;
	}
	public void setCo_Directortel(String co_Directortel) {
		this.co_Directortel = co_Directortel;
	}
	public String getCo_Type() {
		return co_Type;
	}
	public void setCo_Type(String co_Type) {
		this.co_Type = co_Type;
	}
	
	

}
