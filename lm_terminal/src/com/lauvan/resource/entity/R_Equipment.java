package com.lauvan.resource.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.organ.entity.C_Organ;

/**
 * 
 * ClassName: R_Equipment 
 * @Description: 装备信息表
 * @author 周志高
 * @date 2015年12月15日 下午5:48:28
 */
@Entity
@Table(name = "r_equipment")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Equipment implements java.io.Serializable{

	private static final long serialVersionUID = 3746924315138756262L;
	
	private Integer eq_Id;
	/**
	 * 装备名称
	 */
	private R_Equipment_Type eq_Typeid;
	/**
	 * 类型
	 */
	private String eq_Type;
	/**
	 * 规格
	 */
	private String eq_Size;
	/**
	 * 生产日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date eq_Producedate;
	/**
	 * 购买日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date eq_Buydate;
	/**
	 * 有效使用期
	 */
	private String eq_Validitydate;
	/**
	 * 购买价格
	 */
	private Integer eq_Price;
	/**
	 * 数量
	 */
	private Integer eq_Count;
	/**
	 * 停放地名称
	 */
	private String eq_Placename;
	/**
	 * 联系人
	 */
	private String eq_Linkman;
	/**
	 * 联系人电话
	 */
	private String eq_Linkmantel;
	/**
	 * 记录时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date eq_Recorddate;
	/**
	 * 装备状态
	 */
	private String eq_State;
	/**
	 * 经度
	 */
	private String eq_Longitude;
	/**
	 * 纬度
	 */
	private String eq_Latitude;
	/**
	 * 所属单位
	 */
	private C_Organ eq_Deptid;
	/**
	 * 所属队伍
	 */
	private R_Team eq_Teamid;
	/** 
	 * 地址
	 */
	private String eq_Address;
	/**
	 * 装备描述
	 */
	private String eq_Describe;
	/**
	 * 备注
	 */
	private String eq_Remark;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEq_Id() {
		return eq_Id;
	}
	public void setEq_Id(Integer eq_Id) {
		this.eq_Id = eq_Id;
	}
	@ManyToOne
	@JoinColumn(name="eq_Typeid")
	public R_Equipment_Type getEq_Typeid() {
		return eq_Typeid;
	}
	public void setEq_Typeid(R_Equipment_Type eq_Typeid) {
		this.eq_Typeid = eq_Typeid;
	}
	public String getEq_Type() {
		return eq_Type;
	}
	public void setEq_Type(String eq_Type) {
		this.eq_Type = eq_Type;
	}
	public String getEq_Size() {
		return eq_Size;
	}
	public void setEq_Size(String eq_Size) {
		this.eq_Size = eq_Size;
	}
	public Date getEq_Producedate() {
		return eq_Producedate;
	}
	public void setEq_Producedate(Date eq_Producedate) {
		this.eq_Producedate = eq_Producedate;
	}
	public Date getEq_Buydate() {
		return eq_Buydate;
	}
	public void setEq_Buydate(Date eq_Buydate) {
		this.eq_Buydate = eq_Buydate;
	}
	public String getEq_Validitydate() {
		return eq_Validitydate;
	}
	public void setEq_Validitydate(String eq_Validitydate) {
		this.eq_Validitydate = eq_Validitydate;
	}
	public Integer getEq_Price() {
		return eq_Price;
	}
	public void setEq_Price(Integer eq_Price) {
		this.eq_Price = eq_Price;
	}
	public Integer getEq_Count() {
		return eq_Count;
	}
	public void setEq_Count(Integer eq_Count) {
		this.eq_Count = eq_Count;
	}
	public String getEq_Placename() {
		return eq_Placename;
	}
	public void setEq_Placename(String eq_Placename) {
		this.eq_Placename = eq_Placename;
	}
	public String getEq_Linkman() {
		return eq_Linkman;
	}
	public void setEq_Linkman(String eq_Linkman) {
		this.eq_Linkman = eq_Linkman;
	}
	public String getEq_Linkmantel() {
		return eq_Linkmantel;
	}
	public void setEq_Linkmantel(String eq_Linkmantel) {
		this.eq_Linkmantel = eq_Linkmantel;
	}
	public Date getEq_Recorddate() {
		return eq_Recorddate;
	}
	public void setEq_Recorddate(Date eq_Recorddate) {
		this.eq_Recorddate = eq_Recorddate;
	}
	public String getEq_State() {
		return eq_State;
	}
	public void setEq_State(String eq_State) {
		this.eq_State = eq_State;
	}
	public String getEq_Longitude() {
		return eq_Longitude;
	}
	public void setEq_Longitude(String eq_Longitude) {
		this.eq_Longitude = eq_Longitude;
	}
	public String getEq_Latitude() {
		return eq_Latitude;
	}
	public void setEq_Latitude(String eq_Latitude) {
		this.eq_Latitude = eq_Latitude;
	}
	@ManyToOne
	@JoinColumn(name="eq_Deptid")
	public C_Organ getEq_Deptid() {
		return eq_Deptid;
	}
	public void setEq_Deptid(C_Organ eq_Deptid) {
		this.eq_Deptid = eq_Deptid;
	}
	@ManyToOne
	@JoinColumn(name="eq_Teamid")
	public R_Team getEq_Teamid() {
		return eq_Teamid;
	}
	public void setEq_Teamid(R_Team eq_Teamid) {
		this.eq_Teamid = eq_Teamid;
	}
	public String getEq_Address() {
		return eq_Address;
	}
	public void setEq_Address(String eq_Address) {
		this.eq_Address = eq_Address;
	}
	public String getEq_Describe() {
		return eq_Describe;
	}
	public void setEq_Describe(String eq_Describe) {
		this.eq_Describe = eq_Describe;
	}
	public String getEq_Remark() {
		return eq_Remark;
	}
	public void setEq_Remark(String eq_Remark) {
		this.eq_Remark = eq_Remark;
	}
	
}
