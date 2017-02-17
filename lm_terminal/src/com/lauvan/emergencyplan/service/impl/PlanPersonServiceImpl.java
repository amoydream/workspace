package com.lauvan.emergencyplan.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Plan_Person;
import com.lauvan.emergencyplan.service.PlanPersonService;

@Service("planPersonService")
public class PlanPersonServiceImpl extends BaseDAOSupport<E_Plan_Person>
		implements PlanPersonService {

	public void addAll(List<E_Plan_Person> pos) {
		for (E_Plan_Person e_Plan_Person : pos) {
			save(e_Plan_Person);
		}
	}
}
