package com.lauvan.dutymanage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.DutyScheduleCriteria;
import com.lauvan.dutymanage.dao.DutyLogDao;
import com.lauvan.dutymanage.dao.DutyScheduleDao;
import com.lauvan.dutymanage.entity.T_Duty_Log;
import com.lauvan.dutymanage.entity.T_Duty_Schedule;
import com.lauvan.dutymanage.service.DutyLogService;
import com.lauvan.dutymanage.vo.DutyLogVo;

/**
 * @describe 值守日志service层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service(value = "dutyLogService")
public class DutyLogServiceImpl extends BaseDAOSupport<T_Duty_Log> implements DutyLogService {
	@Autowired
	private DutyLogDao		dutyLogDao;

	@Autowired
	private DutyScheduleDao	dutyScheduleDao;

	@Override
	public QueryResult<DutyLogVo> getCurrentMatterList(DutyLogVo dutyLogVo) {
		QueryResult<DutyLogVo> queryResult = new QueryResult<DutyLogVo>();

		QueryResult<T_Duty_Schedule> result = dutyScheduleDao.getScheduleRecords(new DutyScheduleCriteria().copyProperties(dutyLogVo));

		if(result != null) {
			List<DutyLogVo> voList = new ArrayList<DutyLogVo>();
			List<T_Duty_Schedule> resultList = result.getResultlist();
			for(T_Duty_Schedule dutyLog : resultList) {
				DutyLogVo vo = new DutyLogVo();

				BeanUtils.copyProperties(dutyLog, vo);
				BeanUtils.copyProperties(dutyLog.getOrganPerson(), vo);

				voList.add(vo);
			}

			queryResult.setResultlist(voList);
			queryResult.setTotalrecord(result.getTotalrecord());
		}

		return queryResult;
	}
}
