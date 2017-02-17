package com.lauvan.emergencyplan.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_EmeOrganPerson;
import com.lauvan.emergencyplan.service.EmeOrganPersonService;

@Service("emeOrganPersonService")
public class EmeOrganPersonServiceImpl extends BaseDAOSupport<E_EmeOrganPerson>
		implements EmeOrganPersonService {

	public void addAll(List<E_EmeOrganPerson> eops) {
		for (E_EmeOrganPerson e_EmeOrganPerson : eops) {
			save(e_EmeOrganPerson);
		}
	}
}
