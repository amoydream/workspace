package com.lauvan.dutymanage1.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.dutymanage1.entity.T_Duty_Schedule1;
import com.lauvan.dutymanage1.service.DutySchedule1Service;

@Service("dutySchedule1Service")
public class DutySchedule1ServiceImpl extends BaseDAOSupport<T_Duty_Schedule1>
		implements DutySchedule1Service {
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true, propagation = Propagation.REQUIRED)
	public List<T_Duty_Schedule1> getDutys(Object beginDate,Object endDate,String duty_ifleader) {
		List<T_Duty_Schedule1> list = em.createQuery("select o from T_Duty_Schedule1 o where (o.duty_date between ?1 and ?2) and o.duty_ifleader=?3 order by duty_date").setParameter(1, beginDate).setParameter(2, endDate).setParameter(3, duty_ifleader).getResultList();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true, propagation = Propagation.REQUIRED)
	public List<Object> getDutyPersonName(String beginDate,String endDate,String duty_ifleader) {
		return em.createNativeQuery("SELECT distinct op.pe_name, op.pe_id  FROM t_duty_schedule1 ds left join c_organ_person op on ds.pe_id=op.pe_id where (ds.duty_date between ?1 and ?2) and ds.duty_ifleader=?3").setParameter(1, beginDate).setParameter(2, endDate).setParameter(3, duty_ifleader).getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true, propagation = Propagation.REQUIRED)
	public List<T_Duty_Schedule1> getIfDuty(String date, Integer peid){
		return em.createNativeQuery("select * from T_duty_schedule1 where duty_date=?1 and pe_id = ?2").setParameter(1, date).setParameter(2, peid).getResultList();
	}
	
}
