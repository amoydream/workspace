package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class SuppliesVo extends BaseVo implements Serializable{
	
	private static final long serialVersionUID = 6937689692339804956L;
	
	private Integer su_Id;
	/**
	 * 编码
	 */
	private String su_Code;
	/**
	 * 名称
	 */
	private String su_Name;
	/**
	 * 型号
	 */
	private String su_Type;
	/**
	 * 规格
	 */
	private String su_Size;
	/**
	 * 安全库存
	 */
	private Integer su_Safetystock;
	/**
	 * 计量单位
	 */
	private String su_Measureunit;
	/**
	 * 备注
	 */
	private String su_Remark;
	/**
	 * 所属物资类型
	 */
	private Integer su_Typeid;

	public Integer getSu_Id() {
		return su_Id;
	}
	public void setSu_Id(Integer su_Id) {
		this.su_Id = su_Id;
	}
	public String getSu_Code() {
		return su_Code;
	}
	public void setSu_Code(String su_Code) {
		this.su_Code = su_Code;
	}
	public String getSu_Name() {
		return su_Name;
	}
	public void setSu_Name(String su_Name) {
		this.su_Name = su_Name;
	}
	public String getSu_Type() {
		return su_Type;
	}
	public void setSu_Type(String su_Type) {
		this.su_Type = su_Type;
	}
	public String getSu_Size() {
		return su_Size;
	}
	public void setSu_Size(String su_Size) {
		this.su_Size = su_Size;
	}
	public Integer getSu_Safetystock() {
		return su_Safetystock;
	}
	public void setSu_Safetystock(Integer su_Safetystock) {
		this.su_Safetystock = su_Safetystock;
	}
	public String getSu_Measureunit() {
		return su_Measureunit;
	}
	public void setSu_Measureunit(String su_Measureunit) {
		this.su_Measureunit = su_Measureunit;
	}
	public String getSu_Remark() {
		return su_Remark;
	}
	public void setSu_Remark(String su_Remark) {
		this.su_Remark = su_Remark;
	}
	public Integer getSu_Typeid() {
		return su_Typeid;
	}
	public void setSu_Typeid(Integer su_Typeid) {
		this.su_Typeid = su_Typeid;
	}
	

}
