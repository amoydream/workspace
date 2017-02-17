package com.lauvan.dutymanage1.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.system.entity.T_User_Info;

/**
 * 
 * ClassName: D_Handover_Info 
 * @Description: 交接班信息表
 * @author 钮炜炜
 * @date 2016年3月7日 上午9:10:35
 */
@Entity
@Table(name = "D_Handover_Info")
@DynamicInsert(true)
@DynamicUpdate(true)
public class D_Handover_Info implements java.io.Serializable {

	private static final long serialVersionUID = 340497786326545343L;
	private Integer ha_Id;
	/**
	 * 交班人
	 */
	private T_User_Info us_Hander;
	/**
	 * 接班人
	 */
	private T_User_Info us_Overer;
	/**
	 * 交接事宜
	 */
	private String ha_Content;
	/**
	 * 交接时间
	 */
	private Date ha_Date;
	/**
	 * 状态0：未完成，1：已完成
	 */
	private String ha_state = "0";

	public D_Handover_Info(){
	}
	
	@Id
	public Integer getHa_Id() {
		return ha_Id;
	}
	
	public void setHa_Id(Integer ha_Id) {
		this.ha_Id = ha_Id;
	}
	
	@Column(length = 200)
	public String getHa_Content() {
		return ha_Content;
	}
	
	public void setHa_Content(String ha_Content) {
		this.ha_Content = ha_Content;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	public Date getHa_Date() {
		return ha_Date;
	}
	
	public void setHa_Date(Date ha_Date) {
		this.ha_Date = ha_Date;
	}

	@Column(length=1,nullable=false)
	public String getHa_state() {
		return ha_state;
	}

	public void setHa_state(String ha_state) {
		this.ha_state = ha_state;
	}
	@ManyToOne
	@JoinColumn(name="us_Handid")
	public T_User_Info getUs_Hander() {
		return us_Hander;
	}

	public void setUs_Hander(T_User_Info us_Hander) {
		this.us_Hander = us_Hander;
	}
	@ManyToOne
	@JoinColumn(name="us_Overid")
	public T_User_Info getUs_Overer() {
		return us_Overer;
	}

	public void setUs_Overer(T_User_Info us_Overer) {
		this.us_Overer = us_Overer;
	}

}
