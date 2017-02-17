package com.lauvan.dutymanage.entity;

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

import com.lauvan.organ.entity.C_Organ_Person;

@Entity
@Table(name = "t_duty_schedule")
public class T_Duty_Schedule implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				duty_sch_id;
	private Date				duty_date;
	private String				duty_prop;
	private String				duty_type;
	private C_Organ_Person		organPerson;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getDuty_sch_id() {
		return duty_sch_id;
	}

	public void setDuty_sch_id(Integer duty_sch_id) {
		this.duty_sch_id = duty_sch_id;
	}

	@Column
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
	public C_Organ_Person getOrganPerson() {
		return organPerson;
	}

	public void setOrganPerson(C_Organ_Person organPerson) {
		this.organPerson = organPerson;
	}
}
