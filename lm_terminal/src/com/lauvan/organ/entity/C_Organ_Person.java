package com.lauvan.organ.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * ClassName: C_Organ_Person
 * 
 * @Description: 人员表
 * @author 钮炜炜
 * @date 2015年12月1日 上午9:04:24
 */
@Entity
@Table(name = "c_organ_person")
@DynamicInsert(true)
@DynamicUpdate(true)
public class C_Organ_Person implements Serializable {
	private static final long	serialVersionUID	= 6727816383800956912L;
	private Integer				pe_id;
	/**
	 * 名字
	 */
	private String				pe_name;
	/**
	 * 所属组织
	 */
	private C_Organ				organ;
	/**
	 * 岗位（可多个）
	 */
	private String				pe_poids;
	/**
	 * 性别（M:女，F:男）
	 */
	private String				pe_sex;
	/**
	 * 出生年月
	 */
	private Date				pe_birthday;
	/**
	 * 学历
	 */
	private String				pe_educational;
	/**
	 * 籍贯
	 */
	private String				pe_nativeplace;
	/**
	 * 民族
	 */
	private String				pe_nationality;
	/**
	 * 政治面貌
	 */
	private String				pe_political;
	/**
	 * 身份证
	 */
	private String				pe_identity;
	/**
	 * 工作时间
	 */
	private Date				pe_workdate;
	/**
	 * 专业
	 */
	private String				pe_profession;
	/**
	 * 家庭住址
	 */
	private String				pe_homeaddress;
	/**
	 * 现住住址
	 */
	private String				pe_address;
	/**
	 * 邮编
	 */
	private String				pe_zipcode;
	/**
	 * 备注
	 */
	private String				pe_remark;

	/**
	 * 是否应急人员（0：否，1：是）
	 */
	private String				pe_type;
	/**
	 * 是否领导(用于事件报告的人。是为1)
	 */
	private String				pe_leader;
	private String				pe_del;
	private Integer				pe_sort;

	public C_Organ_Person() {
		super();
	}

	public C_Organ_Person(Integer pe_id) {
		super();
		this.pe_id = pe_id;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getPe_id() {
		return pe_id;
	}

	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}

	@Column(length = 20, nullable = false)
	public String getPe_name() {
		return pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	@ManyToOne
	@JoinColumn(name = "or_id")
	public C_Organ getOrgan() {
		return organ;
	}

	public void setOrgan(C_Organ organ) {
		this.organ = organ;
	}

	@Column(length = 1, nullable = false)
	public String getPe_sex() {
		return pe_sex;
	}

	public void setPe_sex(String pe_sex) {
		this.pe_sex = pe_sex;
	}

	@Temporal(TemporalType.DATE)
	public Date getPe_birthday() {
		return pe_birthday;
	}

	public void setPe_birthday(Date pe_birthday) {
		this.pe_birthday = pe_birthday;
	}

	@Column(length = 10)
	public String getPe_educational() {
		return pe_educational;
	}

	public void setPe_educational(String pe_educational) {
		this.pe_educational = pe_educational;
	}

	@Column(length = 100)
	public String getPe_nativeplace() {
		return pe_nativeplace;
	}

	public void setPe_nativeplace(String pe_nativeplace) {
		this.pe_nativeplace = pe_nativeplace;
	}

	@Column(length = 10)
	public String getPe_nationality() {
		return pe_nationality;
	}

	public void setPe_nationality(String pe_nationality) {
		this.pe_nationality = pe_nationality;
	}

	@Column(length = 10)
	public String getPe_political() {
		return pe_political;
	}

	public void setPe_political(String pe_political) {
		this.pe_political = pe_political;
	}

	@Column(length = 18)
	public String getPe_identity() {
		return pe_identity;
	}

	public void setPe_identity(String pe_identity) {
		this.pe_identity = pe_identity;
	}

	@Temporal(TemporalType.DATE)
	public Date getPe_workdate() {
		return pe_workdate;
	}

	public void setPe_workdate(Date pe_workdate) {
		this.pe_workdate = pe_workdate;
	}

	@Column(length = 50)
	public String getPe_profession() {
		return pe_profession;
	}

	public void setPe_profession(String pe_profession) {
		this.pe_profession = pe_profession;
	}

	@Column(length = 100)
	public String getPe_address() {
		return pe_address;
	}

	public void setPe_address(String pe_address) {
		this.pe_address = pe_address;
	}

	@Column(length = 10)
	public String getPe_zipcode() {
		return pe_zipcode;
	}

	public void setPe_zipcode(String pe_zipcode) {
		this.pe_zipcode = pe_zipcode;
	}

	@Column(length = 200)
	public String getPe_remark() {
		return pe_remark;
	}

	public void setPe_remark(String pe_remark) {
		this.pe_remark = pe_remark;
	}

	@Column(length = 100)
	public String getPe_homeaddress() {
		return pe_homeaddress;
	}

	public void setPe_homeaddress(String pe_homeaddress) {
		this.pe_homeaddress = pe_homeaddress;
	}

	@Column(length = 1)
	public String getPe_type() {
		return pe_type;
	}

	public void setPe_type(String pe_type) {
		this.pe_type = pe_type;
	}

	@Column(length = 1)
	public String getPe_leader() {
		return pe_leader;
	}

	public void setPe_leader(String pe_leader) {
		this.pe_leader = pe_leader;
	}

	@Column(length = 20)
	public String getPe_poids() {
		return pe_poids;
	}

	public void setPe_poids(String pe_poids) {
		this.pe_poids = pe_poids;
	}

	@Column(length = 1)
	public String getPe_del() {
		return pe_del;
	}

	public void setPe_del(String pe_del) {
		this.pe_del = pe_del;
	}

	@Column(length = 11, nullable = false)
	public Integer getPe_sort() {
		return pe_sort;
	}

	public void setPe_sort(Integer pe_sort) {
		this.pe_sort = pe_sort;
	}
}
