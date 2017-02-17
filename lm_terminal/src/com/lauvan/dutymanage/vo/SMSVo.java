package com.lauvan.dutymanage.vo;

import java.util.Date;

import com.lauvan.base.vo.BaseVo;
import com.lauvan.util.DateUtil;

public class SMSVo extends BaseVo {
	private static final long	serialVersionUID	= 1L;

	// sms_template
	private Integer				tmpl_id;

	// c_organ_person
	private Integer				pe_id;
	private String[]			pe_id_arr;
	private String				pe_name;

	// c_organ
	private String				or_id;
	private String				or_name;
    
	// t_eventinfo
	private Integer				ev_id;
	private String				ev_name;

	private Integer				bo_id;
	private String				tel_mobile;
	private String[]			tel_mobile_arr;

	private Integer				p_id;
	private String				p_name;

	private Integer				rece_id;
	private String[]			rece_id_arr;
	private Date				recetime;

	private Integer				send_id;
	private String[]			send_id_arr;
	private Date				sendtime;

	private Integer				msg_id;
	private String[]			msg_id_arr;
	private Date				msgtime;
	private Integer				msgtype;

	private String				content;
	private boolean				success;
	private String				msg;
	private Integer				count;

	public Integer getTmpl_id() {
		return tmpl_id;
	}

	public void setTmpl_id(Integer tmpl_id) {
		this.tmpl_id = tmpl_id;
	}

	public Integer getPe_id() {
		return pe_id;
	}

	public void setPe_id(Integer pe_id) {
		this.pe_id = pe_id;
	}

	public String[] getPe_id_arr() {
		return pe_id_arr;
	}

	public void setPe_id_arr(String[] pe_id_arr) {
		this.pe_id_arr = pe_id_arr;
	}

	public String getPe_name() {
		return pe_name;
	}

	public void setPe_name(String pe_name) {
		this.pe_name = pe_name;
	}

	public String getOr_id() {
		return or_id;
	}

	public void setOr_id(String or_id) {
		this.or_id = or_id;
	}

	public String getOr_name() {
		return or_name;
	}

	public void setOr_name(String or_name) {
		this.or_name = or_name;
	}

	public Integer getEv_id() {
		return ev_id;
	}

	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}

	public String getEv_name() {
		return ev_name;
	}

	public void setEv_name(String ev_name) {
		this.ev_name = ev_name;
	}

	public Integer getBo_id() {
		return bo_id;
	}

	public void setBo_id(Integer bo_id) {
		this.bo_id = bo_id;
	}

	public String getTel_mobile() {
		return tel_mobile;
	}

	public void setTel_mobile(String tel_mobile) {
		this.tel_mobile = tel_mobile;
	}

	public String[] getTel_mobile_arr() {
		return tel_mobile_arr;
	}

	public void setTel_mobile_arr(String[] tel_mobile_arr) {
		this.tel_mobile_arr = tel_mobile_arr;
	}

	public Integer getP_id() {
		return p_id;
	}

	public void setP_id(Integer p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public Integer getRece_id() {
		return rece_id;
	}

	public void setRece_id(Integer rece_id) {
		this.rece_id = rece_id;
	}

	public String[] getRece_id_arr() {
		return rece_id_arr;
	}

	public void setRece_id_arr(String[] rece_id_arr) {
		this.rece_id_arr = rece_id_arr;
	}

	public Date getRecetime() {
		return recetime;
	}

	public void setRecetime(Date recetime) {
		this.recetime = recetime;
	}

	public String getRecetimeStr() {
		if(recetime != null) {
			return DateUtil.TIMEFORMAT.format(recetime);
		}
		return "";
	}

	public Integer getSend_id() {
		return send_id;
	}

	public void setSend_id(Integer send_id) {
		this.send_id = send_id;
	}

	public String[] getSend_id_arr() {
		return send_id_arr;
	}

	public void setSend_id_arr(String[] send_id_arr) {
		this.send_id_arr = send_id_arr;
	}

	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	public String getSendtimeStr() {
		if(sendtime != null) {
			return DateUtil.TIMEFORMAT.format(sendtime);
		}
		return "";
	}

	public Integer getMsg_id() {
		return msg_id;
	}

	public void setMsg_id(Integer msg_id) {
		this.msg_id = msg_id;
	}

	public String[] getMsg_id_arr() {
		return msg_id_arr;
	}

	public void setMsg_id_arr(String[] msg_id_arr) {
		this.msg_id_arr = msg_id_arr;
	}

	public Date getMsgtime() {
		return msgtime;
	}

	public void setMsgtime(Date msgtime) {
		this.msgtime = msgtime;
	}

	public String getMsgtimeStr() {
		if(msgtime != null) {
			return DateUtil.TIMEFORMAT.format(msgtime);
		}
		return "";
	}

	public Integer getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(Integer msgtype) {
		this.msgtype = msgtype;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
}
