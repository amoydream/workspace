package com.lauvan.system.vo;

import java.util.List;

import com.lauvan.base.vo.BaseVo;

/**
 * 
 * ClassName: UserInfoVo 
 * @Description: 用户Vo
 * @author 钮炜炜
 * @date 2015年9月10日 上午8:39:08
 */
public class UserInfoVo extends BaseVo{
	private static final long serialVersionUID = 1L;
	private Integer us_Id;
	/**
	 * 用户名
	 */
	private String us_Code;
	/**
	 * 组织ID
	 */
	private Integer org_Id;
	/**
	 * 姓名
	 */
	private String us_Name;
	/**
	 * 密码
	 */
	private String us_Pass;
	/**
	 * 年龄
	 */
	private Integer us_Age;
	/**
	 * 性别
	 */
	private String us_Sex;
	/**
	 * 手机
	 */
	private String us_Mophone;
	/**
	 * 工作电话
	 */
	private String us_Offphone;	
	/**
	 * 住址
	 */
	private String us_Address;
	/**
	 * 备注说明
	 */
	private String us_Remark;
	/**
	 * 状态：1：启用，0：停用
	 */
	private String us_State;
	/**
	 * 组织名称
	 */
	private String or_name;
	/**
	 * 权限集合
	 */
	private List<String> permissions;
	/**
	 * 系统菜单集合
	 */
	private List<Integer> momenus;
	/**
	 * 用户登录IP
	 */
	private String ip;
	/**
	 * 坐席
	 */
	private String voice;
	/**
	 * 语音存放ip
	 */
	private String voiceip;
	/**
	 * 是否可以打电话(1可以0不可以)
	 */
	private String callif;
	
	public UserInfoVo() {
	}
	public UserInfoVo(Integer us_Id, String us_Name) {
		this.us_Id = us_Id;
		this.us_Name = us_Name;
	}
	public Integer getUs_Id() {
		return us_Id;
	}
	public void setUs_Id(Integer us_Id) {
		this.us_Id = us_Id;
	}
	public String getUs_Code() {
		return us_Code;
	}
	public void setUs_Code(String us_Code) {
		this.us_Code = us_Code;
	}
	public Integer getOrg_Id() {
		return org_Id;
	}
	public void setOrg_Id(Integer org_Id) {
		this.org_Id = org_Id;
	}
	public String getUs_Name() {
		return us_Name;
	}
	public void setUs_Name(String us_Name) {
		this.us_Name = us_Name;
	}
	public String getUs_Pass() {
		return us_Pass;
	}
	public void setUs_Pass(String us_Pass) {
		this.us_Pass = us_Pass;
	}
	public Integer getUs_Age() {
		return us_Age;
	}
	public void setUs_Age(Integer us_Age) {
		this.us_Age = us_Age;
	}
	public String getUs_Sex() {
		return us_Sex;
	}
	public void setUs_Sex(String us_Sex) {
		this.us_Sex = us_Sex;
	}
	public String getUs_Mophone() {
		return us_Mophone;
	}
	public void setUs_Mophone(String us_Mophone) {
		this.us_Mophone = us_Mophone;
	}
	public String getUs_Offphone() {
		return us_Offphone;
	}
	public void setUs_Offphone(String us_Offphone) {
		this.us_Offphone = us_Offphone;
	}
	public String getUs_Address() {
		return us_Address;
	}
	public void setUs_Address(String us_Address) {
		this.us_Address = us_Address;
	}
	public String getUs_Remark() {
		return us_Remark;
	}
	public void setUs_Remark(String us_Remark) {
		this.us_Remark = us_Remark;
	}
	public String getUs_State() {
		return us_State;
	}
	public void setUs_State(String us_State) {
		this.us_State = us_State;
	}
	public String getOr_name() {
		return or_name;
	}
	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getVoice() {
		return voice;
	}
	public void setVoice(String voice) {
		this.voice = voice;
	}
	public List<String> getPermissions() {
		return permissions;
	}
	public void setPermissions(List<String> permissions) {
		this.permissions = permissions;
	}
	public List<Integer> getMomenus() {
		return momenus;
	}
	public void setMomenus(List<Integer> momenus) {
		this.momenus = momenus;
	}
	public String getVoiceip() {
		return voiceip;
	}
	public void setVoiceip(String voiceip) {
		this.voiceip = voiceip;
	}
	public String getCallif() {
		return callif;
	}
	public void setCallif(String callif) {
		this.callif = callif;
	}
	
}
