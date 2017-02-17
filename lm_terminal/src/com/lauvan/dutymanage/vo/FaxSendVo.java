package com.lauvan.dutymanage.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class FaxSendVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 693520664004623479L;
	private Integer fs_Id;
	/**
	 * 发送号码
	 */
	private String fs_Faxnum;
	/**
	 * 文件名称
	 */
	private String fs_Filename;
	/**
	 * 保存路径
	 */
	private String fs_Path;
	/**
	 * 标题
	 */
	private String fs_Title;
	/**
	 * 处理人
	 */
	private String fs_Dealman;
	/**
	 * 操作时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date fs_Time;
	/**
	 * 状态
	 */
	private String fs_Status;
	
	public Integer getFs_Id() {
		return fs_Id;
	}
	public void setFs_Id(Integer fs_Id) {
		this.fs_Id = fs_Id;
	}
	public String getFs_Faxnum() {
		return fs_Faxnum;
	}
	public void setFs_Faxnum(String fs_Faxnum) {
		this.fs_Faxnum = fs_Faxnum;
	}
	public String getFs_Filename() {
		return fs_Filename;
	}
	public void setFs_Filename(String fs_Filename) {
		this.fs_Filename = fs_Filename;
	}
	public String getFs_Path() {
		return fs_Path;
	}
	public void setFs_Path(String fs_Path) {
		this.fs_Path = fs_Path;
	}
	public String getFs_Title() {
		return fs_Title;
	}
	public void setFs_Title(String fs_Title) {
		this.fs_Title = fs_Title;
	}
	public String getFs_Dealman() {
		return fs_Dealman;
	}
	public void setFs_Dealman(String fs_Dealman) {
		this.fs_Dealman = fs_Dealman;
	}
	public Date getFs_Time() {
		return fs_Time;
	}
	public void setFs_Time(Date fs_Time) {
		this.fs_Time = fs_Time;
	}
	public String getFs_Status() {
		return fs_Status;
	}
	public void setFs_Status(String fs_Status) {
		this.fs_Status = fs_Status;
	}
	

}
