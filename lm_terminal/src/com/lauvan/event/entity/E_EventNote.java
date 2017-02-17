package com.lauvan.event.entity;

import java.io.Serializable;
import java.util.Date;

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
 * ClassName: E_EventNote 
 * @Description: 处置过程备忘录
 * @author 钮炜炜
 * @date 2016年3月15日 上午9:40:50
 */
@Entity
@Table(name = "e_eventNote")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_EventNote implements Serializable {

	private static final long serialVersionUID = -8083634351916785717L;
	private Integer en_id;
	/**
	 * 事件ID
	 */
	private Integer ev_id;
	/**
	 * 类型（电话1，短信2，传真3，邮箱4,反馈5）
	 */
	private String en_type = "1";
	/**
	 * 外联ID（电话 短信 传真 信息）
	 */
	private Integer en_wid;
	/**
	 * 创建时间
	 */
	private Date en_date = new Date();
	
	private String en_content;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getEn_id() {
		return en_id;
	}

	public void setEn_id(Integer en_id) {
		this.en_id = en_id;
	}

	public Integer getEv_id() {
		return ev_id;
	}

	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}

	@Column(length=1)
	public String getEn_type() {
		return en_type;
	}

	public void setEn_type(String en_type) {
		this.en_type = en_type;
	}

	public Integer getEn_wid() {
		return en_wid;
	}

	public void setEn_wid(Integer en_wid) {
		this.en_wid = en_wid;
	}

	public Date getEn_date() {
		return en_date;
	}

	public void setEn_date(Date en_date) {
		this.en_date = en_date;
	}

	@Column(length=500)
	public String getEn_content() {
		return en_content;
	}

	public void setEn_content(String en_content) {
		this.en_content = en_content;
	}

}
