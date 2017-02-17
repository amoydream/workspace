package com.lauvan.emergencyplan.entity;

import java.io.Serializable;
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

import com.lauvan.system.entity.T_User_Info;
/**
 * 
 * ClassName: E_PlanType 
 * @Description: 预案类型
 * @author 钮炜炜
 * @date 2015年12月7日 上午11:15:56
 */
@Entity
@Table(name = "e_plantype")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_PlanType implements Serializable{

	private static final long serialVersionUID = -2518015326400503898L;
	private Integer pt_id;
	/**
	 * 名称
	 */
	private String pt_name;
	/**
	 * 描述
	 */
	private String pt_desc;
	/**
	 * 备注
	 */
	private String pt_remark;
	/**
	 * 父ID
	 */
	private E_PlanType planType;
	
	private T_User_Info user;
	private Date pt_createDate = new Date();
	
	public E_PlanType(Integer pt_id) {
		super();
		this.pt_id = pt_id;
	}
	public E_PlanType() {
		super();
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getPt_id() {
		return pt_id;
	}
	public void setPt_id(Integer pt_id) {
		this.pt_id = pt_id;
	}
	@Column(length=100,nullable=false)
	public String getPt_name() {
		return pt_name;
	}
	public void setPt_name(String pt_name) {
		this.pt_name = pt_name;
	}
	@Column(length=1000)
	public String getPt_desc() {
		return pt_desc;
	}
	public void setPt_desc(String pt_desc) {
		this.pt_desc = pt_desc;
	}
	@Column(length=500)
	public String getPt_remark() {
		return pt_remark;
	}
	public void setPt_remark(String pt_remark) {
		this.pt_remark = pt_remark;
	}
	@ManyToOne
	@JoinColumn(name = "us_Id")
	public T_User_Info getUser() {
		return user;
	}
	public void setUser(T_User_Info user) {
		this.user = user;
	}
	public Date getPt_createDate() {
		return pt_createDate;
	}
	public void setPt_createDate(Date pt_createDate) {
		this.pt_createDate = pt_createDate;
	}
	@ManyToOne
	@JoinColumn(name = "pid")
	public E_PlanType getPlanType() {
		return planType;
	}
	public void setPlanType(E_PlanType planType) {
		this.planType = planType;
	}
}
