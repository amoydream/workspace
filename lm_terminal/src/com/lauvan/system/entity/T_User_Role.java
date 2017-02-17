package com.lauvan.system.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


@Entity
@Table(name = "t_user_role")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_User_Role implements java.io.Serializable {

	private static final long serialVersionUID = -5216977966719708166L;
	private T_User_Role_Id id;

	public T_User_Role() {
	}

	public T_User_Role(T_User_Role_Id id) {
		this.id = id;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "usId", column = @Column),
			@AttributeOverride(name = "roId", column = @Column) })
	public T_User_Role_Id getId() {
		return this.id;
	}

	public void setId(T_User_Role_Id id) {
		this.id = id;
	}

}