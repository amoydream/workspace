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


@Entity
@Table(name = "c_position")
@DynamicInsert(true)
@DynamicUpdate(true)
public class C_Position implements Serializable{
	
	private static final long serialVersionUID = 598778093256787L;
	
	private Integer p_id;
	 /**
	 * 岗位名称
	 */
	private String p_name;
	private C_Position_Classification positionClassification;

	public C_Position() {
		super();
	}
	public C_Position(Integer p_id) {
		super();
		this.p_id = p_id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)	
	public Integer getP_id() {
		return p_id;
	}
	public void setP_id(Integer p_id) {
		this.p_id = p_id;
	}
	
	
	@Column(length=50,nullable=false)
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	
	@ManyToOne
	@JoinColumn(name="pcid",nullable=false)
	public C_Position_Classification getPositionClassification() {
		return positionClassification;
	}
	public void setPositionClassification(
			C_Position_Classification positionClassification) {
		this.positionClassification = positionClassification;
	}
	
	
}
