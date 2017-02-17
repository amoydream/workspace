package com.lauvan.system.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "t_module_info")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Module_Info implements java.io.Serializable {

	private static final long serialVersionUID = 2497945321389326014L;
	private Integer mo_Id;
	/**
	 * 模块名称
	 */
	private String mo_Name;
	/**
	 * 模块编码
	 */
	private String mo_Code;
	/**
	 * 模块路径
	 */
	private String mo_Url;
	/**
	 * 父级ID
	 */
	private Integer mo_Pid;
	/**
	 * 级别(1:菜单和2:功能)
	 */
	private String mo_Step;
	/**
	 * 状态1:有效0：无效
	 */
	private String mo_State="1";
	/**
	 * 索引
	 */
	private Integer mo_Index;
	/**
	 * 备注
	 */
	private String mo_Remark;
	/**
	 * 图标
	 */
	private String mo_Icon = "fa-book";
    
	/**
	 * 模块样式
	 */
	private String mo_Class;
	
	@Column(length = 30)
	public String getMo_Class() {
		return mo_Class;
	}

	public void setMo_Class(String mo_Class) {
		this.mo_Class = mo_Class;
	}

	public T_Module_Info() {
	}

	public T_Module_Info(Integer moId, Integer moPid) {
		this.mo_Id = moId;
		this.mo_Pid = moPid;
	}

	@Id
	public Integer getMo_Id() {
		return this.mo_Id;
	}

	public void setMo_Id(Integer moId) {
		this.mo_Id = moId;
	}

	@Column(length = 20)
	public String getMo_Name() {
		return this.mo_Name;
	}

	public void setMo_Name(String moName) {
		this.mo_Name = moName;
	}

	@Column(length = 50)
	public String getMo_Code() {
		return this.mo_Code;
	}

	public void setMo_Code(String moCode) {
		this.mo_Code = moCode;
	}

	@Column(length = 50)
	public String getMo_Url() {
		return this.mo_Url;
	}

	public void setMo_Url(String moUrl) {
		this.mo_Url = moUrl;
	}

	@Column(name = "mo_pid")
	public Integer getMo_Pid() {
		return this.mo_Pid;
	}

	public void setMo_Pid(Integer moPid) {
		this.mo_Pid = moPid;
	}
	@Column(length=1)
	public String getMo_Step() {
		return this.mo_Step;
	}

	public void setMo_Step(String moStep) {
		this.mo_Step = moStep;
	}

	@Column(length=1)
	public String getMo_State() {
		return this.mo_State;
	}

	public void setMo_State(String moState) {
		this.mo_State = moState;
	}

	public Integer getMo_Index() {
		return this.mo_Index;
	}

	public void setMo_Index(Integer moIndex) {
		this.mo_Index = moIndex;
	}

	@Column(length = 200)
	public String getMo_Remark() {
		return this.mo_Remark;
	}

	public void setMo_Remark(String moRemark) {
		this.mo_Remark = moRemark;
	}

	@Column(length = 50)
	public String getMo_Icon() {
		return this.mo_Icon;
	}

	public void setMo_Icon(String moIcon) {
		this.mo_Icon = moIcon;
	}

}