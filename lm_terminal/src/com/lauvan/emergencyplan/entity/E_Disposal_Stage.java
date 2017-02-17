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
 * ClassName: E_Disposal_Stage 
 * @Description: 预案应急处置阶段流程表
 * @author 钮炜炜
 * @date 2015年12月12日 下午2:13:29
 */
@Entity
@Table(name = "e_disposal_stage")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Disposal_Stage implements Serializable{

	private static final long serialVersionUID = 946423769832184572L;
	private Integer eds_id;
	/**
	 * 阶段名称
	 */
	private String eds_name;
	/**
	 * 执行序号
	 */
	private Integer eds_index;
	/**
	 * 任务说明
	 */
	private String eds_task;
	/**
	 * 备注
	 */
	private String eds_remark;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	
	private E_Disposal_Stage dStage;
	
	public E_Disposal_Stage() {
		super();
	}
	public E_Disposal_Stage(Integer eds_id) {
		super();
		this.eds_id = eds_id;
	}
	@Id
	public Integer getEds_id() {
		return eds_id;
	}
	public void setEds_id(Integer eds_id) {
		this.eds_id = eds_id;
	}
	
	@Column(length=100,nullable=false)
	public String getEds_name() {
		return eds_name;
	}
	public void setEds_name(String eds_name) {
		this.eds_name = eds_name;
	}
	public Integer getEds_index() {
		return eds_index;
	}
	public void setEds_index(Integer eds_index) {
		this.eds_index = eds_index;
	}
	@Column(length=500)
	public String getEds_task() {
		return eds_task;
	}
	public void setEds_task(String eds_task) {
		this.eds_task = eds_task;
	}
	@Column(length=200)
	public String getEds_remark() {
		return eds_remark;
	}
	public void setEds_remark(String eds_remark) {
		this.eds_remark = eds_remark;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@ManyToOne
	@JoinColumn(name = "eds_pid")
	public E_Disposal_Stage getdStage() {
		return dStage;
	}
	public void setdStage(E_Disposal_Stage dStage) {
		this.dStage = dStage;
	}
}
