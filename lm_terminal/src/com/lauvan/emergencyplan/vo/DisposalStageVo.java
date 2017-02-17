package com.lauvan.emergencyplan.vo;

/**
 * 
 * ClassName: E_Disposal_Stage 
 * @Description: 预案应急处置阶段流程表
 * @author 钮炜炜
 * @date 2015年12月12日 下午2:13:29
 */
public class DisposalStageVo {

	private Integer eds_id;
	/**
	 * 阶段名称
	 */
	private String eds_name;
	/**
	 * 执行序号
	 */
	private Integer eds_index;
	/**
	 * 任务说明
	 */
	private String eds_task;
	/**
	 * 备注
	 */
	private String eds_remark;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	
	private Integer eds_pid;

	public Integer getEds_id() {
		return eds_id;
	}

	public void setEds_id(Integer eds_id) {
		this.eds_id = eds_id;
	}

	public String getEds_name() {
		return eds_name;
	}

	public void setEds_name(String eds_name) {
		this.eds_name = eds_name;
	}

	public Integer getEds_index() {
		return eds_index;
	}

	public void setEds_index(Integer eds_index) {
		this.eds_index = eds_index;
	}

	public String getEds_task() {
		return eds_task;
	}

	public void setEds_task(String eds_task) {
		this.eds_task = eds_task;
	}

	public String getEds_remark() {
		return eds_remark;
	}

	public void setEds_remark(String eds_remark) {
		this.eds_remark = eds_remark;
	}

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}

	public Integer getEds_pid() {
		return eds_pid;
	}

	public void setEds_pid(Integer eds_pid) {
		this.eds_pid = eds_pid;
	}
	
}
