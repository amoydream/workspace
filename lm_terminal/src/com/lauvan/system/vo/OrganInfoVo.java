package com.lauvan.system.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;
/**
 * 
 * ClassName: OrganInfoVo 
 * @Description: 组织
 * @author 钮炜炜
 * @date 2015年9月8日 上午11:37:46
 */
public class OrganInfoVo extends BaseVo implements Serializable{
	private static final long serialVersionUID = 9098623412189601115L;
	private Integer org_Id;
	/**
	 * 组织地址
	 */
	private String org_Adress;
	/**
	 * 组织职责
	 */
	private String org_Duties;
	/**
	 * 英文名
	 */
	private String org_Englishname;
	/**
	 * 纬度
	 */
	private Double org_Latitude;
	/**
	 * 经度
	 */
	private Double org_Longitude;
	/**
	 * 组织名称
	 */
	private String org_Name;
	/**
	 * 负责人
	 */
	private Integer org_Order;
	/**
	 * 简写
	 */
	private String org_Short;
	/**
	 * 邮政编码
	 */
	private String org_Zip;
	/**
	 * 父级ID
	 */
	private Integer org_Pid;
	/**
	 * 备注
	 */
	private String org_Remark;
	public Integer getOrg_Id() {
		return org_Id;
	}
	public void setOrg_Id(Integer org_Id) {
		this.org_Id = org_Id;
	}
	public String getOrg_Adress() {
		return org_Adress;
	}
	public void setOrg_Adress(String org_Adress) {
		this.org_Adress = org_Adress;
	}
	public String getOrg_Duties() {
		return org_Duties;
	}
	public void setOrg_Duties(String org_Duties) {
		this.org_Duties = org_Duties;
	}
	public String getOrg_Englishname() {
		return org_Englishname;
	}
	public void setOrg_Englishname(String org_Englishname) {
		this.org_Englishname = org_Englishname;
	}
	public Double getOrg_Latitude() {
		return org_Latitude;
	}
	public void setOrg_Latitude(Double org_Latitude) {
		this.org_Latitude = org_Latitude;
	}
	public Double getOrg_Longitude() {
		return org_Longitude;
	}
	public void setOrg_Longitude(Double org_Longitude) {
		this.org_Longitude = org_Longitude;
	}
	public String getOrg_Name() {
		return org_Name;
	}
	public void setOrg_Name(String org_Name) {
		this.org_Name = org_Name;
	}
	public Integer getOrg_Order() {
		return org_Order;
	}
	public void setOrg_Order(Integer org_Order) {
		this.org_Order = org_Order;
	}
	public String getOrg_Short() {
		return org_Short;
	}
	public void setOrg_Short(String org_Short) {
		this.org_Short = org_Short;
	}
	public String getOrg_Zip() {
		return org_Zip;
	}
	public void setOrg_Zip(String org_Zip) {
		this.org_Zip = org_Zip;
	}
	public Integer getOrg_Pid() {
		return org_Pid;
	}
	public void setOrg_Pid(Integer org_Pid) {
		this.org_Pid = org_Pid;
	}
	public String getOrg_Remark() {
		return org_Remark;
	}
	public void setOrg_Remark(String org_Remark) {
		this.org_Remark = org_Remark;
	}
}
