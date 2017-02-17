package com.lauvan.emergencyplan.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Plan_Legal;
import com.lauvan.emergencyplan.service.PlanLegalService;

@Service("planLegalService")
public class PlanLegalServiceImpl extends BaseDAOSupport<E_Plan_Legal>
		implements PlanLegalService {

	public void addAll(List<E_Plan_Legal> plan_Legals) {
		for (E_Plan_Legal e_Plan_Legal : plan_Legals) {
			save(e_Plan_Legal);
		}
	}
}
