package com.lauvan.system.vo;

import com.lauvan.base.vo.BaseVo;
/**
 * 
 * ClassName: VoiceTableVo 
 * @Description: 语音坐席Vo
 * @author 周志高
 * @date 2015年9月18日 下午2:21:07
 */
public class VoiceTableVo extends BaseVo{

	private static final long serialVersionUID = -3827505292234353879L;
	
	private Integer vo_Id;
	private Integer vo_Code;
	private String vo_Ip;
	private Integer vo_Phone;
	private String vo_Usercode;
	private Integer vo_Group;
	private String vo_Level;
	
	public Integer getVo_Id() {
		return vo_Id;
	}
	public void setVo_Id(Integer vo_Id) {
		this.vo_Id = vo_Id;
	}
	public Integer getVo_Code() {
		return vo_Code;
	}
	public void setVo_Code(Integer vo_Code) {
		this.vo_Code = vo_Code;
	}
	public String getVo_Ip() {
		return vo_Ip;
	}
	public void setVo_Ip(String vo_Ip) {
		this.vo_Ip = vo_Ip;
	}
	public Integer getVo_Phone() {
		return vo_Phone;
	}
	public void setVo_Phone(Integer vo_Phone) {
		this.vo_Phone = vo_Phone;
	}
	public String getVo_Usercode() {
		return vo_Usercode;
	}
	public void setVo_Usercode(String vo_Usercode) {
		this.vo_Usercode = vo_Usercode;
	}
	public Integer getVo_Group() {
		return vo_Group;
	}
	public void setVo_Group(Integer vo_Group) {
		this.vo_Group = vo_Group;
	}
	public String getVo_Level() {
		return vo_Level;
	}
	public void setVo_Level(String vo_Level) {
		this.vo_Level = vo_Level;
	}
	
	

}
