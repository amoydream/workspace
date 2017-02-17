package com.lauvan.dutymanage.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "sms_template")
public class SMS_Template implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				tmpl_id;
	private String				content;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getTmpl_id() {
		return tmpl_id;
	}

	public void setTmpl_id(Integer tmpl_id) {
		this.tmpl_id = tmpl_id;
	}

	@Column(nullable = false, length = 140)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}