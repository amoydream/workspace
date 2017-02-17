package com.lauvan.system.vo;


import com.lauvan.base.vo.BaseVo;

public class DictionaryInfoVo extends BaseVo {
	
	/**
	 * dictionaryinfo表操作
	 */
	private static final long serialVersionUID = 6413522996949300069L;
	
	
	private Integer di_Id;
	private Integer di_Index;
	private String di_Name;
	private String di_Remark;
	private Integer dt_Id;
	
	/**
	 * dictionarytype表操作
	 */	
	private String dt_Code;	
	private String dt_Name;
	private String dt_Remark;
	
	
		
	public Integer getDi_Id() {
		return di_Id;
	}
	public void setDi_Id(Integer di_Id) {
		this.di_Id = di_Id;
	}
	public Integer getDi_Index() {
		return di_Index;
	}
	public void setDi_Index(Integer di_Index) {
		this.di_Index = di_Index;
	}
	public String getDi_Name() {
		return di_Name;
	}
	public void setDi_Name(String di_Name) {
		this.di_Name = di_Name;
	}
	public String getDi_Remark() {
		return di_Remark;
	}
	public void setDi_Remark(String di_Remark) {
		this.di_Remark = di_Remark;
	}
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
