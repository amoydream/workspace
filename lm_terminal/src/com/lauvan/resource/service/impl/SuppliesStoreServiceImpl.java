package com.lauvan.resource.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Supplies_Store;
import com.lauvan.resource.service.SuppliesStoreService;

@Service("suppliesStoreService")
public class SuppliesStoreServiceImpl extends BaseDAOSupport<R_Supplies_Store> 
implements SuppliesStoreService{
	
	@SuppressWarnings("unchecked")
	public List<R_Supplies_Store> getlatlon(Double maxLong,Double minlong,Double maxlat,Double minlat,Integer id) {
		             
		String sql = "select o from R_Supplies_Store o where o.st_Suppliesid.su_Id=?5 and (o.st_Longitude<=?1 and o.st_Longitude>=?2) and (o.st_Latitude<=?3 and o.st_Latitude>=?4)";
		return em.createQuery(sql).setParameter(1, maxLong).setParameter(2, minlong).setParameter(3, maxlat).setParameter(4, minlat).setParameter(5, id).getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<R_Supplies_Store> getAllPoints(Double maxLong,Double minlong,Double maxlat,Double minlat,String [] idsArray){
		List<R_Supplies_Store> allPoints = new ArrayList<R_Supplies_Store>();
		for(int i=0; i<idsArray.length; i++){
			List<R_Supplies_Store> point = new ArrayList<R_Supplies_Store>();
			String sql = "select o from R_Supplies_Store o where o.st_Suppliesid.su_Id=?5 and (o.st_Longitude<=?1 and o.st_Longitude>=?2) and (o.st_Latitude<=?3 and o.st_Latitude>=?4)";
		    point = em.createQuery(sql).setParameter(1, maxLong).setParameter(2, minlong).setParameter(3, maxlat).setParameter(4, minlat).setParameter(5, Integer.valueOf(idsArray[i])).getResultList();
		    allPoints.addAll(point);
		}
		return allPoints;
	}

}
