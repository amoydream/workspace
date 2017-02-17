package com.lauvan.system.vo;

import com.lauvan.base.vo.BaseVo;
/**
 * 
 * ClassName: RoleInfoVo 
 * @Description: 角色Vo
 * @author 钮炜炜
 * @date 2015年9月9日 上午11:29:38
 */
public class RoleInfoVo extends BaseVo {
	private static final long serialVersionUID = -8848484855363962439L;
	private Integer ro_Id;
	/**
	 * 角色编码
	 */
	private String ro_Code;
	/**
	 * 名称
	 */
	private String ro_Name;
	/**
	 * 状态
	 */
	private Integer ro_State;
	/**
	 * 系数
	 */
	private Integer ro_Coefficient;
	/**
	 * 权限
	 */
	private String ro_Limits;
	/**
	 * 禁用权限
	 */
	private String ro_Xlimits;
	/**
	 * 备注
	 */
	private String ro_Remark;
	/**
	 * 模块id集
	 */
	private String moids;
	public Integer getRo_Id() {
		return ro_Id;
	}
	public void setRo_Id(Integer ro_Id) {
		this.ro_Id = ro_Id;
	}
	public String getRo_Code() {
		return ro_Code;
	}
	public void setRo_Code(String ro_Code) {
		this.ro_Code = ro_Code;
	}
	public String getRo_Name() {
		return ro_Name;
	}
	public void setRo_Name(String ro_Name) {
		this.ro_Name = ro_Name;
	}
	public Integer getRo_State() {
		return ro_State;
	}
	public void setRo_State(Integer ro_State) {
		this.ro_State = ro_State;
	}
	public Integer getRo_Coefficient() {
		return ro_Coefficient;
	}
	public void setRo_Coefficient(Integer ro_Coefficient) {
		this.ro_Coefficient = ro_Coefficient;
	}
	public String getRo_Limits() {
		return ro_Limits;
	}
	public void setRo_Limits(String ro_Limits) {
		this.ro_Limits = ro_Limits;
	}
	public String getRo_Xlimits() {
		return ro_Xlimits;
	}
	public void setRo_Xlimits(String ro_Xlimits) {
		this.ro_Xlimits = ro_Xlimits;
	}
	public String getRo_Remark() {
		return ro_Remark;
	}
	public void setRo_Remark(String ro_Remark) {
		this.ro_Remark = ro_Remark;
	}
	public String getMoids() {
		return moids;
	}
	public void setMoids(String moids) {
		this.moids = moids;
	}
}
