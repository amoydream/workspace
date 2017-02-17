package com.lauvan.event.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
/**
 * 
 * ClassName: E_Eventdoc 
 * @Description: 事件附件
 * @author 钮炜炜
 * @date 2016年4月24日 上午11:41:43
 */
@Entity
@Table(name = "e_eventdoc")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Eventdoc implements Serializable{

	private static final long serialVersionUID = 8742283268374434021L;
	private Integer edoc_id;
	private Integer ev_id;
	
	private String edoc_name;
	private String edoc_desc;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEdoc_id() {
		return edoc_id;
	}
	public void setEdoc_id(Integer edoc_id) {
		this.edoc_id = edoc_id;
	}
	public Integer getEv_id() {
		return ev_id;
	}
	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}
	@Column(length=100)
	public String getEdoc_name() {
		return edoc_name;
	}
	public void setEdoc_name(String edoc_name) {
		this.edoc_name = edoc_name;
	}
	@Column(length=200)
	public String getEdoc_desc() {
		return edoc_desc;
	}
	public void setEdoc_desc(String edoc_desc) {
		this.edoc_desc = edoc_desc;
	}
}
