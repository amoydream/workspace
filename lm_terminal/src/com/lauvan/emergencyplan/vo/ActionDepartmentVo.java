package com.lauvan.emergencyplan.vo;

/**
 * 
 * ClassName: E_Action_Department 
 * @Description: 预案应急处置阶段流程-行动清单-执行人员表
 * @author 钮炜炜
 * @date 2015年12月12日 下午2:27:31
 */
public class ActionDepartmentVo{

	private Integer ead_id;
	/**
	 * 备注
	 */
	private String ead_remark;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 行动清单
	 */
	private Integer eal_id;
	/**
	 * 执行人员
	 */
	private Integer aBooksId;
	public Integer getEad_id() {
		return ead_id;
	}
	public void setEad_id(Integer ead_id) {
		this.ead_id = ead_id;
	}
	public String getEad_remark() {
		return ead_remark;
	}
	public void setEad_remark(String ead_remark) {
		this.ead_remark = ead_remark;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	public Integer getEal_id() {
		return eal_id;
	}
	public void setEal_id(Integer eal_id) {
		this.eal_id = eal_id;
	}
	public Integer getaBooksId() {
		return aBooksId;
	}
	public void setaBooksId(Integer aBooksId) {
		this.aBooksId = aBooksId;
	}
	
}
