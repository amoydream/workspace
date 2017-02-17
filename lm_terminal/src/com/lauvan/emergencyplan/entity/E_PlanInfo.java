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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.event.entity.T_Event_Type;
/**
 * 
 * ClassName: E_PlanInfo 
 * @Description: 预案基本信息
 * @author 钮炜炜
 * @date 2015年12月7日 下午4:59:18
 */
@Entity
@Table(name = "e_planinfo")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_PlanInfo implements Serializable{

	private static final long serialVersionUID = 447532863054438783L;
	private Integer pi_id;
	/**
	 * 预案名称
	 */
	private String pi_name;
	/**
	 * 所属机构
	 */
	private String pi_subOrgan;
	/**
	 * 发布机构
	 */
	private String pi_issOrgan;
	/**
	 * 编制机构
	 */
	private String pi_estOrgan;
	/**
	 * 审批机构
	 */
	private String pi_appOrgan;
	/**
	 * 版本号
	 */
	private Integer pi_no;
	/**
	 * 层级
	 */
	private String pi_level;
	/**
	 * 发布日期
	 */
	private Date pi_createDate;
	/**
	 * 说明
	 */
	private String pi_note;
	/**
	 * 描述
	 */
	private String pi_desc;
	/**
	 * 适用范围
	 */
	private String pi_scope;
	/**
	 * 备注
	 */
	private String pi_remark;
//	private E_PlanType planType;
	private T_Event_Type eventType;
	private String pi_del;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@Column(length=100,nullable=false)
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	@Column(length=100)
	public String getPi_subOrgan() {
		return pi_subOrgan;
	}
	public void setPi_subOrgan(String pi_subOrgan) {
		this.pi_subOrgan = pi_subOrgan;
	}
	@Column(length=100)
	public String getPi_issOrgan() {
		return pi_issOrgan;
	}
	public void setPi_issOrgan(String pi_issOrgan) {
		this.pi_issOrgan = pi_issOrgan;
	}
	@Column(length=100)
	public String getPi_estOrgan() {
		return pi_estOrgan;
	}
	public void setPi_estOrgan(String pi_estOrgan) {
		this.pi_estOrgan = pi_estOrgan;
	}
	@Column(length=100)
	public String getPi_appOrgan() {
		return pi_appOrgan;
	}
	public void setPi_appOrgan(String pi_appOrgan) {
		this.pi_appOrgan = pi_appOrgan;
	}
	@Column(length=1)
	public String getPi_level() {
		return pi_level;
	}
	public void setPi_level(String pi_level) {
		this.pi_level = pi_level;
	}
	@Temporal(TemporalType.DATE)
	public Date getPi_createDate() {
		return pi_createDate;
	}
	public void setPi_createDate(Date pi_createDate) {
		this.pi_createDate = pi_createDate;
	}
	@Column(length=1000)
	public String getPi_note() {
		return pi_note;
	}
	public void setPi_note(String pi_note) {
		this.pi_note = pi_note;
	}
	@Column(length=1000)
	public String getPi_desc() {
		return pi_desc;
	}
	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}
	@Column(length=1000)
	public String getPi_scope() {
		return pi_scope;
	}
	public void setPi_scope(String pi_scope) {
		this.pi_scope = pi_scope;
	}
	@Column(length=1000)
	public String getPi_remark() {
		return pi_remark;
	}
	public void setPi_remark(String pi_remark) {
		this.pi_remark = pi_remark;
	}
	
	public Integer getPi_no() {
		return pi_no;
	}
	public void setPi_no(Integer pi_no) {
		this.pi_no = pi_no;
	}
	@ManyToOne
	@JoinColumn(name = "et_id")
	public T_Event_Type getEventType() {
		return eventType;
	}
	public void setEventType(T_Event_Type eventType) {
		this.eventType = eventType;
	}
	@Column(length=1)
	public String getPi_del() {
		return pi_del;
	}
	public void setPi_del(String pi_del) {
		this.pi_del = pi_del;
	}
	
	
}
