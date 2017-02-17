package com.lauvan.dutymanage.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "t_fax_receive")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Fax_Receive implements java.io.Serializable{

	private static final long serialVersionUID = 1496629996664571791L;
	private Integer fr_Id;
	/**
	 * 传真号码（接收传真时为发送方号码，发送时为接收方号码）
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
	private Date fr_Time = new Date();
	/**
	 * 状态
	 */
	private String fr_Status;
	
	@Id
	public Integer getFr_Id() {
		return fr_Id;
	}
	public void setFr_Id(Integer fr_Id) {
		this.fr_Id = fr_Id;
	}
	@Column(length=25, nullable=false)
	public String getFr_Faxnum() {
		return fr_Faxnum;
	}
	public void setFr_Faxnum(String fr_Faxnum) {
		this.fr_Faxnum = fr_Faxnum;
	}
	@Column(length=50, nullable=false)
	public String getFr_Filename() {
		return fr_Filename;
	}
	public void setFr_Filename(String fr_Filename) {
		this.fr_Filename = fr_Filename;
	}
	@Column(length=200, nullable=false)
	public String getFr_Path() {
		return fr_Path;
	}
	public void setFr_Path(String fr_Path) {
		this.fr_Path = fr_Path;
	}
	@Column(length=100)
	public String getFr_Title() {
		return fr_Title;
	}
	public void setFr_Title(String fr_Title) {
		this.fr_Title = fr_Title;
	}
	@Column(length=20)
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
	@Column(length=1, nullable=false)
	public String getFr_Status() {
		return fr_Status;
	}
	public void setFr_Status(String fr_Status) {
		this.fr_Status = fr_Status;
	}
	
}
