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
 * 物资类型表实体
* @ClassName: R_Supplies_Type
* @Description: TODO
* @author zhou
* @date 2016年1月22日 下午4:05:14
*
 */
@Entity
@Table(name = "r_supplies_type")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Supplies_Type implements java.io.Serializable{
	
	private static final long serialVersionUID = -2251226928639042488L;
	
	private Integer ty_Id;
	/**
	 * 序号
	 */
	private String ty_Code;
	/**
	 * 父ID
	 */
	private Integer ty_Pid;
	/**
	 * 类型名称
	 */
	private String ty_Name;
	/**
	 * 备注
	 */
	private String ty_Remark;
	
	
	
	public R_Supplies_Type() {
		super();
	}
	public R_Supplies_Type(Integer ty_Id) {
		super();
		this.ty_Id = ty_Id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getTy_Id() {
		return ty_Id;
	}
	public void setTy_Id(Integer ty_Id) {
		this.ty_Id = ty_Id;
	}
	@Column(nullable = false)
	public String getTy_Code() {
		return ty_Code;
	}
	public void setTy_Code(String ty_Code) {
		this.ty_Code = ty_Code;
	}
	public Integer getTy_Pid() {
		return ty_Pid;
	}
	public void setTy_Pid(Integer ty_Pid) {
		this.ty_Pid = ty_Pid;
	}
	@Column(length = 20,nullable = false)
	public String getTy_Name() {
		return ty_Name;
	}
	public void setTy_Name(String ty_Name) {
		this.ty_Name = ty_Name;
	}
	@Column(length = 100)
	public String getTy_Remark() {
		return ty_Remark;
	}
	public void setTy_Remark(String ty_Remark) {
		this.ty_Remark = ty_Remark;
	}
	

}
