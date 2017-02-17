package com.lauvan.dutymanage1.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lauvan.organ.entity.C_Organ_Person;
/**
 * 
 * ClassName: T_Duty_Schedule1 
 * @Description: 值班排班
 * @author 钮炜炜
 * @date 2016年3月4日 下午4:48:50
 */
@Entity
@Table(name = "t_duty_schedule1")
public class T_Duty_Schedule1 implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer duty_id;
	/**
	 * 值班日期
	 */
	private Date duty_date;
	/**
	 * 值班性质
	 */
	private String duty_prop;
	/**
	 * 值班类型
	 */
	private String duty_type;
	private C_Organ_Person person;
	/**
	 * 是否模板（1）
	 */
	private String duty_temp;
	/**
	 * 是否上级领导（1是，0不是）
	 */
	private String duty_ifleader;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getDuty_id() {
		return duty_id;
	}

	public void setDuty_id(Integer duty_id) {
		this.duty_id = duty_id;
	}

	@Temporal(TemporalType.DATE)
	public Date getDuty_date() {
		return duty_date;
	}

	public void setDuty_date(Date duty_date) {
		this.duty_date = duty_date;
	}

	@Column(nullable = false)
	public String getDuty_prop() {
		return duty_prop;
	}

	public void setDuty_prop(String duty_prop) {
		this.duty_prop = duty_prop;
	}

	@Column(nullable = false)
	public String getDuty_type() {
		return duty_type;
	}

	public void setDuty_type(String duty_type) {
		this.duty_type = duty_type;
	}
	@ManyToOne
	@JoinColumn(name = "pe_id")
	public C_Organ_Person getPerson() {
		return person;
	}

	public void setPerson(C_Organ_Person person) {
		this.person = person;
	}
	@Column(length=1)
	public String getDuty_temp() {
		return duty_temp;
	}

	public void setDuty_temp(String duty_temp) {
		this.duty_temp = duty_temp;
	}
	@Column(length=1)
	public String getDuty_ifleader() {
		return duty_ifleader;
	}

	public void setDuty_ifleader(String duty_ifleader) {
		this.duty_ifleader = duty_ifleader;
	}
	
}
