package com.lauvan.resource.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 法律分类表实体
* @ClassName: R_Supplies_Type
* @Description: TODO
* @author zhou
* @date 2016年1月22日 下午4:05:14
*
 */
@Entity
@Table(name = "r_legal_type")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Legal_Type implements java.io.Serializable{
	
	private static final long serialVersionUID = -2251226928639042488L;
	
	private Integer lt_Id;
	/**
	 * 序号
	 */
	private String lt_Code;
	/**
	 * 父ID
	 */
	private Integer lt_Pid;
	/**
	 * 类型名称
	 */
	private String lt_Name;
	/**
	 * 备注
	 */
	private String lt_Remark;
	
	
	
	public R_Legal_Type() {
		super();
	}
	public R_Legal_Type(Integer lt_Id) {
		super();
		this.lt_Id = lt_Id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getLt_Id() {
		return lt_Id;
	}
	public void setLt_Id(Integer lt_Id) {
		this.lt_Id = lt_Id;
	}
	public String getLt_Code() {
		return lt_Code;
	}
	public void setLt_Code(String lt_Code) {
		this.lt_Code = lt_Code;
	}
	public Integer getLt_Pid() {
		return lt_Pid;
	}
	public void setLt_Pid(Integer lt_Pid) {
		this.lt_Pid = lt_Pid;
	}
	@Column(length = 20,nullable = false)
	public String getLt_Name() {
		return lt_Name;
	}
	public void setLt_Name(String lt_Name) {
		this.lt_Name = lt_Name;
	}
	@Column(length = 100)
	public String getLt_Remark() {
		return lt_Remark;
	}
	public void setLt_Remark(String lt_Remark) {
		this.lt_Remark = lt_Remark;
	}
	

}
