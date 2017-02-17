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
 * ClassName: E_Eme_Classification 
 * @Description: 预案事件分级
 * @author 钮炜炜
 * @date 2016年3月2日 下午4:44:06
 */
@Entity
@Table(name = "e_eme_classification")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Eme_Classification implements Serializable{

	private static final long serialVersionUID = 268693466127538595L;
	private Integer eec_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	private String eec_name;
	private String eec_type;
	private String eec_desc;
	private String eec_remark;
	
	@Id
	public Integer getEec_id() {
		return eec_id;
	}
	public void setEec_id(Integer eec_id) {
		this.eec_id = eec_id;
	}
	@Column(length=50)
	public String getEec_name() {
		return eec_name;
	}
	public void setEec_name(String eec_name) {
		this.eec_name = eec_name;
	}
	@Column(length=1)
	public String getEec_type() {
		return eec_type;
	}
	public void setEec_type(String eec_type) {
		this.eec_type = eec_type;
	}
	@Column(length=500)
	public String getEec_desc() {
		return eec_desc;
	}
	public void setEec_desc(String eec_desc) {
		this.eec_desc = eec_desc;
	}
	@Column(length=500)
	public String getEec_remark() {
		return eec_remark;
	}
	public void setEec_remark(String eec_remark) {
		this.eec_remark = eec_remark;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
}
