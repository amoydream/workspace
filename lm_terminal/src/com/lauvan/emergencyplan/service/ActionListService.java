package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.entity.E_Action_List;

public interface ActionListService extends BaseDAO<E_Action_List> {
	public void deleteAll(Integer id, List<E_Action_Department> ads);
}
