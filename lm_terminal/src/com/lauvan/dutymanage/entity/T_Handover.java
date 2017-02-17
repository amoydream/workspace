package com.lauvan.dutymanage.entity;

import java.util.Date;

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
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.organ.entity.C_Organ_Person;

@Entity
@Table(name = "t_handover")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Handover implements java.io.Serializable{
	
	private static final long serialVersionUID = 7457614943085069180L;
	private Integer ha_Id;
	/**
	 * 交班人
	 */
	private C_Organ_Person ha_Handman;
	/**
	 * 接班人
	 */
	private C_Organ_Person ha_Takeman;
	/**
	 * 交班时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date ha_Handdate;
	/**
	 * 接班时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date ha_Takedate;
	/**
	 * 交班备注
	 */
	private String ha_Remark;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getHa_Id() {
		return ha_Id;
	}
	public void setHa_Id(Integer ha_Id) {
		this.ha_Id = ha_Id;
	}
	@ManyToOne
	@JoinColumn(name="ha_Handman")
	public C_Organ_Person getHa_Handman() {
		return ha_Handman;
	}
	public void setHa_Handman(C_Organ_Person ha_Handman) {
		this.ha_Handman = ha_Handman;
	}
	@ManyToOne
	@JoinColumn(name="ha_Takeman")
	public C_Organ_Person getHa_Takeman() {
		return ha_Takeman;
	}
	public void setHa_Takeman(C_Organ_Person ha_Takeman) {
		this.ha_Takeman = ha_Takeman;
	}
	public Date getHa_Handdate() {
		return ha_Handdate;
	}
	public void setHa_Handdate(Date ha_Handdate) {
		this.ha_Handdate = ha_Handdate;
	}
	public Date getHa_Takedate() {
		return ha_Takedate;
	}
	public void setHa_Takedate(Date ha_Takedate) {
		this.ha_Takedate = ha_Takedate;
	}
	@Column(length=100)
	public String getHa_Remark() {
		return ha_Remark;
	}
	public void setHa_Remark(String ha_Remark) {
		this.ha_Remark = ha_Remark;
	}
	
	
}
