package com.lauvan.dutymanage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.CallHistoryCriteria;
import com.lauvan.dutymanage.dao.CallHistoryDao;
import com.lauvan.dutymanage.dao.CallHistoryGroupDao;
import com.lauvan.dutymanage.entity.V_Call_History;
import com.lauvan.dutymanage.entity.V_Call_History_Grp;
import com.lauvan.dutymanage.service.PhoneDispatchService;
import com.lauvan.dutymanage.vo.CallHistoryVo;

/**
 * @describe 电话调度service层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service(value = "phoneDispatchService")
public class PhoneDispatchServiceImpl implements PhoneDispatchService {
	@Autowired
	private CallHistoryDao		callHistoryDao;
	@Autowired
	private CallHistoryGroupDao	callHistoryGroupDao;

	@Override
	public QueryResult<CallHistoryVo> getCallHistoryGroupList(CallHistoryVo vo) {
		QueryResult<CallHistoryVo> queryResult = new QueryResult<CallHistoryVo>();

		QueryResult<V_Call_History_Grp> result = callHistoryGroupDao.getCallHistoryList(new CallHistoryCriteria().copyProperties(vo));

		if(result != null) {
			List<CallHistoryVo> voList = new ArrayList<CallHistoryVo>();
			List<V_Call_History_Grp> grpList = result.getResultlist();
			for(V_Call_History_Grp grp : grpList) {
				V_Call_History call = grp.getCallHistory();
				if(call != null) {
					CallHistoryVo callHistoryVO = new CallHistoryVo();
					BeanUtils.copyProperties(call, callHistoryVO);
					if(call.getOrganPerson() != null) {
						BeanUtils.copyProperties(call.getOrganPerson(), callHistoryVO);
					}
					if(call.getEventInfo() != null) {
						BeanUtils.copyProperties(call.getEventInfo(), callHistoryVO);
					}
					callHistoryVO.setGrp_count(callHistoryDao.getCallHistoryCount(call.getVo_thatNo(), vo.getVo_state()));
					voList.add(callHistoryVO);
				}
			}

			queryResult.setResultlist(voList);
			queryResult.setTotalrecord(result.getTotalrecord());
		}

		return queryResult;
	}

	@Override
	public QueryResult<CallHistoryVo> getCallHistoryList(CallHistoryVo vo) {
		QueryResult<CallHistoryVo> queryResult = new QueryResult<CallHistoryVo>();

		QueryResult<V_Call_History> result = callHistoryDao.getCallHistoryList(new CallHistoryCriteria().copyProperties(vo));

		if(result != null) {
			List<CallHistoryVo> voList = new ArrayList<CallHistoryVo>();
			List<V_Call_History> calls = result.getResultlist();
			for(V_Call_History call : calls) {
				CallHistoryVo callHistoryVO = new CallHistoryVo();
				BeanUtils.copyProperties(call, callHistoryVO);
				if(call.getOrganPerson() != null) {
					BeanUtils.copyProperties(call.getOrganPerson(), callHistoryVO);
				}
				if(call.getEventInfo() != null) {
					BeanUtils.copyProperties(call.getEventInfo(), callHistoryVO);
				}
				voList.add(callHistoryVO);
			}

			queryResult.setResultlist(voList);
			queryResult.setTotalrecord(result.getTotalrecord());
		}

		return queryResult;
	}

	@Override
	public QueryResult<CallHistoryVo> getPersonalCallHistoryList(CallHistoryVo vo) {
		QueryResult<CallHistoryVo> queryResult = new QueryResult<CallHistoryVo>();

		QueryResult<V_Call_History> result = callHistoryDao.getPersonalCallHistoryList(new CallHistoryCriteria().copyProperties(vo));

		if(result != null) {
			List<CallHistoryVo> voList = new ArrayList<CallHistoryVo>();
			List<V_Call_History> calls = result.getResultlist();
			for(V_Call_History call : calls) {
				CallHistoryVo callHistoryVO = new CallHistoryVo();
				BeanUtils.copyProperties(call, callHistoryVO);
				if(call.getOrganPerson() != null) {
					BeanUtils.copyProperties(call.getOrganPerson(), callHistoryVO);
				}
				if(call.getEventInfo() != null) {
					BeanUtils.copyProperties(call.getEventInfo(), callHistoryVO);
				}
				voList.add(callHistoryVO);
			}

			queryResult.setResultlist(voList);
			queryResult.setTotalrecord(result.getTotalrecord());
		}

		return queryResult;
	}
}
