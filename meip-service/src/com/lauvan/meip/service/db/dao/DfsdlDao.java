package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.DfsdlItem;
import com.lauvan.meip.service.item.DfsdlResult;

public abstract interface DfsdlDao extends BaseDao {
	public abstract DfsdlResult send(DfsdlItem item);

	public abstract DfsdlResult resend(Integer[] idArr);

	public abstract DfsdlResult getDfsdlById(Integer id);

	public abstract DfsdlResult getALLDfsdl();

	public abstract DfsdlResult getDfsdlByItem(DfsdlItem item);

	public abstract DfsdlResult getDfsdlPage(DfsdlItem item);

	public abstract DfsdlResult delete(Integer[] idArr);

	public abstract DfsdlResult physicalDelete(Integer[] idArr);
}