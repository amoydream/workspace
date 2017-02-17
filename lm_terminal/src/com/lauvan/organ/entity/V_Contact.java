package com.lauvan.organ.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_contact")
public class V_Contact implements Serializable {
	private static final long	serialVersionUID	= 6727816383800956912L;
	private String				contact_id;
	private String				contact_type;
	private Integer				pe_id;
	private Integer				or_id;
	private String				pe_name;
	private String				or_name;
	private String				pe_poids;
	private String				pe_type;
	private String				or_type;
	private String				tel_office;
	private String				tel_mobile;
	private String				fax_number;
	private String				email;
	private String				tel_home;
	private String				tel_number;
	private String				null_number;
	private Integer				bo_id_1;
	private String				bo_state_1;
	private Integer				bo_id_2;
	private String				bo_state_2;
	private Integer				bo_id_3;
	private String				bo_state_3;
	private Integer				bo_id_4;
	private String				bo_state_4;
	private Integer				bo_id_5;
	private String				bo_state_5;
	private String				pe_del;
	private String				c_sort;

	@Id
	public String getContact_id() {
		return contact_id;
	}

	public void setContact_id(String contact_id) {
		this.contact_id = contact_id;
	}

	@Column
	public String getContact_type() {
		return contact_type;
	}

	public void setContact_type(String contact_type) {
		this.contact_type = contact_type;
	}

	@Column
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
	public String getPe_name() {
		return pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	@Column
	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	@Column
	public String getPe_poids() {
		return pe_poids;
	}

	public void setPe_poids(String pe_poids) {
		this.pe_poids = pe_poids;
	}

	@Column
	public String getPe_type() {
		return pe_type;
	}

	public void setPe_type(String pe_type) {
		this.pe_type = pe_type;
	}

	@Column
	public String getOr_type() {
		return or_type;
	}

	public void setOr_type(String or_type) {
		this.or_type = or_type;
	}

	@Column
	public String getTel_office() {
		return tel_office;
	}

	public void setTel_office(String tel_office) {
		this.tel_office = tel_office;
	}

	@Column
	public String getTel_mobile() {
		return tel_mobile;
	}

	public void setTel_mobile(String tel_mobile) {
		this.tel_mobile = tel_mobile;
	}

	@Column
	public String getFax_number() {
		return fax_number;
	}

	public void setFax_number(String fax_number) {
		this.fax_number = fax_number;
	}

	@Column
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column
	public String getTel_home() {
		return tel_home;
	}

	public void setTel_home(String tel_home) {
		this.tel_home = tel_home;
	}

	@Column
	public String getTel_number() {
		return tel_number;
	}

	public void setTel_number(String tel_number) {
		this.tel_number = tel_number;

	}

	@Column
	public String getNull_number() {
		return null_number;
	}

	public void setNull_number(String null_number) {
		this.null_number = null_number;
	}

	@Column
	public Integer getBo_id_1() {
		return bo_id_1;
	}

	public void setBo_id_1(Integer bo_id_1) {
		this.bo_id_1 = bo_id_1;
	}

	@Column
	public String getBo_state_1() {
		return bo_state_1;
	}

	public void setBo_state_1(String bo_state_1) {
		this.bo_state_1 = bo_state_1;
	}

	@Column
	public Integer getBo_id_2() {
		return bo_id_2;
	}

	public void setBo_id_2(Integer bo_id_2) {
		this.bo_id_2 = bo_id_2;
	}

	@Column
	public String getBo_state_2() {
		return bo_state_2;
	}

	public void setBo_state_2(String bo_state_2) {
		this.bo_state_2 = bo_state_2;
	}

	@Column
	public Integer getBo_id_3() {
		return bo_id_3;
	}

	public void setBo_id_3(Integer bo_id_3) {
		this.bo_id_3 = bo_id_3;
	}

	@Column
	public String getBo_state_3() {
		return bo_state_3;
	}

	public void setBo_state_3(String bo_state_3) {
		this.bo_state_3 = bo_state_3;
	}

	@Column
	public Integer getBo_id_4() {
		return bo_id_4;
	}

	public void setBo_id_4(Integer bo_id_4) {
		this.bo_id_4 = bo_id_4;
	}

	@Column
	public String getBo_state_4() {
		return bo_state_4;
	}

	public void setBo_state_4(String bo_state_4) {
		this.bo_state_4 = bo_state_4;
	}

	@Column
	public Integer getBo_id_5() {
		return bo_id_5;
	}

	public void setBo_id_5(Integer bo_id_5) {
		this.bo_id_5 = bo_id_5;
	}

	@Column
	public String getBo_state_5() {
		return bo_state_5;
	}

	public void setBo_state_5(String bo_state_5) {
		this.bo_state_5 = bo_state_5;
	}

	@Column
	public String getPe_del() {
		return pe_del;
	}

	public void setPe_del(String pe_del) {
		this.pe_del = pe_del;
	}

	@Column
	public String getC_sort() {
		return c_sort;
	}

	public void setC_sort(String c_sort) {
		this.c_sort = c_sort;
	}
}
