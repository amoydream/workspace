package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.JsdlItem;
import com.lauvan.meip.service.item.JsdlResult;

public abstract interface JsdlDao extends BaseDao {
	public abstract JsdlResult updateJsdlStatus(Integer id);

	public abstract JsdlResult getLatestJsdl();

	public abstract JsdlResult getJsdlById(Integer id);

	public abstract JsdlResult getALLJsdl();

	public abstract JsdlResult getJsdlByItem(JsdlItem item);

	public abstract JsdlResult getJsdlPage(JsdlItem item);

	public abstract JsdlResult delete(Integer[] idArr);

	public abstract JsdlResult physicalDelete(Integer[] idArr);
}

/*
 * Location: E:\Desktop\classes.zip
 * Qualified Name: classes.com.lauvan.meip.service.db.dao.JsdlDao
 * JD-Core Version: 0.6.0
 */