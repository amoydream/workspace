package com.lauvan.event.dao;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.event.criteria.EventProcessCriteria;
import com.lauvan.event.entity.T_Event_Process;

/**
 * @describe 事务处置过程Dao层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
public interface EventProcessDao extends BaseDAO1<T_Event_Process> {
	public QueryResult<T_Event_Process> getEventProcessList(EventProcessCriteria c);
}