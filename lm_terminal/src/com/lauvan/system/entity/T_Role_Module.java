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
@Table(name = "t_role_module")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Role_Module implements java.io.Serializable {

	private static final long serialVersionUID = -2703714723968828345L;
	private T_Role_Module_Id id;

	public T_Role_Module() {
	}

	public T_Role_Module(T_Role_Module_Id id) {
		this.id = id;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "mo_Id", column = @Column),
			@AttributeOverride(name = "ro_Id", column = @Column) })
	public T_Role_Module_Id getId() {
		return this.id;
	}

	public void setId(T_Role_Module_Id id) {
		this.id = id;
	}

}