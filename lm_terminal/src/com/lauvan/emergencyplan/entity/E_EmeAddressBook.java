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
 * ClassName: E_EmeAddressBook 
 * @Description: 通讯录
 * @author 钮炜炜
 * @date 2015年12月1日 上午9:49:29
 */
@Entity
@Table(name = "e_emeaddress_book")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_EmeAddressBook implements Serializable{

	private static final long serialVersionUID = -1845058613712959145L;
	private Integer eab_id;
	/**
	 * 组织人员
	 */
	private E_EmeOrganPerson person;
	/**
	 * 组织
	 */
	private E_EmeOrgan organ;
	/**
	 * 通讯类型
	 */
	private String eab_type;
	/**
	 * 用户类型（1：个人，2：单位）
	 */
	private String eab_usertype;
	/**
	 * 排序
	 */
	private Integer eab_index;
	/**
	 * 通讯号码
	 */
	private String eab_number;
	/**
	 * 状态（0：启用，1：停用）
	 */
	private String eab_state;
	/**
	 * 备注
	 */
	private String eab_remark;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEab_id() {
		return eab_id;
	}
	public void setEab_id(Integer eab_id) {
		this.eab_id = eab_id;
	}
	@ManyToOne
	@JoinColumn(name="pe_id")
	public E_EmeOrganPerson getPerson() {
		return person;
	}
	public void setPerson(E_EmeOrganPerson person) {
		this.person = person;
	}
	@ManyToOne
	@JoinColumn(name = "eo_id")
	public E_EmeOrgan getOrgan() {
		return organ;
	}

	public void setOrgan(E_EmeOrgan organ) {
		this.organ = organ;
	}
	@Column(length=1)
	public String getEab_type() {
		return eab_type;
	}
	public void setEab_type(String eab_type) {
		this.eab_type = eab_type;
	}
	public Integer getEab_index() {
		return eab_index;
	}
	public void setEab_index(Integer eab_index) {
		this.eab_index = eab_index;
	}
	@Column(length=20,nullable=false)
	public String getEab_number() {
		return eab_number;
	}
	public void setEab_number(String eab_number) {
		this.eab_number = eab_number;
	}
	@Column(length=1,nullable=false)
	public String getEab_state() {
		return eab_state;
	}
	public void setEab_state(String eab_state) {
		this.eab_state = eab_state;
	}
	@Column(length=100)
	public String getEab_remark() {
		return eab_remark;
	}
	public void setEab_remark(String eab_remark) {
		this.eab_remark = eab_remark;
	}
	@Column(length=1)
	public String getEab_usertype() {
		return eab_usertype;
	}
	public void setEab_usertype(String eab_usertype) {
		this.eab_usertype = eab_usertype;
	}
}
