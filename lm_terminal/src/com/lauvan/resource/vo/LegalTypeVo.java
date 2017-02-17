package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class LegalTypeVo extends BaseVo implements Serializable{
	
	private static final long serialVersionUID = -4378464048923787083L;
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
	public String getLt_Name() {
		return lt_Name;
	}
	public void setLt_Name(String lt_Name) {
		this.lt_Name = lt_Name;
	}
	public String getLt_Remark() {
		return lt_Remark;
	}
	public void setLt_Remark(String lt_Remark) {
		this.lt_Remark = lt_Remark;
	}
	
	

}
