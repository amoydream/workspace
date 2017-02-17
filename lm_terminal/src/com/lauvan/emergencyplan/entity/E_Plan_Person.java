package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.organ.entity.C_Organ_Person;
/**
 * 
 * ClassName: E_Plan_Organ 
 * @Description: 应急预案机构人员表
 * @author 钮炜炜
 * @date 2015年12月10日 下午5:42:05
 */
@Entity
@Table(name = "e_plan_person")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Plan_Person implements Serializable{

	private static final long serialVersionUID = 3077351798860318241L;
	private Integer pp_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 机构ID
	 */
	private Integer or_id;
	/**
	 * 应急机构人员ID
	 */
	private C_Organ_Person organPerson;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getPp_id() {
		return pp_id;
	}
	public void setPp_id(Integer pp_id) {
		this.pp_id = pp_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@ManyToOne
	@JoinColumn(name = "op_id")
	public C_Organ_Person getOrganPerson() {
		return organPerson;
	}
	public void setOrganPerson(C_Organ_Person organPerson) {
		this.organPerson = organPerson;
	}
	public Integer getOr_id() {
		return or_id;
	}
	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}
	
}
