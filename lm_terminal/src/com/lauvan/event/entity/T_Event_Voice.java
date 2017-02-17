package com.lauvan.event.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
/**
 * 
 * ClassName: T_Event_Voice 
 * @Description: 事件录音关联表
 * @author 钮炜炜
 * @date 2016年1月13日 上午10:18:30
 */
@Entity
@Table(name = "t_event_voice")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_Event_Voice implements Serializable{

	private static final long serialVersionUID = 2817348062002586590L;
	private Integer id;
	/**
	 * 事件
	 */
	private Integer ev_id;
	
	/**
	 * 电话记录ID
	 */
	private Integer vo_callid;
	/**
	 * 用户
	 */
	private Integer us_Id;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getEv_id() {
		return ev_id;
	}
	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}
	public Integer getVo_callid() {
		return vo_callid;
	}
	public void setVo_callid(Integer vo_callid) {
		this.vo_callid = vo_callid;
	}
	public Integer getUs_Id() {
		return us_Id;
	}
	public void setUs_Id(Integer us_Id) {
		this.us_Id = us_Id;
	}
}
