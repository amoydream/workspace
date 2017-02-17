package com.lauvan.dutymanage.dao;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.CallHistoryCriteria;
import com.lauvan.dutymanage.entity.V_Call_History;

/**
 * @describe 电话调度Dao层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
public interface CallHistoryDao extends BaseDAO1<V_Call_History> {
	public QueryResult<V_Call_History> getCallHistoryList(CallHistoryCriteria c);

	public QueryResult<V_Call_History> getPersonalCallHistoryList(CallHistoryCriteria c);

	public QueryResult<V_Call_History> getEventCallHistoryList(CallHistoryCriteria c);

	public Integer getCallHistoryCount(String thatNo, String vo_state);
}