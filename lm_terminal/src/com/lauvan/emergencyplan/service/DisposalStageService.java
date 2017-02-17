package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.entity.E_Action_List;
import com.lauvan.emergencyplan.entity.E_Disposal_Stage;

public interface DisposalStageService extends BaseDAO<E_Disposal_Stage> {
	/**
	 * 删除流程，同时要删除流程下面的所有关联
	 * @param id
	 * @param dss
	 * @param action_Lists
	 * @param action_Departments
	 */
	public void deleteAll(Integer id,List<E_Disposal_Stage> dss,List<E_Action_List> action_Lists,List<E_Action_Department> action_Departments);
}
