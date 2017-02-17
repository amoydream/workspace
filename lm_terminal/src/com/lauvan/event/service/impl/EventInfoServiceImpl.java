package com.lauvan.event.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.event.service.EventInfoService;
@Service("eventInfoService")
public class EventInfoServiceImpl extends BaseDAOSupport<T_EventInfo> implements
		EventInfoService {

	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T_EventInfo> findStatus(String status) {
		return em.createQuery("select o from T_EventInfo o where o.ev_status <> ?1").setParameter(1, status).getResultList();
	}
	private final String sqlYear = "select year(ev_date) as years,COUNT(*) as total from t_eventinfo group by year(ev_date)";
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> year() {
		return em.createNativeQuery(sqlYear).getResultList();
	}
	
	private final String sqlLevel = "select year(ev_date) as years, ev_level ,COUNT(*) as total from t_eventinfo  group by years,ev_level order by years,ev_level";
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> getListLevels() {
		return em.createNativeQuery(sqlLevel).getResultList();
	}
	
	private final String sqlMonth = "SELECT year(ev_date),month(ev_date),count(*) FROM t_eventinfo group by year(ev_date),month(ev_date) order by year(ev_date),month(ev_date)";
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> month() {
		return em.createNativeQuery(sqlMonth).getResultList();
	}
	
	private final String sqlTown = "select ev_address_town,count(ev_id) from t_eventinfo GROUP BY ev_address_town";
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> town() {
		return em.createNativeQuery(sqlTown).getResultList();
	}
}
