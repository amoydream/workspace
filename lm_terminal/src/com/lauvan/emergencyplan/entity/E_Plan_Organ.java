package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: E_Plan_Organ 
 * @Description: 应急预案机构表
 * @author 钮炜炜
 * @date 2015年12月10日 下午5:42:05
 */
@Entity
@Table(name = "e_plan_organ")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Plan_Organ implements Serializable{

	private static final long serialVersionUID = 3077351798860318241L;
	private E_Plan_Organ_Id id;
	/**
	 * 应急机构父
	 */
	private Integer por_id;
	
	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "pi_id", column = @Column),
			@AttributeOverride(name = "or_id", column = @Column) })
	public E_Plan_Organ_Id getId() {
		return id;
	}
	public void setId(E_Plan_Organ_Id id) {
		this.id = id;
	}
	public Integer getPor_id() {
		return por_id;
	}
	public void setPor_id(Integer por_id) {
		this.por_id = por_id;
	}
	
}
