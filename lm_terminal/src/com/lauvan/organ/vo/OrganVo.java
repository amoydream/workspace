package com.lauvan.organ.vo;

import com.lauvan.base.vo.BaseVo;

/**
 * ClassName: C_Organ
 * 
 * @Description: 组织机构
 * @author 钮炜炜
 * @date 2015年12月1日 上午8:42:29
 */
public class OrganVo extends BaseVo {
	private static final long	serialVersionUID	= -8732787817770021641L;
	private Integer				or_id;
	/**
	 * 机构名称
	 */
	private String				or_name;
	/**
	 * 机构简称
	 */
	private String				or_sname;
	/**
	 * 英文名称
	 */
	private String				or_englishname;
	/**
	 * 序号
	 */
	private Integer				or_no;
	/**
	 * 邮编
	 */
	private String				or_zipcode;
	/**
	 * 地址
	 */
	private String				or_address;
	/**
	 * 经度
	 */
	private Double				or_longitude;
	/**
	 * 纬度
	 */
	private Double				or_latitude;
	private Integer				pid;
	/**
	 * 办公电话
	 */
	private String				officephone;
	/**
	 * 传真
	 */
	private String				fax;
	/**
	 * 邮箱
	 */
	private String				email;
	/**
	 * 是否应急组织（0：否，1：是）
	 */
	private String				or_type;
	private Integer				or_sort;
	private Integer				or_sort_old;

	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	public String getOr_sname() {
		return or_sname;
	}

	public void setOr_sname(String or_sname) {
		this.or_sname = or_sname;
	}

	public String getOr_englishname() {
		return or_englishname;
	}

	public void setOr_englishname(String or_englishname) {
		this.or_englishname = or_englishname;
	}

	public Integer getOr_no() {
		return or_no;
	}

	public void setOr_no(Integer or_no) {
		this.or_no = or_no;
	}

	public String getOr_zipcode() {
		return or_zipcode;
	}

	public void setOr_zipcode(String or_zipcode) {
		this.or_zipcode = or_zipcode;
	}

	public String getOr_address() {
		return or_address;
	}

	public void setOr_address(String or_address) {
		this.or_address = or_address;
	}

	public Double getOr_longitude() {
		return or_longitude;
	}

	public void setOr_longitude(Double or_longitude) {
		this.or_longitude = or_longitude;
	}

	public Double getOr_latitude() {
		return or_latitude;
	}

	public void setOr_latitude(Double or_latitude) {
		this.or_latitude = or_latitude;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Integer getOr_id() {
		return or_id;
	}

	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}

	public String getOfficephone() {
		return officephone;
	}

	public void setOfficephone(String officephone) {
		this.officephone = officephone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getOr_type() {
		return or_type;
	}

	public void setOr_type(String or_type) {
		this.or_type = or_type;
	}

	public Integer getOr_sort() {
		return or_sort;
	}

	public void setOr_sort(Integer or_sort) {
		this.or_sort = or_sort;
	}

	public Integer getOr_sort_old() {
		return or_sort_old;
	}

	public void setOr_sort_old(Integer or_sort_old) {
		this.or_sort_old = or_sort_old;
	}
}
