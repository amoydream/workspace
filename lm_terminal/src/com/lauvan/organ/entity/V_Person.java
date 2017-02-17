package com.lauvan.organ.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * ClassName: V_Person
 *
 * @Description: 人员视图
 * @author 陶嵩松
 * @date 2016年5月4日
 */
@Entity
@Table(name = "v_person")
public class V_Person implements Serializable {
	private static final long	serialVersionUID	= 6727816383800956912L;
	private Integer				pe_id;
	private Integer				or_id;
	private String				or_name;
	private String				pe_name;
	private String				pe_poids;
	private String				pe_sex;
	private Date				pe_birthday;
	private String				pe_educational;
	private String				pe_nativeplace;
	private String				pe_nationality;
	private String				pe_political;
	private String				pe_identity;
	private Date				pe_workdate;
	private String				pe_profession;
	private String				pe_homeaddress;
	private String				pe_address;
	private String				pe_zipcode;
	private String				pe_remark;
	private String				pe_type;
	private String				pe_leader;
	private String				pe_del;
	private Integer				pe_sort;
	private String				op_sort;

	public V_Person() {
		super();
	}

	public V_Person(Integer pe_id) {
		super();
		this.pe_id = pe_id;
	}

	@Id
	public Integer getPe_id() {
		return pe_id;
	}

	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}

	@Column
	public Integer getOr_id() {
		return or_id;
	}

	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}

	@Column
	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	@Column
	public String getPe_name() {
		return pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	@Column
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

	@Column
	public String getPe_educational() {
		return pe_educational;
	}

	public void setPe_educational(String pe_educational) {
		this.pe_educational = pe_educational;
	}

	@Column
	public String getPe_nativeplace() {
		return pe_nativeplace;
	}

	public void setPe_nativeplace(String pe_nativeplace) {
		this.pe_nativeplace = pe_nativeplace;
	}

	@Column
	public String getPe_nationality() {
		return pe_nationality;
	}

	public void setPe_nationality(String pe_nationality) {
		this.pe_nationality = pe_nationality;
	}

	@Column
	public String getPe_political() {
		return pe_political;
	}

	public void setPe_political(String pe_political) {
		this.pe_political = pe_political;
	}

	@Column
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

	@Column
	public String getPe_profession() {
		return pe_profession;
	}

	public void setPe_profession(String pe_profession) {
		this.pe_profession = pe_profession;
	}

	@Column
	public String getPe_address() {
		return pe_address;
	}

	public void setPe_address(String pe_address) {
		this.pe_address = pe_address;
	}

	@Column
	public String getPe_zipcode() {
		return pe_zipcode;
	}

	public void setPe_zipcode(String pe_zipcode) {
		this.pe_zipcode = pe_zipcode;
	}

	@Column
	public String getPe_remark() {
		return pe_remark;
	}

	public void setPe_remark(String pe_remark) {
		this.pe_remark = pe_remark;
	}

	@Column
	public String getPe_homeaddress() {
		return pe_homeaddress;
	}

	public void setPe_homeaddress(String pe_homeaddress) {
		this.pe_homeaddress = pe_homeaddress;
	}

	@Column
	public String getPe_type() {
		return pe_type;
	}

	public void setPe_type(String pe_type) {
		this.pe_type = pe_type;
	}

	@Column
	public String getPe_leader() {
		return pe_leader;
	}

	public void setPe_leader(String pe_leader) {
		this.pe_leader = pe_leader;
	}

	@Column
	public String getPe_poids() {
		return pe_poids;
	}

	public void setPe_poids(String pe_poids) {
		this.pe_poids = pe_poids;
	}

	@Column
	public String getPe_del() {
		return pe_del;
	}

	public void setPe_del(String pe_del) {
		this.pe_del = pe_del;
	}

	@Column
	public Integer getPe_sort() {
		return pe_sort;
	}

	public void setPe_sort(Integer pe_sort) {
		this.pe_sort = pe_sort;
	}

	@Column
	public String getOp_sort() {
		return op_sort;
	}

	public void setOp_sort(String op_sort) {
		this.op_sort = op_sort;
	}
}
