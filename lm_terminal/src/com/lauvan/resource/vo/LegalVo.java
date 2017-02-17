package com.lauvan.resource.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class LegalVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = -6826653816453087676L;
	
	private Integer le_Id;
	/**
	 * 标题
	 */
	private String le_Name;
	/**
	 * 类别
	 */
	private Integer le_Typeid;
	/**
	 * 副标题
	 */
	private String le_Subtitle;
	/**
	 * 编号
	 */
	private String le_Code;
	/**
	 * 简短内容
	 */
	private String le_Shortcontent;
	/**
	 * 适用范围
	 */
	private String le_Range;
	/**
	 * 部门
	 */
	private String le_Lowdept;
	/**
	 * 生效日期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date le_Effectivedate;
	/**
	 * 有效期
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date le_Validity;
	/**
	 * 状态
	 */
	private String le_State;
	/**
	 * 存档路径
	 */
	private String le_Savedirectory;
	/**
	 * 文档格式
	 */
	private String le_Formate;
	/**
	 * 内容
	 */
	private String le_Content;
	/**
	 * 原件文件名
	 */
	private String le_Filename;
	public Integer getLe_Id() {
		return le_Id;
	}
	public void setLe_Id(Integer le_Id) {
		this.le_Id = le_Id;
	}
	public String getLe_Name() {
		return le_Name;
	}
	public void setLe_Name(String le_Name) {
		this.le_Name = le_Name;
	}
	public Integer getLe_Typeid() {
		return le_Typeid;
	}
	public void setLe_Typeid(Integer le_Typeid) {
		this.le_Typeid = le_Typeid;
	}
	public String getLe_Subtitle() {
		return le_Subtitle;
	}
	public void setLe_Subtitle(String le_Subtitle) {
		this.le_Subtitle = le_Subtitle;
	}
	public String getLe_Code() {
		return le_Code;
	}
	public void setLe_Code(String le_Code) {
		this.le_Code = le_Code;
	}
	public String getLe_Shortcontent() {
		return le_Shortcontent;
	}
	public void setLe_Shortcontent(String le_Shortcontent) {
		this.le_Shortcontent = le_Shortcontent;
	}
	public String getLe_Range() {
		return le_Range;
	}
	public void setLe_Range(String le_Range) {
		this.le_Range = le_Range;
	}
	public String getLe_Lowdept() {
		return le_Lowdept;
	}
	public void setLe_Lowdept(String le_Lowdept) {
		this.le_Lowdept = le_Lowdept;
	}
	public Date getLe_Effectivedate() {
		return le_Effectivedate;
	}
	public void setLe_Effectivedate(Date le_Effectivedate) {
		this.le_Effectivedate = le_Effectivedate;
	}
	public Date getLe_Validity() {
		return le_Validity;
	}
	public void setLe_Validity(Date le_Validity) {
		this.le_Validity = le_Validity;
	}
	public String getLe_State() {
		return le_State;
	}
	public void setLe_State(String le_State) {
		this.le_State = le_State;
	}
	public String getLe_Savedirectory() {
		return le_Savedirectory;
	}
	public void setLe_Savedirectory(String le_Savedirectory) {
		this.le_Savedirectory = le_Savedirectory;
	}
	public String getLe_Formate() {
		return le_Formate;
	}
	public void setLe_Formate(String le_Formate) {
		this.le_Formate = le_Formate;
	}
	public String getLe_Content() {
		return le_Content;
	}
	public void setLe_Content(String le_Content) {
		this.le_Content = le_Content;
	}
	public String getLe_Filename() {
		return le_Filename;
	}
	public void setLe_Filename(String le_Filename) {
		this.le_Filename = le_Filename;
	}
	
	
	
	

}
