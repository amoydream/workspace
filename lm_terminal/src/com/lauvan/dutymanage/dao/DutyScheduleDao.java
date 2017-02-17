package com.lauvan.dutymanage.dao;

import java.util.List;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.DutyScheduleCriteria;
import com.lauvan.dutymanage.entity.T_Duty_Schedule;

/**
 * @describe 值班排班Dao层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
public interface DutyScheduleDao extends BaseDAO1<T_Duty_Schedule> {
	QueryResult<T_Duty_Schedule> getScheduleRecords(DutyScheduleCriteria c);

	List<T_Duty_Schedule> getCalendarSchedules(DutyScheduleCriteria c);

	List<T_Duty_Schedule> getScheduleTemplates();
}