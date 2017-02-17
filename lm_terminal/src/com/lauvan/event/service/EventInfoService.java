package com.lauvan.event.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.event.entity.T_EventInfo;

public interface EventInfoService extends BaseDAO<T_EventInfo> {
	/**
	 * 查找没有完成的时间
	 * @param id
	 * @return
	 */
	public List<T_EventInfo> findStatus(String id);
	/**
	 * 事件按年度统计事故数
	 * @return
	 */
	public List<Object> year();
	/**
	 * 事件按级别统计事件数
	 * @return
	 */
	public List<Object> getListLevels();
	
	public List<Object> month();
	/**
	 * 事件区域统计
	 * @return
	 */
	public List<Object> town();
}
