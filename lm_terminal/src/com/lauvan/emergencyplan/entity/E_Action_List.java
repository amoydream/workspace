package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: E_Action_List 
 * @Description: 预案应急处置阶段流程-行动清单表
 * @author 钮炜炜
 * @date 2015年12月12日 下午2:22:07
 */
@Entity
@Table(name = "e_action_list")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Action_List implements Serializable {

	private static final long serialVersionUID = 7911991656030158402L;
	private Integer eal_id;
	/**
	 * 名称
	 */
	private String eal_name;
	/**
	 * 代号
	 */
	private String eal_no;
	/**
	 * 事件级别
	 */
	private String eal_level;
	/**
	 * 内容
	 */
	private String eal_content;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	
	private E_Disposal_Stage dStage;

	@Id
	public Integer getEal_id() {
		return eal_id;
	}

	public void setEal_id(Integer eal_id) {
		this.eal_id = eal_id;
	}
	@Column(length=100,nullable=false)
	public String getEal_name() {
		return eal_name;
	}

	public void setEal_name(String eal_name) {
		this.eal_name = eal_name;
	}
	@Column(length=10)
	public String getEal_no() {
		return eal_no;
	}

	public void setEal_no(String eal_no) {
		this.eal_no = eal_no;
	}
	@Column(length=1)
	public String getEal_level() {
		return eal_level;
	}

	public void setEal_level(String eal_level) {
		this.eal_level = eal_level;
	}
	@Column(length=500)
	public String getEal_content() {
		return eal_content;
	}

	public void setEal_content(String eal_content) {
		this.eal_content = eal_content;
	}

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@ManyToOne
	@JoinColumn(name = "eds_id")
	public E_Disposal_Stage getdStage() {
		return dStage;
	}

	public void setdStage(E_Disposal_Stage dStage) {
		this.dStage = dStage;
	}
}
