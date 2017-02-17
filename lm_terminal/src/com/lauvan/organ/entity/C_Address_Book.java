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
 * 
 * ClassName: C_Address_Book 
 * @Description: 通讯录
 * @author 钮炜炜
 * @date 2015年12月1日 上午9:49:29
 */
@Entity
@Table(name = "c_address_book")
@DynamicInsert(true)
@DynamicUpdate(true)
public class C_Address_Book implements Serializable{

	private static final long serialVersionUID = -1845058613712959145L;
	private Integer bo_id;
	/**
	 * 组织人员
	 */
	private C_Organ_Person person;
	/**
	 * 组织
	 */
	private C_Organ organ;
	/**
	 * 通讯类型
	 */
	private String bo_type;
	/**
	 * 用户类型（1：个人，2：单位）
	 */
	private String bo_usertype;
	/**
	 * 排序
	 */
	private Integer bo_index;
	/**
	 * 通讯号码
	 */
	private String bo_number;
	/**
	 * 状态（0：启用，1：停用）
	 */
	private String bo_state;
	/**
	 * 备注
	 */
	private String bo_remark;
	
	public C_Address_Book() {
		super();
	}
	public C_Address_Book(Integer bo_id) {
		super();
		this.bo_id = bo_id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getBo_id() {
		return bo_id;
	}
	public void setBo_id(Integer bo_id) {
		this.bo_id = bo_id;
	}
	@ManyToOne
	@JoinColumn(name="pe_id")
	public C_Organ_Person getPerson() {
		return person;
	}
	public void setPerson(C_Organ_Person person) {
		this.person = person;
	}
	@ManyToOne
	@JoinColumn(name="or_id")
	public C_Organ getOrgan() {
		return organ;
	}
	public void setOrgan(C_Organ organ) {
		this.organ = organ;
	}
	@Column(length=1)
	public String getBo_type() {
		return bo_type;
	}
	public void setBo_type(String bo_type) {
		this.bo_type = bo_type;
	}
	public Integer getBo_index() {
		return bo_index;
	}
	public void setBo_index(Integer bo_index) {
		this.bo_index = bo_index;
	}
	@Column(length=20,nullable=false)
	public String getBo_number() {
		return bo_number;
	}
	public void setBo_number(String bo_number) {
		this.bo_number = bo_number;
	}
	@Column(length=1,nullable=false)
	public String getBo_state() {
		return bo_state;
	}
	public void setBo_state(String bo_state) {
		this.bo_state = bo_state;
	}
	@Column(length=100)
	public String getBo_remark() {
		return bo_remark;
	}
	public void setBo_remark(String bo_remark) {
		this.bo_remark = bo_remark;
	}
	@Column(length=1)
	public String getBo_usertype() {
		return bo_usertype;
	}
	public void setBo_usertype(String bo_usertype) {
		this.bo_usertype = bo_usertype;
	}
}
