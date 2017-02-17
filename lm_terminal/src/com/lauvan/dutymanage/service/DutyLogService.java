package com.lauvan.dutymanage.service;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.entity.T_Duty_Log;
import com.lauvan.dutymanage.vo.DutyLogVo;

/**
 * @describe 值守日志service层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service
public interface DutyLogService extends BaseDAO<T_Duty_Log> {
	QueryResult<DutyLogVo> getCurrentMatterList(DutyLogVo vo);
}
