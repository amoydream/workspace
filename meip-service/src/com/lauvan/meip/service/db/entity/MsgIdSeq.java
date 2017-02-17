package com.lauvan.meip.service.db.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "msgidseq")
public class MsgIdSeq
	implements BaseEntity {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				msgid;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getMsgid() {
		return msgid;
	}

	public void setMsgid(Integer msgid) {
		this.msgid = msgid;
	}
}