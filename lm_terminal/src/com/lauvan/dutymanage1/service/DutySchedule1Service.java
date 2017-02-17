package com.lauvan.dutymanage1.service;

import java.util.List;


import com.lauvan.base.dao.BaseDAO;
import com.lauvan.dutymanage1.entity.T_Duty_Schedule1;

public interface DutySchedule1Service extends BaseDAO<T_Duty_Schedule1> {
	/**
	 * 根据日期端查询并排序
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<T_Duty_Schedule1> getDutys(Object beginDate,Object endDate,String duty_ifleader);
	/**
	 * 过滤出在一段时间内不重复的值班人
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<Object> getDutyPersonName(String beginDate,String endDate,String duty_ifleader);
	
	public List<T_Duty_Schedule1> getIfDuty(String date, Integer peid);
	
}
