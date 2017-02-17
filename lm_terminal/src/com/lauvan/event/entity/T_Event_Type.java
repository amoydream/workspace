package com.lauvan.event.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 
 * ClassName: T_Event_Type 
 * @Description: 事件类型
 * @author 钮炜炜
 * @date 2015年12月3日 上午9:56:55
 */
@Entity
@Table(name = "t_event_type")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Event_Type implements Serializable {

	private static final long serialVersionUID = -8028535361657600153L;
	private Integer et_id;
	/**
	 * 编号
	 */
	private String et_code;
	/**
	 * 名称
	 */
	private String et_name;
	private T_Event_Type eventType;
	
	public T_Event_Type() {
		super();
	}
	public T_Event_Type(Integer et_id) {
		super();
		this.et_id = et_id;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEt_id() {
		return et_id;
	}
	public void setEt_id(Integer et_id) {
		this.et_id = et_id;
	}
	@Column(length=10)
	public String getEt_code() {
		return et_code;
	}
	public void setEt_code(String et_code) {
		this.et_code = et_code;
	}
	@Column(length=20,nullable=false)
	public String getEt_name() {
		return et_name;
	}
	public void setEt_name(String et_name) {
		this.et_name = et_name;
	}
	@ManyToOne
	@JoinColumn(name = "et_pid")
	public T_Event_Type getEventType() {
		return eventType;
	}
	public void setEventType(T_Event_Type eventType) {
		this.eventType = eventType;
	}
	
}
