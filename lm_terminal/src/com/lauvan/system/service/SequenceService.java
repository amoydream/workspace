package com.lauvan.system.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.system.entity.T_Sequence;

public interface SequenceService extends BaseDAO<T_Sequence> {
	public Integer nextval(String name);
}
