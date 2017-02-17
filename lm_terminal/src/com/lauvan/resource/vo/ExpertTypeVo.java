package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class ExpertTypeVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 1182096768097799489L;
	
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
	public String getExt_Code() {
		return ext_Code;
	}
	public void setExt_Code(String ext_Code) {
		this.ext_Code = ext_Code;
	}
	public String getExt_Name() {
		return ext_Name;
	}
	public void setExt_Name(String ext_Name) {
		this.ext_Name = ext_Name;
	}
	public String getExt_Remark() {
		return ext_Remark;
	}
	public void setExt_Remark(String ext_Remark) {
		this.ext_Remark = ext_Remark;
	}
	

}
