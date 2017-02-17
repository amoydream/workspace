package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class EquipmentTypeVo extends BaseVo implements Serializable{
	
	private static final long serialVersionUID = 4303362795610064302L;
	
	private Integer eqt_Id;
	/**
	 * 类型编号
	 */
	private String eqt_Code;
	/**
	 * 类型名称
	 */
	private String eqt_Name;
	/**
	 * 备注
	 */
	private String eqt_Remark;
	
	
	public Integer getEqt_Id() {
		return eqt_Id;
	}
	public void setEqt_Id(Integer eqt_Id) {
		this.eqt_Id = eqt_Id;
	}
	public String getEqt_Code() {
		return eqt_Code;
	}
	public void setEqt_Code(String eqt_Code) {
		this.eqt_Code = eqt_Code;
	}
	public String getEqt_Name() {
		return eqt_Name;
	}
	public void setEqt_Name(String eqt_Name) {
		this.eqt_Name = eqt_Name;
	}
	public String getEqt_Remark() {
		return eqt_Remark;
	}
	public void setEqt_Remark(String eqt_Remark) {
		this.eqt_Remark = eqt_Remark;
	}
	
	


}
