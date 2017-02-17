package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Eme_Expert;
import com.lauvan.emergencyplan.service.EmeExpertService;
import com.lauvan.resource.entity.R_Expert;

@Service("emeExpertService")
public class EmeExpertServiceImpl extends BaseDAOSupport<E_Eme_Expert>
		implements EmeExpertService {
	public void addAll(Integer pi_id, String[] su_Ids) {
		for (String s : su_Ids) {
			save(new E_Eme_Expert(pi_id, new R_Expert(Integer.valueOf(s))));
		}
	}
}
