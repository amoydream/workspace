package com.lauvan.emergencyplan.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.entity.E_Action_List;
import com.lauvan.emergencyplan.service.ActionListService;

@Service("actionListService")
public class ActionListServiceImpl extends BaseDAOSupport<E_Action_List>
		implements ActionListService {
	public void deleteAll(Integer id, List<E_Action_Department> ads) {
		for (E_Action_Department ad : ads) {
			em.remove(ad);
		}
		delete(id);
	}
}
