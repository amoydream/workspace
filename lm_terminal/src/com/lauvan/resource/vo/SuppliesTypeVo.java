package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class SuppliesTypeVo extends BaseVo implements Serializable{
	
	private static final long serialVersionUID = -3008862742469844522L;
	
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
	
	
	public Integer getTy_Id() {
		return ty_Id;
	}
	public void setTy_Id(Integer ty_Id) {
		this.ty_Id = ty_Id;
	}
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
	public String getTy_Name() {
		return ty_Name;
	}
	public void setTy_Name(String ty_Name) {
		this.ty_Name = ty_Name;
	}
	public String getTy_Remark() {
		return ty_Remark;
	}
	public void setTy_Remark(String ty_Remark) {
		this.ty_Remark = ty_Remark;
	}
	
	

}
