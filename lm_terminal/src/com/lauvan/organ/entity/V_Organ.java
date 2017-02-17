package com.lauvan.organ.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "v_organ")
public class V_Organ implements Serializable {
	private static final long	serialVersionUID	= -8620918327379117953L;
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
	private V_Organ				organ;
	/**
	 * 是否应急组织（0：否，1：是）
	 */
	private String				or_type;
	private Integer				or_sort;
	private String				oo_sort;

	public V_Organ() {
		super();
	}

	public V_Organ(Integer or_id) {
		super();
		this.or_id = or_id;
	}

	@Id
	public Integer getOr_id() {
		return or_id;
	}

	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}

	@Column
	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	@Column
	public String getOr_sname() {
		return or_sname;
	}

	public void setOr_sname(String or_sname) {
		this.or_sname = or_sname;
	}

	@Column
	public String getOr_zipcode() {
		return or_zipcode;
	}

	public void setOr_zipcode(String or_zipcode) {
		this.or_zipcode = or_zipcode;
	}

	@Column
	public Double getOr_longitude() {
		return or_longitude;
	}

	public void setOr_longitude(Double or_longitude) {
		this.or_longitude = or_longitude;
	}

	@Column
	public Double getOr_latitude() {
		return or_latitude;
	}

	public void setOr_latitude(Double or_latitude) {
		this.or_latitude = or_latitude;
	}

	@ManyToOne
	@JoinColumn(name = "pid")
	public V_Organ getOrgan() {
		return organ;
	}

	public void setOrgan(V_Organ organ) {
		this.organ = organ;
	}

	@Column
	public String getOr_address() {
		return or_address;
	}

	public void setOr_address(String or_address) {
		this.or_address = or_address;
	}

	@Column
	public String getOr_englishname() {
		return or_englishname;
	}

	public void setOr_englishname(String or_englishname) {
		this.or_englishname = or_englishname;
	}

	@Column
	public Integer getOr_no() {
		return or_no;
	}

	public void setOr_no(Integer or_no) {
		this.or_no = or_no;
	}

	@Column
	public String getOr_type() {
		return or_type;
	}

	public void setOr_type(String or_type) {
		this.or_type = or_type;
	}

	@Column
	public Integer getOr_sort() {
		return or_sort;
	}

	public void setOr_sort(Integer or_sort) {
		this.or_sort = or_sort;
	}

	@Column
	public String getOo_sort() {
		return oo_sort;
	}

	public void setOo_sort(String oo_sort) {
		this.oo_sort = oo_sort;
	}
}
