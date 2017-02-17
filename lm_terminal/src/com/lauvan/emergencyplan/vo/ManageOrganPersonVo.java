package com.lauvan.emergencyplan.vo;

public class ManageOrganPersonVo {

	/**
	 * 应急机构ID
	 */
	private Integer eoId;
	/**
	 * 机构人员ID
	 */
	private Integer eppId;
	/**
	 * 机构(人员)名称
	 */
	private String name;
	/**
	 * 职责(职务)
	 */
	private String job;
	/**
	 * 应急预案机构人员主键ID
	 */
	private Integer pp_id;
	public ManageOrganPersonVo() {
		super();
	}
	public ManageOrganPersonVo(Integer eoId, Integer eppId, String name,
			String job) {
		super();
		this.eoId = eoId;
		this.eppId = eppId;
		this.name = name;
		this.job = job;
	}
	public Integer getEoId() {
		return eoId;
	}
	public void setEoId(Integer eoId) {
		this.eoId = eoId;
	}
	public Integer getEppId() {
		return eppId;
	}
	public void setEppId(Integer eppId) {
		this.eppId = eppId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Integer getPp_id() {
		return pp_id;
	}
	public void setPp_id(Integer pp_id) {
		this.pp_id = pp_id;
	}
}
