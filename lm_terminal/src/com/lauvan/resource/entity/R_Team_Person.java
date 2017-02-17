package com.lauvan.resource.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 队伍人员表
* @ClassName: R_Team_Person
* @Description: TODO
* @author zhou
* @date 2016年1月22日 下午4:04:27
*
 */
@Entity
@Table(name = "r_team_person")
@DynamicInsert(true)
@DynamicUpdate(true)
public class R_Team_Person implements java.io.Serializable {

	private static final long serialVersionUID = 6021700956307238661L;
	
	private R_Team_Person_Id id;

	public R_Team_Person() {
	}

	public R_Team_Person(R_Team_Person_Id id) {
		this.id = id;
	}


	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "teId", column = @Column(name = "te_Id", nullable = false)),
			@AttributeOverride(name = "peId", column = @Column(name = "pe_Id", nullable = false)) })
	public R_Team_Person_Id getId() {
		return this.id;
	}

	public void setId(R_Team_Person_Id id) {
		this.id = id;
	}


}