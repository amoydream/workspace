package com.lauvan.organ.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * ClassName: C_Organ
 * 
 * @Description: 组织机构
 * @author 钮炜炜
 * @date 2015年12月1日 上午8:42:29
 */
@Entity
@Table(name = "c_organ")
@DynamicInsert(true)
@DynamicUpdate(true)
public class C_Organ implements Serializable {
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
	private C_Organ				organ;
	/**
	 * 是否应急组织（0：否，1：是）
	 */
	private String				or_type;
	private Integer				or_sort;

	public C_Organ() {
		super();
	}

	public C_Organ(Integer or_id) {
		super();
		this.or_id = or_id;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getOr_id() {
		return or_id;
	}

	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}

	@Column(length = 50, nullable = false)
	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	@Column(length = 20)
	public String getOr_sname() {
		return or_sname;
	}

	public void setOr_sname(String or_sname) {
		this.or_sname = or_sname;
	}

	@Column(length = 10)
	public String getOr_zipcode() {
		return or_zipcode;
	}

	public void setOr_zipcode(String or_zipcode) {
		this.or_zipcode = or_zipcode;
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

	@ManyToOne
	@JoinColumn(name = "pid")
	public C_Organ getOrgan() {
		return organ;
	}

	public void setOrgan(C_Organ organ) {
		this.organ = organ;
	}

	@Column(length = 100)
	public String getOr_address() {
		return or_address;
	}

	public void setOr_address(String or_address) {
		this.or_address = or_address;
	}

	@Column(length = 100)
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

	@Column(length = 1)
	public String getOr_type() {
		return or_type;
	}

	public void setOr_type(String or_type) {
		this.or_type = or_type;
	}

	@Column(length = 11, nullable = false)
	public Integer getOr_sort() {
		return or_sort;
	}

	public void setOr_sort(Integer or_sort) {
		this.or_sort = or_sort;
	}
}
