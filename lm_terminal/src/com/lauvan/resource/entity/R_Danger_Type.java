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
 * 危险隐患类型表实体
* @ClassName: R_Supplies_Type
* @Description: TODO
* @author zhou
* @date 2016年1月22日 下午4:05:14
*
 */
@Entity
@Table(name = "r_danger_type")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Danger_Type implements java.io.Serializable{
	
	private static final long serialVersionUID = -2251226928639042488L;
	
	private Integer dt_Id;
	/**
	 * 序号
	 */
	private String dt_Code;
	/**
	 * 父ID
	 */
	private Integer dt_Pid;
	/**
	 * 类型名称
	 */
	private String dt_Name;
	/**
	 * 备注
	 */
	private String dt_Remark;
	
	
	
	public R_Danger_Type() {
		super();
	}
	public R_Danger_Type(Integer dt_Id) {
		super();
		this.dt_Id = dt_Id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getDt_Id() {
		return dt_Id;
	}
	public void setDt_Id(Integer dt_Id) {
		this.dt_Id = dt_Id;
	}
	public String getDt_Code() {
		return dt_Code;
	}
	public void setDt_Code(String dt_Code) {
		this.dt_Code = dt_Code;
	}
	public Integer getDt_Pid() {
		return dt_Pid;
	}
	public void setDt_Pid(Integer dt_Pid) {
		this.dt_Pid = dt_Pid;
	}
	@Column(length = 20,nullable = false)
	public String getDt_Name() {
		return dt_Name;
	}
	public void setDt_Name(String dt_Name) {
		this.dt_Name = dt_Name;
	}
	@Column(length = 100)
	public String getDt_Remark() {
		return dt_Remark;
	}
	public void setDt_Remark(String dt_Remark) {
		this.dt_Remark = dt_Remark;
	}
	

}
