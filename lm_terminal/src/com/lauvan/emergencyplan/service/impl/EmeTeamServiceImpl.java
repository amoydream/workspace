package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Eme_Team;
import com.lauvan.emergencyplan.service.EmeTeamService;
import com.lauvan.resource.entity.R_Team;
@Service("emeTeamService")
public class EmeTeamServiceImpl extends BaseDAOSupport<E_Eme_Team> implements
		EmeTeamService {
	public void addAll(Integer pi_id,String[] te_Ids) {
		for (String s : te_Ids) {
			save(new E_Eme_Team(pi_id,new R_Team(Integer.valueOf(s))));
		}
	}
}
