package com.lauvan.resource.entity;

import java.util.Date;

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
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.organ.entity.C_Organ;

/**
 * 
 * ClassName: R_Expert 
 * @Description: 专家表实体
 * @author 周志高
 * @date 2015年12月16日 上午10:39:11
 */
@Entity
@Table(name = "r_expert")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Expert implements java.io.Serializable{

	private static final long serialVersionUID = 8920233190188423239L;
	
	private Integer ex_Id;
	/**
	 * 专家类型
	 */
	private R_Expert_Type ex_Typeid;
	/**
	 * 专家姓名
	 */
	private String ex_Name;
	/**
	 * 性别，0：女, 1：男
	 */
	private String ex_Sex;
	/**
	 * 出生日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date ex_Borndate;
	/**
	 * 籍贯
	 */
	private String ex_Nativeplace;
	/**
	 * 民族
	 */
	private String ex_Nationality;
	/**
	 * 身份证号
	 */
	private String ex_Idcard;
	/**
	 * 政治面貌
	 */
	private String ex_Politicalstatus;
	/**
	 * 毕业院校
	 */
	private String ex_Graduateschool;
	/**
	 * 毕业时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date ex_Graduatetime;
	/**
	 * 毕业专业
	 */
	private String ex_Professional;
	/**
	 * 最高学历
	 */
	private String ex_Degree;
	/**
	 * 参加工作日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date ex_Workdate;
	/**
	 * 外语
	 */
	private String ex_Foreignlanguage;
	/**
	 * 婚姻状态
	 */
	private String ex_Maritalstatus;
	/** 
	 * 健康状况
	 */
	private String ex_Healthstatus;
	/**
	 * 单位名称
	 */
	private C_Organ ex_Deptid;
	/**
	 * 单位性质
	 */
	private String ex_Depttype;
	/**
	 * 从事职业
	 */
	private String ex_Job;
	/**
	 * 职称
	 */
	private String ex_Jobtitle;
	/**
	 * 职位
	 */
	private String ex_Position;
	/**
	 * E-mail
	 */
	private String ex_Email;
	/**
	 * 联系地址
	 */
	private String ex_Linkaddress;
	/**
	 * 邮编
	 */
	private Integer ex_Postcode;
	/**
	 * 户口所在地
	 */
	private String ex_Registeplace;
	/**
	 * 经度
	 */
	private String ex_Longitude;
	/**
	 * 纬度
	 */
	private String ex_Latitude;
	/**
	 * 家庭住址
	 */
	private String ex_Familyaddress;
	/**
	 * 奖惩
	 */
	private String ex_Rewardpunish;
	/**
	 * 个人描述
	 */
	private String ex_Describe;
	/**
	 * 专长
	 */
	private String ex_Speciality;
	/**
	 * 技术成果
	 */
	private String ex_Achievement;
	/**
	 * 备注
	 */
	private String ex_Remark;
	
	public R_Expert(Integer ex_Id) {
		super();
		this.ex_Id = ex_Id;
	}
	public R_Expert() {
		super();
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEx_Id() {
		return ex_Id;
	}
	public void setEx_Id(Integer ex_Id) {
		this.ex_Id = ex_Id;
	}
	@ManyToOne
	@JoinColumn(name="ex_Typeid")
	public R_Expert_Type getEx_Typeid() {
		return ex_Typeid;
	}
	public void setEx_Typeid(R_Expert_Type ex_Typeid) {
		this.ex_Typeid = ex_Typeid;
	}
	@Column(length = 10,nullable = false)
	public String getEx_Name() {
		return ex_Name;
	}
	public void setEx_Name(String ex_Name) {
		this.ex_Name = ex_Name;
	}
	@Column(length = 1,nullable = false)
	public String getEx_Sex() {
		return ex_Sex;
	}
	public void setEx_Sex(String ex_Sex) {
		this.ex_Sex = ex_Sex;
	}
	public Date getEx_Borndate() {
		return ex_Borndate;
	}
	public void setEx_Borndate(Date ex_Borndate) {
		this.ex_Borndate = ex_Borndate;
	}
	@Column(length = 20)
	public String getEx_Nativeplace() {
		return ex_Nativeplace;
	}
	public void setEx_Nativeplace(String ex_Nativeplace) {
		this.ex_Nativeplace = ex_Nativeplace;
	}
	@Column(length = 10)
	public String getEx_Nationality() {
		return ex_Nationality;
	}
	public void setEx_Nationality(String ex_Nationality) {
		this.ex_Nationality = ex_Nationality;
	}
	@Column(length = 20)
	public String getEx_Idcard() {
		return ex_Idcard;
	}
	public void setEx_Idcard(String ex_Idcard) {
		this.ex_Idcard = ex_Idcard;
	}
	@Column(length = 10)
	public String getEx_Politicalstatus() {
		return ex_Politicalstatus;
	}
	public void setEx_Politicalstatus(String ex_Politicalstatus) {
		this.ex_Politicalstatus = ex_Politicalstatus;
	}
	@Column(length = 20)
	public String getEx_Graduateschool() {
		return ex_Graduateschool;
	}
	public void setEx_Graduateschool(String ex_Graduateschool) {
		this.ex_Graduateschool = ex_Graduateschool;
	}
	public Date getEx_Graduatetime() {
		return ex_Graduatetime;
	}
	public void setEx_Graduatetime(Date ex_Graduatetime) {
		this.ex_Graduatetime = ex_Graduatetime;
	}
	@Column(length = 20)
	public String getEx_Professional() {
		return ex_Professional;
	}
	public void setEx_Professional(String ex_Professional) {
		this.ex_Professional = ex_Professional;
	}
	@Column(length = 10)
	public String getEx_Degree() {
		return ex_Degree;
	}
	public void setEx_Degree(String ex_Degree) {
		this.ex_Degree = ex_Degree;
	}
	public Date getEx_Workdate() {
		return ex_Workdate;
	}
	public void setEx_Workdate(Date ex_Workdate) {
		this.ex_Workdate = ex_Workdate;
	}
	@Column(length = 10)
	public String getEx_Foreignlanguage() {
		return ex_Foreignlanguage;
	}
	public void setEx_Foreignlanguage(String ex_Foreignlanguage) {
		this.ex_Foreignlanguage = ex_Foreignlanguage;
	}
	@Column(length = 10)
	public String getEx_Maritalstatus() {
		return ex_Maritalstatus;
	}
	public void setEx_Maritalstatus(String ex_Maritalstatus) {
		this.ex_Maritalstatus = ex_Maritalstatus;
	}
	@Column(length = 10)
	public String getEx_Healthstatus() {
		return ex_Healthstatus;
	}
	public void setEx_Healthstatus(String ex_Healthstatus) {
		this.ex_Healthstatus = ex_Healthstatus;
	}
	@ManyToOne
	@JoinColumn(name="ex_Deptid")
	public C_Organ getEx_Deptid() {
		return ex_Deptid;
	}
	public void setEx_Deptid(C_Organ ex_Deptid) {
		this.ex_Deptid = ex_Deptid;
	}
	@Column(length = 10)
	public String getEx_Depttype() {
		return ex_Depttype;
	}
	public void setEx_Depttype(String ex_Depttype) {
		this.ex_Depttype = ex_Depttype;
	}
	@Column(length = 10)
	public String getEx_Job() {
		return ex_Job;
	}
	public void setEx_Job(String ex_Job) {
		this.ex_Job = ex_Job;
	}
	@Column(length = 10)
	public String getEx_Jobtitle() {
		return ex_Jobtitle;
	}
	public void setEx_Jobtitle(String ex_Jobtitle) {
		this.ex_Jobtitle = ex_Jobtitle;
	}
	@Column(length = 10)
	public String getEx_Position() {
		return ex_Position;
	}
	public void setEx_Position(String ex_Position) {
		this.ex_Position = ex_Position;
	}
	@Column(length = 20)
	public String getEx_Email() {
		return ex_Email;
	}
	public void setEx_Email(String ex_Email) {
		this.ex_Email = ex_Email;
	}
	@Column(length = 50)
	public String getEx_Linkaddress() {
		return ex_Linkaddress;
	}
	public void setEx_Linkaddress(String ex_Linkaddress) {
		this.ex_Linkaddress = ex_Linkaddress;
	}
	public Integer getEx_Postcode() {
		return ex_Postcode;
	}
	public void setEx_Postcode(Integer ex_Postcode) {
		this.ex_Postcode = ex_Postcode;
	}
	@Column(length = 20)
	public String getEx_Registeplace() {
		return ex_Registeplace;
	}
	public void setEx_Registeplace(String ex_Registeplace) {
		this.ex_Registeplace = ex_Registeplace;
	}
	@Column(length = 10)
	public String getEx_Longitude() {
		return ex_Longitude;
	}
	public void setEx_Longitude(String ex_Longitude) {
		this.ex_Longitude = ex_Longitude;
	}
	@Column(length = 10)
	public String getEx_Latitude() {
		return ex_Latitude;
	}
	public void setEx_Latitude(String ex_Latitude) {
		this.ex_Latitude = ex_Latitude;
	}
	@Column(length = 50)
	public String getEx_Familyaddress() {
		return ex_Familyaddress;
	}
	public void setEx_Familyaddress(String ex_Familyaddress) {
		this.ex_Familyaddress = ex_Familyaddress;
	}
	@Column(length = 100)
	public String getEx_Rewardpunish() {
		return ex_Rewardpunish;
	}
	public void setEx_Rewardpunish(String ex_Rewardpunish) {
		this.ex_Rewardpunish = ex_Rewardpunish;
	}
	@Column(length = 100)
	public String getEx_Describe() {
		return ex_Describe;
	}
	public void setEx_Describe(String ex_Describe) {
		this.ex_Describe = ex_Describe;
	}
	@Column(length = 100)
	public String getEx_Speciality() {
		return ex_Speciality;
	}
	public void setEx_Speciality(String ex_Speciality) {
		this.ex_Speciality = ex_Speciality;
	}
	@Column(length = 100)
	public String getEx_Achievement() {
		return ex_Achievement;
	}
	public void setEx_Achievement(String ex_Achievement) {
		this.ex_Achievement = ex_Achievement;
	}
	@Column(length = 100)
	public String getEx_Remark() {
		return ex_Remark;
	}
	public void setEx_Remark(String ex_Remark) {
		this.ex_Remark = ex_Remark;
	}
	
	
	

}
