package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.Jsdl2Item;
import com.lauvan.meip.service.item.Jsdl2Result;

public abstract interface Jsdl2Dao extends BaseDao {
	public abstract Jsdl2Result getJsdl2ById(Integer id);

	public abstract Jsdl2Result getALLJsdl2();

	public abstract Jsdl2Result getJsdl2ByItem(Jsdl2Item item);

	public abstract Jsdl2Result getJsdl2Page(Jsdl2Item item);

	public abstract Jsdl2Result delete(Integer[] idArr);

	public abstract Jsdl2Result physicalDelete(Integer[] idArr);
}