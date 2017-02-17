package com.lauvan.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: T_User_Info 
 * @Description: 用户
 * @author 钮炜炜
 * @date 2016年4月15日 上午9:00:33
 */
@Entity
@Table(name = "t_user_info")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_User_Info implements java.io.Serializable {

	private static final long serialVersionUID = 4594311392508280187L;
	private Integer us_Id;
	/**
	 * 用户名
	 */
	private String us_Code;
	/**
	 * 姓名
	 */
	private String us_Name;
	/**
	 * 密码
	 */
	private String us_Pass;
	/**
	 * 年龄
	 */
	private Integer us_Age;
	/**
	 * 性别(M:男F：女)
	 */
	private String us_Sex="M";
	/**
	 * 手机
	 */
	private String us_Mophone;
	/**
	 * 工作电话
	 */
	private String us_Offphone;
	/**
	 * 住址
	 */
	private String us_Address;
	/**
	 * 备注说明
	 */
	private String us_Remark;
	/**
	 * 状态：1：启用，0：停用
	 */
	private String us_State = "1";
	/**
	 * 终端机电话号
	 */
	private String voice;
	/**
	 * 是否可以打电话(1可以0不可以)
	 */
	private String callif;
	
	public T_User_Info() {
	}

	public T_User_Info(Integer us_Id) {
		this.us_Id = us_Id;
	}

	public T_User_Info(Integer usId, String usCode) {
		this.us_Id = usId;
		this.us_Code = usCode;
	}

	public T_User_Info(Integer us_Id, String us_Code, String us_Name) {
		this.us_Id = us_Id;
		this.us_Code = us_Code;
		this.us_Name = us_Name;
	}

	@Id
	public Integer getUs_Id() {
		return this.us_Id;
	}

	public void setUs_Id(Integer usId) {
		this.us_Id = usId;
	}

	/**
	 * 用户名
	 */
	@Column(unique = true, nullable = false, length = 20)
	public String getUs_Code() {
		return this.us_Code;
	}

	public void setUs_Code(String usCode) {
		this.us_Code = usCode;
	}

	@Column(length = 20)
	public String getUs_Name() {
		return this.us_Name;
	}

	public void setUs_Name(String usName) {
		this.us_Name = usName;
	}

	@Column(length = 100)
	public String getUs_Pass() {
		return this.us_Pass;
	}

	public void setUs_Pass(String usPass) {
		this.us_Pass = usPass;
	}

	public Integer getUs_Age() {
		return this.us_Age;
	}

	public void setUs_Age(Integer usAge) {
		this.us_Age = usAge;
	}

	@Column(length = 20)
	public String getUs_Mophone() {
		return this.us_Mophone;
	}

	public void setUs_Mophone(String usMophone) {
		this.us_Mophone = usMophone;
	}

	@Column(length = 20)
	public String getUs_Offphone() {
		return this.us_Offphone;
	}

	public void setUs_Offphone(String usOffphone) {
		this.us_Offphone = usOffphone;
	}

	@Column(length = 100)
	public String getUs_Address() {
		return this.us_Address;
	}

	public void setUs_Address(String usAddress) {
		this.us_Address = usAddress;
	}

	@Column(length = 200)
	public String getUs_Remark() {
		return this.us_Remark;
	}

	public void setUs_Remark(String usRemark) {
		this.us_Remark = usRemark;
	}

	@Column(length=1)
	public String getUs_State() {
		return this.us_State;
	}

	public void setUs_State(String usState) {
		this.us_State = usState;
	}

	@Column(length=1)
	public String getUs_Sex() {
		return us_Sex;
	}

	public void setUs_Sex(String us_Sex) {
		this.us_Sex = us_Sex;
	}
	@Column(length=20)
	public String getVoice() {
		return voice;
	}

	public void setVoice(String voice) {
		this.voice = voice;
	}
	@Column(length=1)
	public String getCallif() {
		return callif;
	}

	public void setCallif(String callif) {
		this.callif = callif;
	}
	
}