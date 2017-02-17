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
@Table(name = "t_fax_send")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Fax_Send implements java.io.Serializable{

	private static final long serialVersionUID = 1496629996664571791L;
	private Integer fs_Id;
	/**
	 * 传真号码
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
	private Date fs_Time = new Date();
	/**
	 * 状态
	 */
	private String fs_Status;
	/**
	 * 通道号，用于核对最后是否发送成功的标识
	 */
	private Integer fs_Channelno ;
	
	@Id
	public Integer getFs_Id() {
		return fs_Id;
	}
	public void setFs_Id(Integer fs_Id) {
		this.fs_Id = fs_Id;
	}
	@Column(length=25, nullable=false)
	public String getFs_Faxnum() {
		return fs_Faxnum;
	}
	public void setFs_Faxnum(String fs_Faxnum) {
		this.fs_Faxnum = fs_Faxnum;
	}
	@Column(length=50, nullable=false)
	public String getFs_Filename() {
		return fs_Filename;
	}
	public void setFs_Filename(String fs_Filename) {
		this.fs_Filename = fs_Filename;
	}
	@Column(length=200, nullable=false)
	public String getFs_Path() {
		return fs_Path;
	}
	public void setFs_Path(String fs_Path) {
		this.fs_Path = fs_Path;
	}
	@Column(length=100)
	public String getFs_Title() {
		return fs_Title;
	}
	public void setFs_Title(String fs_Title) {
		this.fs_Title = fs_Title;
	}
	@Column(length=20)
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
	@Column(length=1, nullable=false)
	public String getFs_Status() {
		return fs_Status;
	}
	public void setFs_Status(String fs_Status) {
		this.fs_Status = fs_Status;
	}
	@Column(unique=true)
	public Integer getFs_Channelno() {
		return fs_Channelno;
	}
	public void setFs_Channelno(Integer fs_Channelno) {
		this.fs_Channelno = fs_Channelno;
	}
	
	
	

}
