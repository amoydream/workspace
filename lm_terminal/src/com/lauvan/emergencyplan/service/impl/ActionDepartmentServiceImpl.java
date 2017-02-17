package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.service.ActionDepartmentService;

@Service("actionDepartmentService")
public class ActionDepartmentServiceImpl extends
		BaseDAOSupport<E_Action_Department> implements ActionDepartmentService {

}
