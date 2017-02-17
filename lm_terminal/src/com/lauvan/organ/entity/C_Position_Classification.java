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
@Table(name = "c_position_classification")
@DynamicInsert(true)
@DynamicUpdate(true)
public class C_Position_Classification implements Serializable{
	
	private static final long serialVersionUID = 698318765735913L;
	
	private Integer pc_id;
//	岗位分类
	private String pc_name;
	
	private C_Position_Classification pid;
	
	public C_Position_Classification() {
		
	}	
    public C_Position_Classification(Integer pc_id) {
		    this.pc_id = pc_id;
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)	
	public Integer getPc_id() {
		return pc_id;
	}
	public void setPc_id(Integer pc_id) {
		this.pc_id = pc_id;
	}
	@Column(length=50,nullable=false)
	public String getPc_name() {
		return pc_name;
	}
	public void setPc_name(String pc_name) {
		this.pc_name = pc_name;
	}
	@ManyToOne
	@JoinColumn(name="pid")
	public C_Position_Classification getPid() {
		return pid;
	}
	public void setPid(C_Position_Classification pid) {
		this.pid = pid;
	}  
	
	
}
