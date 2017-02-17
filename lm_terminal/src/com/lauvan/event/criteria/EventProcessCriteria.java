package com.lauvan.event.criteria;

import java.util.Date;

import org.springframework.beans.BeanUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.lauvan.base.criteria.BaseCriteria;
import com.lauvan.event.entity.T_Event_Process;

public class EventProcessCriteria extends BaseCriteria<EventProcessCriteria, T_Event_Process> {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date	pr_date_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date	pr_date_end;

	public EventProcessCriteria() {
		super(new T_Event_Process());
	}

	public Date getPr_date_start() {
		return pr_date_start;
	}

	public void setPr_date_start(Date pr_date_start) {
		this.pr_date_start = pr_date_start;
	}

	public Date getPr_date_end() {
		return pr_date_end;
	}

	public void setPr_date_end(Date pr_date_end) {
		this.pr_date_end = pr_date_end;
	}

	@Override
	public EventProcessCriteria copyProperties(Object obj) {
		super.copyProperties(obj);
		BeanUtils.copyProperties(obj, getEntity().getT_eventinfo());
		BeanUtils.copyProperties(obj, getEntity().getT_user_info());
		return this;
	}

}