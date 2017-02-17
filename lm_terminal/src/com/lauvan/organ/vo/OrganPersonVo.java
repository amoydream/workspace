package com.lauvan.organ.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

/**
 * ClassName: C_Organ_Person
 * 
 * @Description: 组织人员表
 * @author 钮炜炜
 * @date 2015年12月1日 上午9:04:24
 */
public class OrganPersonVo extends BaseVo {
	private static final long	serialVersionUID	= -3563198423133464168L;
	private Integer				pe_id;
	/**
	 * 名字
	 */
	private String				pe_name;
	/**
	 * 所属组织
	 */
	private Integer				or_id;
	private String				or_name;
	/**
	 * 应急组织
	 */
	private Integer				eoId;
	/**
	 * 岗位
	 */
	private String				pe_jobs;
	private String				pe_poids;
	/**
	 * 手机
	 */
	// private String pe_mobilephone;
	/**
	 * 性别（M:女，F:男）
	 */
	private String				pe_sex;
	/**
	 * 出生年月
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
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
	 * 办公电话
	 */
	private String				officephone;
	/**
	 * 手机
	 */
	private String				mobilephone;
	/**
	 * 住宅电话
	 */
	private String				homephone;
	private String				fax;
	/**
	 * 邮箱
	 */
	private String				email;

	private String				bo_number;

	private Integer[]			pe_id_arr;

	/**
	 * 是否应急人员（0：否，1：是）
	 */
	private String				pe_type;
	/**
	 * 岗位id
	 */
	private Integer				po_id;
	private String				po_ids;

	/**
	 * 是否领导(用于事件报告的人。是为1)
	 */
	private String				pe_leader;

	private String				pe_del;

	private Integer				pe_sort;

	private Integer				pe_sort_old;

	public Integer getPe_id() {
		return pe_id;
	}

	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}

	public String getPe_name() {
		return pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	public Integer getOr_id() {
		return or_id;
	}

	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}

	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	public String getPe_jobs() {
		return pe_jobs;
	}

	public void setPe_jobs(String pe_jobs) {
		this.pe_jobs = pe_jobs;
	}

	public String getPe_sex() {
		return pe_sex;
	}

	public void setPe_sex(String pe_sex) {
		this.pe_sex = pe_sex;
	}

	public Date getPe_birthday() {
		return pe_birthday;
	}

	public void setPe_birthday(Date pe_birthday) {
		this.pe_birthday = pe_birthday;
	}

	public String getPe_educational() {
		return pe_educational;
	}

	public void setPe_educational(String pe_educational) {
		this.pe_educational = pe_educational;
	}

	public String getPe_nativeplace() {
		return pe_nativeplace;
	}

	public void setPe_nativeplace(String pe_nativeplace) {
		this.pe_nativeplace = pe_nativeplace;
	}

	public String getPe_nationality() {
		return pe_nationality;
	}

	public void setPe_nationality(String pe_nationality) {
		this.pe_nationality = pe_nationality;
	}

	public String getPe_political() {
		return pe_political;
	}

	public void setPe_political(String pe_political) {
		this.pe_political = pe_political;
	}

	public String getPe_identity() {
		return pe_identity;
	}

	public void setPe_identity(String pe_identity) {
		this.pe_identity = pe_identity;
	}

	public Date getPe_workdate() {
		return pe_workdate;
	}

	public void setPe_workdate(Date pe_workdate) {
		this.pe_workdate = pe_workdate;
	}

	public String getPe_profession() {
		return pe_profession;
	}

	public void setPe_profession(String pe_profession) {
		this.pe_profession = pe_profession;
	}

	public String getPe_homeaddress() {
		return pe_homeaddress;
	}

	public void setPe_homeaddress(String pe_homeaddress) {
		this.pe_homeaddress = pe_homeaddress;
	}

	public String getPe_address() {
		return pe_address;
	}

	public void setPe_address(String pe_address) {
		this.pe_address = pe_address;
	}

	public String getPe_zipcode() {
		return pe_zipcode;
	}

	public void setPe_zipcode(String pe_zipcode) {
		this.pe_zipcode = pe_zipcode;
	}

	public String getPe_remark() {
		return pe_remark;
	}

	public void setPe_remark(String pe_remark) {
		this.pe_remark = pe_remark;
	}

	public String getOfficephone() {
		return officephone;
	}

	public void setOfficephone(String officephone) {
		this.officephone = officephone;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public String getHomephone() {
		return homephone;
	}

	public void setHomephone(String homephone) {
		this.homephone = homephone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBo_number() {
		return bo_number;
	}

	public void setBo_number(String bo_number) {
		this.bo_number = bo_number;
	}

	public Integer getEoId() {
		return eoId;
	}

	public void setEoId(Integer eoId) {
		this.eoId = eoId;
	}

	public Integer[] getPe_id_arr() {
		return pe_id_arr;
	}

	public void setPe_id_arr(Integer[] pe_id_arr) {
		this.pe_id_arr = pe_id_arr;
	}

	public String getPe_type() {
		return pe_type;
	}

	public void setPe_type(String pe_type) {
		this.pe_type = pe_type;
	}

	public Integer getPo_id() {
		return po_id;
	}

	public void setPo_id(Integer po_id) {
		this.po_id = po_id;
	}

	public String getPe_leader() {
		return pe_leader;
	}

	public void setPe_leader(String pe_leader) {
		this.pe_leader = pe_leader;
	}

	public String getPo_ids() {
		return po_ids;
	}

	public void setPo_ids(String po_ids) {
		this.po_ids = po_ids;
	}

	public String getPe_poids() {
		return pe_poids;
	}

	public void setPe_poids(String pe_poids) {
		this.pe_poids = pe_poids;
	}

	public String getPe_del() {
		return pe_del;
	}

	public void setPe_del(String pe_del) {
		this.pe_del = pe_del;
	}

	public Integer getPe_sort() {
		return pe_sort;
	}

	public void setPe_sort(Integer pe_sort) {
		this.pe_sort = pe_sort;
	}

	public Integer getPe_sort_old() {
		return pe_sort_old;
	}

	public void setPe_sort_old(Integer pe_sort_old) {
		this.pe_sort_old = pe_sort_old;
	}
}
