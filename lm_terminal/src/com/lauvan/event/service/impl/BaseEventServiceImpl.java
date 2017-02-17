package com.lauvan.event.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.T_BaseEvent;
import com.lauvan.event.service.BaseEventService;

@Service("baseEventService")
public class BaseEventServiceImpl extends BaseDAOSupport<T_BaseEvent> implements
		BaseEventService {
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T_BaseEvent> findStatus(String status) {
		return em.createQuery("select o from T_BaseEvent o where o.be_status <> ?1").setParameter(1, status).getResultList();
	}
}
