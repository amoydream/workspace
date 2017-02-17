package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.ReceiveFailedItem;
import com.lauvan.meip.service.item.ReceiveFailedResult;

public abstract interface ReceiveFailedDao extends BaseDao {
	public abstract ReceiveFailedResult getReceiveFailedById(Integer id);

	public abstract ReceiveFailedResult getALLReceiveFailed();

	public abstract ReceiveFailedResult getReceiveFailedByItem(ReceiveFailedItem item);

	public abstract ReceiveFailedResult getReceiveFailedPage(ReceiveFailedItem item);

	public abstract ReceiveFailedResult delete(Integer[] idArr);

	public abstract ReceiveFailedResult physicalDelete(Integer[] idArr);
}