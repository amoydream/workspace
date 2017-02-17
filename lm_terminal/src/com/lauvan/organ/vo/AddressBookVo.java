package com.lauvan.organ.vo;

/**
 * ClassName: C_Address_Book
 * 
 * @Description: 通讯录
 * @author 钮炜炜
 * @date 2015年12月1日 上午9:49:29
 */
public class AddressBookVo {

	private Integer	bo_id;
	/**
	 * 组织人员
	 */
	private Integer	pid;
	/**
	 * 组织
	 */
	private Integer	orid;
	/**
	 * 应急组织
	 */
	private Integer	eoid;

	/**
	 * 通讯类型
	 */
	private String	bo_type;
	/**
	 * 用户类型（1：个人，2：单位）
	 */
	private String	bo_usertype;
	/**
	 * 排序
	 */
	private Integer	bo_index;
	/**
	 * 通讯号码
	 */
	private String	bo_number;
	/**
	 * 状态（0：启用，1：停用）
	 */
	private String	bo_state;
	/**
	 * 备注
	 */
	private String	bo_remark;
	/**
	 * 常用联系号码（标记为1）
	 */
	private String	bo_favorite;

	private String	organName;
	private String	personName;
	private String	positionName;
	private Integer	sort_code;

	public Integer getBo_id() {
		return bo_id;
	}

	public void setBo_id(Integer bo_id) {
		this.bo_id = bo_id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Integer getOrid() {
		return orid;
	}

	public void setOrid(Integer orid) {
		this.orid = orid;
	}

	public String getBo_type() {
		return bo_type;
	}

	public void setBo_type(String bo_type) {
		this.bo_type = bo_type;
	}

	public Integer getBo_index() {
		return bo_index;
	}

	public void setBo_index(Integer bo_index) {
		this.bo_index = bo_index;
	}

	public String getBo_number() {
		return bo_number;
	}

	public void setBo_number(String bo_number) {
		this.bo_number = bo_number;
	}

	public String getBo_state() {
		return bo_state;
	}

	public void setBo_state(String bo_state) {
		this.bo_state = bo_state;
	}

	public String getBo_remark() {
		return bo_remark;
	}

	public void setBo_remark(String bo_remark) {
		this.bo_remark = bo_remark;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public Integer getEoid() {
		return eoid;
	}

	public void setEoid(Integer eoid) {
		this.eoid = eoid;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public String getBo_usertype() {
		return bo_usertype;
	}

	public void setBo_usertype(String bo_usertype) {
		this.bo_usertype = bo_usertype;
	}

	public String getBo_favorite() {
		return bo_favorite;
	}

	public void setBo_favorite(String bo_favorite) {
		this.bo_favorite = bo_favorite;
	}

	public Integer getSort_code() {
		return sort_code;
	}

	public void setSort_code(Integer sort_code) {
		this.sort_code = sort_code;
	}
}
