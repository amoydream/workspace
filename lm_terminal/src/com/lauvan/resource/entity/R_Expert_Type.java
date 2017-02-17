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
 * 
 * ClassName: R_Expert_Type 
 * @Description: 专家类型表实体
 * @author 周志高
 * @date 2015年12月15日 下午5:45:49
 */
@Entity
@Table(name = "r_expert_type")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Expert_Type implements java.io.Serializable{

	private static final long serialVersionUID = 586479042918709067L;
	
	private Integer ext_Id;
	/**
	 * 父ID
	 */
	private Integer ext_Pid;
	/**
	 * 类型编号
	 */
	private String ext_Code;
	/**
	 * 类型名称
	 */
	private String ext_Name;
	/**
	 * 备注
	 */
	private String ext_Remark;
	
	
	public R_Expert_Type() {
		super();
	}
	public R_Expert_Type(Integer ext_Id) {
		super();
		this.ext_Id = ext_Id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getExt_Id() {
		return ext_Id;
	}
	public void setExt_Id(Integer ext_Id) {
		this.ext_Id = ext_Id;
	}
	public Integer getExt_Pid() {
		return ext_Pid;
	}
	public void setExt_Pid(Integer ext_Pid) {
		this.ext_Pid = ext_Pid;
	}
	@Column(length = 10,nullable = false)
	public String getExt_Code() {
		return ext_Code;
	}
	public void setExt_Code(String ext_Code) {
		this.ext_Code = ext_Code;
	}
	@Column(length = 20,nullable = false)
	public String getExt_Name() {
		return ext_Name;
	}
	public void setExt_Name(String ext_Name) {
		this.ext_Name = ext_Name;
	}
	@Column(length = 100)
	public String getExt_Remark() {
		return ext_Remark;
	}
	public void setExt_Remark(String ext_Remark) {
		this.ext_Remark = ext_Remark;
	}
	
	


}
