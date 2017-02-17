package com.lauvan.emergencyplan.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Plan_Organ;
import com.lauvan.emergencyplan.entity.E_Plan_Organ_Id;
import com.lauvan.emergencyplan.entity.E_Plan_Person;
import com.lauvan.emergencyplan.service.PlanOrganService;

@Service("planOrganService")
public class PlanOrganServiceImpl extends BaseDAOSupport<E_Plan_Organ>
		implements PlanOrganService {
	
	public void add(List<E_Plan_Organ> pos) {
		for (E_Plan_Organ po : pos) {
			save(po);
		}
	}
	
	@SuppressWarnings("unchecked")
	public void deleteAll(Integer pi_id,Integer or_id) {
		getList(pi_id, or_id);
		List<E_Plan_Person> pps = em.createQuery("select o from E_Plan_Person o where o.pi_id=?1 and o.or_id=?2").setParameter(1, pi_id).setParameter(2, or_id).getResultList();
		for (E_Plan_Person pp : pps) {
			em.remove(pp);
		}
		delete(new E_Plan_Organ_Id(pi_id, or_id));
	}
	@SuppressWarnings("unchecked")
	protected void getList(Integer pi_id,Integer or_id){
		List<E_Plan_Organ> pos = findByProperty("id.pi_id", pi_id, "por_id", or_id);
		for (E_Plan_Organ po : pos) {
			List<E_Plan_Person> pps = em.createQuery("select o from E_Plan_Person o where o.pi_id=?1 and o.or_id=?2").setParameter(1, pi_id).setParameter(2, po.getId().getOr_id()).getResultList();
			for (E_Plan_Person pp : pps) {
				em.remove(pp);
			}
			em.remove(po);
			getList(pi_id, po.getId().getOr_id());
		}
	}
}
