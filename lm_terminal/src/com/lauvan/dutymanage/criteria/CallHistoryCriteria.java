package com.lauvan.dutymanage.criteria;

import java.util.Date;

import org.springframework.beans.BeanUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.criteria.BaseCriteria;
import com.lauvan.dutymanage.entity.V_Call_History;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.organ.entity.C_Organ_Person;

public class CallHistoryCriteria extends BaseCriteria<CallHistoryCriteria, V_Call_History> {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date	vo_time_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date	vo_time_end;

	public CallHistoryCriteria() {
		super(new V_Call_History());
	}

	@Override
	public CallHistoryCriteria copyProperties(Object obj) {
		super.copyProperties(obj);
		getEntity().setOrganPerson(new C_Organ_Person());
		getEntity().setEventInfo(new T_EventInfo());
		BeanUtils.copyProperties(obj, getEntity().getOrganPerson());
		BeanUtils.copyProperties(obj, getEntity().getEventInfo());
		return this;
	}

	public Date getVo_time_start() {
		return vo_time_start;
	}

	public void setVo_time_start(Date vo_time_start) {
		this.vo_time_start = vo_time_start;
	}

	public Date getVo_time_end() {
		return vo_time_end;
	}

	public void setVo_time_end(Date vo_time_end) {
		this.vo_time_end = vo_time_end;
	}
}