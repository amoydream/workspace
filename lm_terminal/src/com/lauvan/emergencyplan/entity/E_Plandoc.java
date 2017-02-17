package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
/**
 * 
 * ClassName: E_Plandoc 
 * @Description: 预案附件
 * @author 钮炜炜
 * @date 2016年4月24日 下午4:08:46
 */
@Entity
@Table(name = "e_plandoc")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Plandoc implements Serializable{

	private static final long serialVersionUID = 6330291351495205823L;
	private Integer pdoc_id;
	private Integer pi_id;
	
	private String pdoc_name;
	private String pdoc_desc;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getPdoc_id() {
		return pdoc_id;
	}
	public void setPdoc_id(Integer pdoc_id) {
		this.pdoc_id = pdoc_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@Column(length=100)
	public String getPdoc_name() {
		return pdoc_name;
	}
	public void setPdoc_name(String pdoc_name) {
		this.pdoc_name = pdoc_name;
	}
	@Column(length=200)
	public String getPdoc_desc() {
		return pdoc_desc;
	}
	public void setPdoc_desc(String pdoc_desc) {
		this.pdoc_desc = pdoc_desc;
	}
}
