package com.lauvan.emergencyplan.vo;

public class PlanTypeVo {

	private Integer pt_id;
	/**
	 * 名称
	 */
	private String pt_name;
	/**
	 * 描述
	 */
	private String pt_desc;
	/**
	 * 备注
	 */
	private String pt_remark;
	/**
	 * 父ID
	 */
	private Integer pid;
	public Integer getPt_id() {
		return pt_id;
	}
	public void setPt_id(Integer pt_id) {
		this.pt_id = pt_id;
	}
	public String getPt_name() {
		return pt_name;
	}
	public void setPt_name(String pt_name) {
		this.pt_name = pt_name;
	}
	public String getPt_desc() {
		return pt_desc;
	}
	public void setPt_desc(String pt_desc) {
		this.pt_desc = pt_desc;
	}
	public String getPt_remark() {
		return pt_remark;
	}
	public void setPt_remark(String pt_remark) {
		this.pt_remark = pt_remark;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
}
