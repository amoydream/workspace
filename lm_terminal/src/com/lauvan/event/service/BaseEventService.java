package com.lauvan.event.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.event.entity.T_BaseEvent;

public interface BaseEventService extends BaseDAO<T_BaseEvent> {
	public List<T_BaseEvent> findStatus(String status);
}
