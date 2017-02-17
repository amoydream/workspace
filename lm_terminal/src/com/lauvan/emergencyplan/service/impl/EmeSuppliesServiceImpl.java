package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Eme_Supplies;
import com.lauvan.emergencyplan.service.EmeSuppliesService;
import com.lauvan.resource.entity.R_Supplies;

@Service("emeSuppliesService")
public class EmeSuppliesServiceImpl extends BaseDAOSupport<E_Eme_Supplies> implements EmeSuppliesService {
	
	public void addAll(Integer pi_id,String[] su_Ids) {
		for (String s : su_Ids) {
			save(new E_Eme_Supplies(pi_id,new R_Supplies(Integer.valueOf(s))));
		}
	}
}
