package com.lauvan.organ.vo;

public class BookVo {
	private Integer	bo_id;
	private String	bo_type		= "";
	private String	bo_usertype	= "";
	private Integer	bo_index;
	private String	bo_number	= "";
	private String	bo_typeDesc	= "";
	private String	bo_state	= "";
	private String	bo_remark	= "";
	private String	bo_favorite	= "";

	public Integer getBo_id() {
		return bo_id;
	}

	public void setBo_id(Integer bo_id) {
		this.bo_id = bo_id;
	}

	public String getBo_type() {
		return bo_type;
	}

	public void setBo_type(String bo_type) {
		this.bo_type = bo_type;
	}

	public String getBo_usertype() {
		return bo_usertype;
	}

	public void setBo_usertype(String bo_usertype) {
		this.bo_usertype = bo_usertype;
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

	public String getBo_typeDesc() {
		if("1" == bo_type) {
			bo_typeDesc = "住宅电话";
		} else if("2" == bo_type) {
			bo_typeDesc = "手机号码";
		} else if("3" == bo_type) {
			bo_typeDesc = "办公电话";
		} else if("4" == bo_type) {
			bo_typeDesc = "传真";
		} else if("5" == bo_type) {
			bo_typeDesc = "电子邮箱";
		}

		return bo_typeDesc;
	}

	public void setBo_typeDesc(String bo_typeDesc) {
		this.bo_typeDesc = bo_typeDesc;
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

	public String getBo_favorite() {
		return bo_favorite;
	}

	public void setBo_favorite(String bo_favorite) {
		this.bo_favorite = bo_favorite;
	}

}
