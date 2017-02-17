package com.lauvan.event.vo;

import java.util.Date;

public class EventNoteVo {

	private Integer en_id;
	/**
	 * 事件ID
	 */
	private Integer ev_id;
	/**
	 * 类型（电话1，短信2，传真3，邮箱4,反馈5）
	 */
	private String en_type;
	/**
	 * 外联ID（电话 短信 传真 信息）
	 */
	private Integer en_wid;
	/**
	 * 外联内容
	 */
	private Object wo;
	/**
	 * 创建时间
	 */
	private Date en_date;
	
	private String en_content;

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

	public String getEn_content() {
		return en_content;
	}

	public void setEn_content(String en_content) {
		this.en_content = en_content;
	}

	public Object getWo() {
		return wo;
	}

	public void setWo(Object wo) {
		this.wo = wo;
	}
	
}
