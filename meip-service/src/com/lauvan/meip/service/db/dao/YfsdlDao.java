package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.YfsdlItem;
import com.lauvan.meip.service.item.YfsdlResult;

public abstract interface YfsdlDao extends BaseDao {
	public abstract YfsdlResult getYfsdlById(Integer id);

	public abstract YfsdlResult getALLYfsdl();

	public abstract YfsdlResult getYfsdlByItem(YfsdlItem item);

	public abstract YfsdlResult getYfsdlPage(YfsdlItem item);

	public abstract YfsdlResult delete(Integer[] idArr);

	public abstract YfsdlResult physicalDelete(Integer[] idArr);
}