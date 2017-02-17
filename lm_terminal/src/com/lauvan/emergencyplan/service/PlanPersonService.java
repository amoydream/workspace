package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Plan_Person;

public interface PlanPersonService extends BaseDAO<E_Plan_Person> {
	public void addAll(List<E_Plan_Person> pos);
}
