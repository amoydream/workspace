package com.lauvan.organ.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_contact_group")
public class T_Contact_Group implements Serializable {
	private static final long	serialVersionUID	= 6727816383800956912L;
	private Integer				id;
	private String				name;
	private String				contactIds;

	public T_Contact_Group() {
	}

	public T_Contact_Group(Integer id) {
		super();
		this.id = id;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(length = 20, nullable = false)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(length = 255)
	public String getContactIds() {
		return contactIds;
	}

	public void setContactIds(String contactIds) {
		this.contactIds = contactIds;
	}
}
