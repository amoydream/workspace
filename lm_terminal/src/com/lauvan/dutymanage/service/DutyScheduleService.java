package com.lauvan.dutymanage.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.vo.DutyScheduleVo;

/**
 * @describe 值守日志service层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service
public interface DutyScheduleService {
	QueryResult<DutyScheduleVo> getScheduleRecords(DutyScheduleVo dutyScheduleVo);

	void addDutySchedule(DutyScheduleVo dutyScheduleVo);

	void deleteDutySchedule(Integer id);

	List<DutyScheduleVo> getCalendarSchedule(DutyScheduleVo dutyScheduleVo);

	DutyScheduleVo getDutyScheduleById(Integer id);
	
	boolean isOnDuty(Integer id, Date dutyDate);

	Integer saveDutySchedule(DutyScheduleVo dutyScheduleVo);

	List<DutyScheduleVo> getScheduleTemplates();

	void saveScheduleTemplate(DutyScheduleVo dutyScheduleVo);
	
	void deleteScheduleTemplate(Integer id);
}
