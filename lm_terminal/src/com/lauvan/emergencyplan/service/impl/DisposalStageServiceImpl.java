package com.lauvan.emergencyplan.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.entity.E_Action_List;
import com.lauvan.emergencyplan.entity.E_Disposal_Stage;
import com.lauvan.emergencyplan.service.DisposalStageService;

@Service("disposalStageService")
public class DisposalStageServiceImpl extends BaseDAOSupport<E_Disposal_Stage>
		implements DisposalStageService {

	public void deleteAll(Integer id,List<E_Disposal_Stage> dss,List<E_Action_List> action_Lists,List<E_Action_Department> action_Departments) {
		if (action_Departments!=null) {
			for (E_Action_Department e_Action_Department : action_Departments) {
				em.remove(e_Action_Department);
			}
		}
		if (action_Lists!=null) {
			for (E_Action_List al : action_Lists) {
				em.remove(al);
			}
		}
		if (dss!=null) {
			for (E_Disposal_Stage ds : dss) {
				em.remove(ds);
			}
		}
		delete(id);
	}
}
