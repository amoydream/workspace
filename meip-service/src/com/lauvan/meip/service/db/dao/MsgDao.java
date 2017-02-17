package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.MsgItem;
import com.lauvan.meip.service.item.MsgResult;

public abstract interface MsgDao extends BaseDao {
	public abstract MsgResult getMsgById(Integer id);

	public abstract MsgResult getALLMsg();

	public abstract MsgResult getMsgByItem(MsgItem item);

	public abstract MsgResult getMsgPage(MsgItem item);

	public abstract MsgResult getMsgGroupPage(MsgItem item);
}