package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class DangerTypeVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 4933269763098110146L;
	
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
	public String getDt_Name() {
		return dt_Name;
	}
	public void setDt_Name(String dt_Name) {
		this.dt_Name = dt_Name;
	}
	public String getDt_Remark() {
		return dt_Remark;
	}
	public void setDt_Remark(String dt_Remark) {
		this.dt_Remark = dt_Remark;
	}
	
	

}
