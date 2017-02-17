package com.lauvan.system.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


@Entity
@Table(name = "t_role_info")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Role_Info implements java.io.Serializable {

	private static final long serialVersionUID = 7033841578790701874L;

	private Integer ro_Id;
	/**
	 * 角色编码
	 */
	private String ro_Code;
	/**
	 * 名称
	 */
	private String ro_Name;
	/**
	 * 备注
	 */
	private String ro_Remark;

	public T_Role_Info() {
	}

	public T_Role_Info(Integer roId) {
		this.ro_Id = roId;
	}

	@Id
	public Integer getRo_Id() {
		return this.ro_Id;
	}

	public void setRo_Id(Integer roId) {
		this.ro_Id = roId;
	}

	@Column(length = 20)
	public String getRo_Code() {
		return this.ro_Code;
	}

	public void setRo_Code(String roCode) {
		this.ro_Code = roCode;
	}

	@Column(length = 20)
	public String getRo_Name() {
		return this.ro_Name;
	}

	public void setRo_Name(String roName) {
		this.ro_Name = roName;
	}

	@Column(length = 200)
	public String getRo_Remark() {
		return this.ro_Remark;
	}

	public void setRo_Remark(String roRemark) {
		this.ro_Remark = roRemark;
	}

}