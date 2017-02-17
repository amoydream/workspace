package com.lauvan.resource.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.resource.entity.R_Supplies_Store;

public interface SuppliesStoreService extends BaseDAO<R_Supplies_Store>{
	
	/**
	 * 查询出最大最小经纬度之间的维保站
	 * @param maxLong
	 * @param minlong
	 * @param maxlat
	 * @param minlat
	 * @param id
	 * @return
	 */
	public List<R_Supplies_Store> getlatlon(Double maxLong,Double minlong,Double maxlat,Double minlat,Integer id);

	public List<R_Supplies_Store> getAllPoints(Double maxLong,Double minlong,Double maxlat,Double minlat, String [] ids);
	
}
