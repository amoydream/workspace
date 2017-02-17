package com.lauvan.resource.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.resource.entity.R_Team;

public interface TeamService extends BaseDAO<R_Team> {
	
	/**
	 * 查询出最大最小经纬度之间的维保站
	 * @param maxLong
	 * @param minlong
	 * @param maxlat
	 * @param minlat
	 * @return
	 */
	public List<R_Team> getlatlon(Double maxLong,Double minlong,Double maxlat,Double minlat);

}
