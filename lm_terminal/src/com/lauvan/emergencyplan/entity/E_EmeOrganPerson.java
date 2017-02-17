package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.organ.entity.C_Organ_Person;

/**
 * 
 * ClassName: E_EmeOrganPerson
 * 
 * @Description: 应急组织人员表
 * @author 钮炜炜
 * @date 2015年12月1日 上午9:04:24
 */
@Entity
@Table(name = "e_emeorgan_person")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_EmeOrganPerson implements Serializable {

	private static final long serialVersionUID = 6727816383800956912L;
	private Integer eop_id;
	
	/**
	 * 所属应急组织
	 */
	private E_EmeOrgan organ;
	/**
	 * 组织人员
	 */
	private C_Organ_Person person;
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getEop_id() {
		return eop_id;
	}

	public void setEop_id(Integer eop_id) {
		this.eop_id = eop_id;
	}

	@ManyToOne
	@JoinColumn(name = "eo_id")
	public E_EmeOrgan getOrgan() {
		return organ;
	}

	public void setOrgan(E_EmeOrgan organ) {
		this.organ = organ;
	}

	@ManyToOne
	@JoinColumn(name = "pe_id")
	public C_Organ_Person getPerson() {
		return person;
	}

	public void setPerson(C_Organ_Person person) {
		this.person = person;
	}
}
