package com.lauvan.dutymanage.service;

import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.vo.CallHistoryVo;

/**
 * @describe 电话调度service层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service
public interface PhoneDispatchService {
	public QueryResult<CallHistoryVo> getCallHistoryGroupList(CallHistoryVo vo);

	public QueryResult<CallHistoryVo> getCallHistoryList(CallHistoryVo vo);

	public QueryResult<CallHistoryVo> getPersonalCallHistoryList(CallHistoryVo vo);
}
