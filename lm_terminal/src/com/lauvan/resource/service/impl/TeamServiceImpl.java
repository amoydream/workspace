package com.lauvan.resource.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Team;
import com.lauvan.resource.service.TeamService;

@Service("teamService")
public class TeamServiceImpl extends BaseDAOSupport<R_Team> implements TeamService{
	
	@SuppressWarnings("unchecked")
	public List<R_Team> getlatlon(Double maxLong,Double minlong,Double maxlat,Double minlat) {
		             
		String sql = "select o from R_Team o where o.te_Id>0 and (o.te_Longitude<=?1 and o.te_Longitude>=?2) and (o.te_Latitude<=?3 and o.te_Latitude>=?4)";
		return em.createQuery(sql).setParameter(1, maxLong).setParameter(2, minlong).setParameter(3, maxlat).setParameter(4, minlat).getResultList();
	}

}
