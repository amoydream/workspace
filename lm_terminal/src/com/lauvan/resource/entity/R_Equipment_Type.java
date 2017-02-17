package com.lauvan.resource.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: R_Equipment_Type 
 * @Description: 装备类型表实体
 * @author 周志高
 * @date 2015年12月15日 下午5:45:49
 */
@Entity
@Table(name = "r_equipment_type")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Equipment_Type implements java.io.Serializable{

	private static final long serialVersionUID = 586479042918709067L;
	
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
	
	
	public R_Equipment_Type() {
		super();
	}
	public R_Equipment_Type(Integer eqt_Id) {
		super();
		this.eqt_Id = eqt_Id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
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
