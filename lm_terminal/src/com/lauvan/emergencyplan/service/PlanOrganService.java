package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Plan_Organ;

public interface PlanOrganService extends BaseDAO<E_Plan_Organ> {
	
	public void add(List<E_Plan_Organ> pos);
	
	public void deleteAll(Integer pi_id,Integer eo_Id);
}
