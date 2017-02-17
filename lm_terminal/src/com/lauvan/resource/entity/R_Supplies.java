package com.lauvan.resource.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 物资信息表实体
* @ClassName: R_Supplies
* @Description: TODO
* @author zhou
* @date 2016年1月22日 下午4:05:01
*
 */
@Entity
@Table(name = "r_supplies")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Supplies implements java.io.Serializable{

	private static final long serialVersionUID = 951012223165234119L;
	
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
	 * 所属类型
	 */
    private R_Supplies_Type su_Typeid;
	
	public R_Supplies() {
		super();
	}
	public R_Supplies(Integer su_Id) {
		super();
		this.su_Id = su_Id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getSu_Id() {
		return su_Id;
	}
	public void setSu_Id(Integer su_Id) {
		this.su_Id = su_Id;
	}
	@Column(length = 20)
	public String getSu_Code() {
		return su_Code;
	}
	public void setSu_Code(String su_Code) {
		this.su_Code = su_Code;
	}
	@Column(length = 20,nullable = false)
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
	@Column(length = 10)
	public String getSu_Measureunit() {
		return su_Measureunit;
	}
	public void setSu_Measureunit(String su_Measureunit) {
		this.su_Measureunit = su_Measureunit;
	}
	@Column(length = 100)
	public String getSu_Remark() {
		return su_Remark;
	}
	public void setSu_Remark(String su_Remark) {
		this.su_Remark = su_Remark;
	}
	@ManyToOne
	@JoinColumn(name="su_Typeid",nullable = false)
	public R_Supplies_Type getSu_Typeid() {
		return su_Typeid;
	}
	public void setSu_Typeid(R_Supplies_Type su_Typeid) {
		this.su_Typeid = su_Typeid;
	}
	
	

}
