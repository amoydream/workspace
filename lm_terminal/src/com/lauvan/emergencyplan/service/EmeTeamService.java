package com.lauvan.emergencyplan.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_Eme_Team;

public interface EmeTeamService extends BaseDAO<E_Eme_Team> {
	public void addAll(Integer pi_id,String[] te_Ids);
}
