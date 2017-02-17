package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Plan_Legal;

public interface PlanLegalService extends BaseDAO<E_Plan_Legal> {
	public void addAll(List<E_Plan_Legal> plan_Legals);
}
