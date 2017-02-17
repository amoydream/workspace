package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * 
 * ClassName: E_Plan_Legal 
 * @Description: 预案-法律法规中间表
 * @author 钮炜炜
 * @date 2016年1月22日 下午4:10:23
 */
@Entity
@Table(name = "e_plan_legal")
public class E_Plan_Legal implements Serializable{

	private static final long serialVersionUID = -7934348863759187807L;
	private E_Plan_Legal_Id id;

	public E_Plan_Legal() {
		super();
	}

	public E_Plan_Legal(E_Plan_Legal_Id id) {
		super();
		this.id = id;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "pi_id", column = @Column),
			@AttributeOverride(name = "le_id", column = @Column) })
	public E_Plan_Legal_Id getId() {
		return id;
	}

	public void setId(E_Plan_Legal_Id id) {
		this.id = id;
	}
}
