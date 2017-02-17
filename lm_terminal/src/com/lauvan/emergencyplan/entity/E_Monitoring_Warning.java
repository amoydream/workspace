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
 * 监测预警信息
 * ClassName: E_Monitoring_warning 
 * @Description: 监测预警信息
 * @author 钮炜炜
 * @date 2015年12月22日 下午2:35:32
 */
@Entity
@Table(name = "e_monitoring_warning")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Monitoring_Warning implements Serializable{

	private static final long serialVersionUID = -3277097528784771609L;
	private Integer emw_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 监测信息名称
	 */
	private String emw_name;
	/**
	 * 检测部门
	 */
	private E_EmeOrgan emeOrgan;
	/**
	 * 检测内容
	 */
	private String emw_content;
	/**
	 * 说明
	 */
	private String emw_note;
	/**
	 * 备注
	 */
	private String emw_remark;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getEmw_id() {
		return emw_id;
	}
	public void setEmw_id(Integer emw_id) {
		this.emw_id = emw_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@Column(length = 50, nullable = false)
	public String getEmw_name() {
		return emw_name;
	}
	public void setEmw_name(String emw_name) {
		this.emw_name = emw_name;
	}
	@ManyToOne
	@JoinColumn(name = "eo_id")
	public E_EmeOrgan getEmeOrgan() {
		return emeOrgan;
	}
	public void setEmeOrgan(E_EmeOrgan emeOrgan) {
		this.emeOrgan = emeOrgan;
	}
	@Column(length = 200)
	public String getEmw_content() {
		return emw_content;
	}
	public void setEmw_content(String emw_content) {
		this.emw_content = emw_content;
	}
	@Column(length = 200)
	public String getEmw_note() {
		return emw_note;
	}
	public void setEmw_note(String emw_note) {
		this.emw_note = emw_note;
	}
	@Column(length = 200)
	public String getEmw_remark() {
		return emw_remark;
	}
	public void setEmw_remark(String emw_remark) {
		this.emw_remark = emw_remark;
	}
}
