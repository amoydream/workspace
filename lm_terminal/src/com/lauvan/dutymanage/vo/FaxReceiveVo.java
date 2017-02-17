package com.lauvan.dutymanage.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.vo.BaseVo;

public class FaxReceiveVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 693520664004623479L;
	private Integer fr_Id;
	/**
	 * 发送号码
	 */
	private String fr_Faxnum;
	/**
	 * 文件名称
	 */
	private String fr_Filename;
	/**
	 * 保存路径
	 */
	private String fr_Path;
	/**
	 * 标题
	 */
	private String fr_Title;
	/**
	 * 处理人
	 */
	private String fr_Dealman;
	/**
	 * 操作时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date fr_Time;
	/**
	 * 状态
	 */
	private String fr_Status;
	
	public Integer getFr_Id() {
		return fr_Id;
	}
	public void setFr_Id(Integer fr_Id) {
		this.fr_Id = fr_Id;
	}
	public String getFr_Faxnum() {
		return fr_Faxnum;
	}
	public void setFr_Faxnum(String fr_Faxnum) {
		this.fr_Faxnum = fr_Faxnum;
	}
	public String getFr_Filename() {
		return fr_Filename;
	}
	public void setFr_Filename(String fr_Filename) {
		this.fr_Filename = fr_Filename;
	}
	public String getFr_Path() {
		return fr_Path;
	}
	public void setFr_Path(String fr_Path) {
		this.fr_Path = fr_Path;
	}
	public String getFr_Title() {
		return fr_Title;
	}
	public void setFr_Title(String fr_Title) {
		this.fr_Title = fr_Title;
	}
	public String getFr_Dealman() {
		return fr_Dealman;
	}
	public void setFr_Dealman(String fr_Dealman) {
		this.fr_Dealman = fr_Dealman;
	}
	public Date getFr_Time() {
		return fr_Time;
	}
	public void setFr_Time(Date fr_Time) {
		this.fr_Time = fr_Time;
	}
	public String getFr_Status() {
		return fr_Status;
	}
	public void setFr_Status(String fr_Status) {
		this.fr_Status = fr_Status;
	}
	

}
