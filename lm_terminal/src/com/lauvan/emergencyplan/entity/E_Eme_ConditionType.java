package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: E_Eme_EventType 
 * @Description: 预案状况分类
 * @author 钮炜炜
 * @date 2015年12月12日 上午10:44:43
 */
@Entity
@Table(name = "e_eme_conditiontype")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Eme_ConditionType implements Serializable{

	private static final long serialVersionUID = -2728998348392683302L;
	private Integer eec_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 状况名称
	 */
	private String eec_name;
	/**
	 * 描述
	 */
	private String eec_desc;
	
	@Id
	public Integer getEec_id() {
		return eec_id;
	}
	public void setEec_id(Integer eec_id) {
		this.eec_id = eec_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@Column(length=100)
	public String getEec_name() {
		return eec_name;
	}
	public void setEec_name(String eec_name) {
		this.eec_name = eec_name;
	}
	@Column(length=500)
	public String getEec_desc() {
		return eec_desc;
	}
	public void setEec_desc(String eec_desc) {
		this.eec_desc = eec_desc;
	}
	
}
