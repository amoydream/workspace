package com.lauvan.emergencyplan.vo;

/**
 * 
 * ClassName: E_Action_List 
 * @Description: 预案应急处置阶段流程-行动清单表
 * @author 钮炜炜
 * @date 2015年12月12日 下午2:22:07
 */
public class ActionListVo {

	private Integer eal_id;
	/**
	 * 名称
	 */
	private String eal_name;
	/**
	 * 代号
	 */
	private String eal_no;
	/**
	 * 事件级别
	 */
	private String eal_level;
	/**
	 * 内容
	 */
	private String eal_content;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	
	private Integer dStageId;

	public Integer getEal_id() {
		return eal_id;
	}

	public void setEal_id(Integer eal_id) {
		this.eal_id = eal_id;
	}

	public String getEal_name() {
		return eal_name;
	}

	public void setEal_name(String eal_name) {
		this.eal_name = eal_name;
	}

	public String getEal_no() {
		return eal_no;
	}

	public void setEal_no(String eal_no) {
		this.eal_no = eal_no;
	}

	public String getEal_level() {
		return eal_level;
	}

	public void setEal_level(String eal_level) {
		this.eal_level = eal_level;
	}

	public String getEal_content() {
		return eal_content;
	}

	public void setEal_content(String eal_content) {
		this.eal_content = eal_content;
	}

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}

	public Integer getdStageId() {
		return dStageId;
	}

	public void setdStageId(Integer dStageId) {
		this.dStageId = dStageId;
	}
	
}
