package com.lauvan.emergencyplan.entity;

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
 * 
 * ClassName: E_Emeeogan 
 * @Description: 应急组织机构
 * @autheo 钮炜炜
 * @date 2015年12月1日 上午8:42:29
 */
@Entity
@Table(name = "e_emeorgan")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_EmeOrgan implements Serializable{

	private static final long serialVersionUID = -8620918327379117953L;
	private Integer eo_id;
	/**
	 * 机构名称
	 */
	private String eo_name;
	/**
	 * 机构简称
	 */
	private String eo_sname;
	/**
	 * 英文名称
	 */
	private String eo_englishname;
	/**
	 * 序号
	 */
	private Integer eo_no;
	/**
	 * 邮编
	 */
	private String eo_zipcode;
	/**
	 * 地址
	 */
	private String eo_address;
	/**
	 * 经度
	 */
	private Double eo_longitude;
	/**
	 * 纬度
	 */
	private Double eo_latitude;
	private E_EmeOrgan organ;
	
	public E_EmeOrgan() {
		super();
	}
	public E_EmeOrgan(Integer eo_id) {
		super();
		this.eo_id = eo_id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEo_id() {
		return eo_id;
	}
	public void setEo_id(Integer eo_id) {
		this.eo_id = eo_id;
	}
	@Column(length=50,nullable=false)
	public String getEo_name() {
		return eo_name;
	}
	public void setEo_name(String eo_name) {
		this.eo_name = eo_name;
	}
	@Column(length=20)
	public String getEo_sname() {
		return eo_sname;
	}
	public void setEo_sname(String eo_sname) {
		this.eo_sname = eo_sname;
	}
	@Column(length=10)
	public String getEo_zipcode() {
		return eo_zipcode;
	}
	public void setEo_zipcode(String eo_zipcode) {
		this.eo_zipcode = eo_zipcode;
	}
	public Double getEo_longitude() {
		return eo_longitude;
	}
	public void setEo_longitude(Double eo_longitude) {
		this.eo_longitude = eo_longitude;
	}
	public Double getEo_latitude() {
		return eo_latitude;
	}
	public void setEo_latitude(Double eo_latitude) {
		this.eo_latitude = eo_latitude;
	}
	@ManyToOne
	@JoinColumn(name = "pid")
	public E_EmeOrgan getOrgan() {
		return organ;
	}
	public void setOrgan(E_EmeOrgan organ) {
		this.organ = organ;
	}
	@Column(length=100)
	public String getEo_address() {
		return eo_address;
	}
	public void setEo_address(String eo_address) {
		this.eo_address = eo_address;
	}
	@Column(length=100)
	public String getEo_englishname() {
		return eo_englishname;
	}
	public void setEo_englishname(String eo_englishname) {
		this.eo_englishname = eo_englishname;
	}
	public Integer getEo_no() {
		return eo_no;
	}
	public void setEo_no(Integer eo_no) {
		this.eo_no = eo_no;
	}
}
