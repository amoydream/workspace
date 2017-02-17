package com.lauvan.emergencyplan.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Eme_Supplies;

public interface EmeSuppliesService extends BaseDAO<E_Eme_Supplies> {
	public void addAll(Integer pi_id,String[] su_Ids);
}
