package com.lauvan.system.vo;

import com.lauvan.base.vo.BaseVo;
/**
 * 
 * ClassName: ModuleInfoVo 
 * @Description: 模块Vo
 * @author 钮炜炜
 * @date 2015年9月9日 下午4:17:16
 */
public class ModuleInfoVo extends BaseVo {

	private static final long serialVersionUID = 5372923674589775322L;

	private Integer mo_Id;
	/**
	 * 模块名称
	 */
	private String mo_Name;
	/**
	 * 模块编码
	 */
	private String mo_Code;
	/**
	 * 模块路径
	 */
	private String mo_Url;
	/**
	 * 父级ID
	 */
	private Integer mo_Pid;
	/**
	 * 级别(1:菜单和2:功能)
	 */
	private String mo_Step;
	/**
	 * 状态1:有效0：无效
	 */
	private String mo_State="1";
	/**
	 * 索引
	 */
	private Integer mo_Index;
	/**
	 * 备注
	 */
	private String mo_Remark;
	/**
	 * 图标
	 */
	private String mo_Icon;
    
	/**
	 * 模块样式
	 */
	private String mo_Class;
	public Integer getMo_Id() {
		return mo_Id;
	}
	public void setMo_Id(Integer mo_Id) {
		this.mo_Id = mo_Id;
	}
	public String getMo_Name() {
		return mo_Name;
	}
	public void setMo_Name(String mo_Name) {
		this.mo_Name = mo_Name;
	}
	public String getMo_Code() {
		return mo_Code;
	}
	public void setMo_Code(String mo_Code) {
		this.mo_Code = mo_Code;
	}
	public String getMo_Url() {
		return mo_Url;
	}
	public void setMo_Url(String mo_Url) {
		this.mo_Url = mo_Url;
	}
	public Integer getMo_Pid() {
		return mo_Pid;
	}
	public void setMo_Pid(Integer mo_Pid) {
		this.mo_Pid = mo_Pid;
	}
	public String getMo_Step() {
		return mo_Step;
	}
	public void setMo_Step(String mo_Step) {
		this.mo_Step = mo_Step;
	}
	public String getMo_State() {
		return mo_State;
	}
	public void setMo_State(String mo_State) {
		this.mo_State = mo_State;
	}
	public Integer getMo_Index() {
		return mo_Index;
	}
	public void setMo_Index(Integer mo_Index) {
		this.mo_Index = mo_Index;
	}
	public String getMo_Remark() {
		return mo_Remark;
	}
	public void setMo_Remark(String mo_Remark) {
		this.mo_Remark = mo_Remark;
	}
	public String getMo_Icon() {
		return mo_Icon;
	}
	public void setMo_Icon(String mo_Icon) {
		this.mo_Icon = mo_Icon;
	}
	public String getMo_Class() {
		return mo_Class;
	}
	public void setMo_Class(String mo_Class) {
		this.mo_Class = mo_Class;
	}
}
