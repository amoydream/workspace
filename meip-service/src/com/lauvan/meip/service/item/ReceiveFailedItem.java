package com.lauvan.meip.service.item;

import java.util.Date;

public class ReceiveFailedItem extends Item {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				id;
	private String				fmobile;
	private String[]			fmobiles;
	private String				fcontent;
	private Date				fsendtime;
	private Date				fsendtimeStart;
	private Date				fsendtimeEnd;
	private Integer				fstate;
	private String				remark;
	private Integer				deleted;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFmobile() {
		return fmobile;
	}

	public void setFmobile(String fmobile) {
		this.fmobile = fmobile;
	}

	public String[] getFmobiles() {
		return fmobiles;
	}

	public void setFmobiles(String[] fmobiles) {
		this.fmobiles = fmobiles;
	}

	public String getFcontent() {
		return fcontent;
	}

	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}

	public Date getFsendtime() {
		return fsendtime;
	}

	public void setFsendtime(Date fsendtime) {
		this.fsendtime = fsendtime;
	}

	public Date getFsendtimeStart() {
		return fsendtimeStart;
	}

	public void setFsendtimeStart(Date fsendtimeStart) {
		this.fsendtimeStart = fsendtimeStart;
	}

	public Date getFsendtimeEnd() {
		return fsendtimeEnd;
	}

	public void setFsendtimeEnd(Date fsendtimeEnd) {
		this.fsendtimeEnd = fsendtimeEnd;
	}

	public Integer getFstate() {
		return fstate;
	}

	public void setFstate(Integer fstate) {
		this.fstate = fstate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
}